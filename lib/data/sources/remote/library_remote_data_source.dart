import 'package:dio/dio.dart';
import 'package:local_media_server/domain/entities/library.dart';
import 'dart:async';

import 'package:local_media_server/domain/entities/server.dart';

abstract class LibraryRemoteDataSource {
  Future<List<Library>> loadLibraries({int page = 1});
}

class LibraryRemoteDataSourceImpl implements LibraryRemoteDataSource {
  final Dio dio;

  LibraryRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<Library>> loadLibraries({int page = 1}) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
        'libraries',
        queryParameters: {'page': page},
      );

      final data = (response.data!['data'] as List<dynamic>)
          .map((e) => Library.fromJson(e))
          .toList();

      return data;
    } catch (e) {
      throw Exception('Failed to fetch libraries: $e');
    }
  }
}
