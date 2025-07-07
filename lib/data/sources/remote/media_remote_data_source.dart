import 'package:dio/dio.dart';
import 'package:local_media_server/domain/entities/media.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

abstract class MediaRemoteDataSource {
  Future<List<Media>> loadMedias({required String libraryId, int page = 1});
}

class MediaRemoteDataSourceImpl implements MediaRemoteDataSource {
  final dio = Dio();
  @override
  Future<List<Media>> loadMedias({
    required String libraryId,
    int page = 1,
  }) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        'http://192.168.0.118:8000/api/v1/medias/$libraryId',
        queryParameters: {'page': page, 'per_page': 50},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data!['data'];

        // Fetch aspect ratios for each media item
        for (var item in data) {
          if (item['thumbnail_url'] != null && item['thumbnail_url'] != "") {
            item['aspect_ratio'] = await _getNetworkImageAspectRatio(
              item['thumbnail_url'],
            );
          } else {
            item['aspect_ratio'] = 1.0; // Default aspect ratio
          }
        }

        return data.map((item) => Media.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load medias');
      }
    } catch (e) {
      throw Exception('Failed to load medias: $e');
    }
  }

  Future<double> _getNetworkImageAspectRatio(String url) async {
    final http.Response response = await http.get(
      Uri.parse('http://192.168.0.118:8000$url'),
    );
    final Uint8List bytes = response.bodyBytes;
    final ui.Codec codec = await ui.instantiateImageCodec(bytes);
    final ui.FrameInfo frameInfo = await codec.getNextFrame();
    final ui.Image image = frameInfo.image;
    return image.width.toDouble() / image.height.toDouble();
  }
}
