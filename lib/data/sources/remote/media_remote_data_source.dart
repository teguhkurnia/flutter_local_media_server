import 'package:dio/dio.dart';
import 'package:local_media_server/domain/entities/media.dart';

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
        return data.map((item) => Media.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load medias');
      }
    } catch (e) {
      throw Exception('Failed to load medias: $e');
    }
  }
}
