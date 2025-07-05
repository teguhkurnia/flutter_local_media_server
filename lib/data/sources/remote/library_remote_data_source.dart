import 'package:dio/dio.dart';
import 'package:local_media_server/domain/entities/library.dart';

abstract class LibraryRemoteDataSource {
  Future<List<Library>> loadLibraries({int page = 1});
}

class LibraryRemoteDataSourceImpl implements LibraryRemoteDataSource {
  final dio = Dio();
  @override
  Future<List<Library>> loadLibraries({int page = 1}) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        'http://192.168.0.118:8000/api/v1/libraries',
        queryParameters: {'page': page},
      );

      final data =
          (response.data!['data'] as List<dynamic>)
              .map((e) => Library.fromJson(e))
              .toList();

      return data;
    } catch (e) {
      throw Exception('Failed to fetch libraries: $e');
    }
  }
}
