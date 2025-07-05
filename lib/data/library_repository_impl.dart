import 'package:local_media_server/data/sources/remote/library_remote_data_source.dart';
import 'package:local_media_server/domain/entities/library.dart';
import 'package:local_media_server/domain/repositories/library_repository.dart';

class LibraryRepositoryImpl implements LibraryRepository {
  final LibraryRemoteDataSource _remoteDataSource;
  // final LibraryLocalDataSource localDataSource;

  LibraryRepositoryImpl({
    required remoteDataSource,
    // required this.localDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<List<Library>> fetchLibraries({int page = 1}) async {
    try {
      final libraries = await _remoteDataSource.loadLibraries(page: page);

      return libraries;
    } catch (e) {
      // Handle any errors that occur during the fetch
      print('Error fetching libraries: $e');
      return [];
    }
  }
}
