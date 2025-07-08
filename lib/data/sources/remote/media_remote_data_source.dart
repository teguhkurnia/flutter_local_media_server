import 'package:dio/dio.dart';
import 'package:local_media_server/domain/entities/media.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

abstract class MediaRemoteDataSource {
  Future<List<Media>> loadMedias({required String libraryId, int page = 1});
}

class MediaRemoteDataSourceImpl implements MediaRemoteDataSource {
  final Dio dio;

  MediaRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<Media>> loadMedias({
    required String libraryId,
    int page = 1,
  }) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        'medias/$libraryId',
        queryParameters: {'page': page, 'per_page': 50},
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data!['data'];

        return data.map((item) => Media.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load medias');
      }
    } catch (e) {
      throw Exception('Failed to load medias: $e');
    }
  }
}
