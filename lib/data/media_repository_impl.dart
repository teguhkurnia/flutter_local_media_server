import 'package:local_media_server/data/sources/remote/media_remote_data_source.dart';
import 'package:local_media_server/domain/entities/media.dart';
import 'package:local_media_server/domain/repositories/media_repository.dart';

class MediaRepositoryImpl implements MediaRepository {
  final MediaRemoteDataSource remoteDataSource;

  MediaRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Media>> fetchMedias({
    required String libraryId,
    int page = 1,
  }) async {
    try {
      return await remoteDataSource.loadMedias(
        libraryId: libraryId,
        page: page,
      );
    } catch (e) {
      throw Exception('Failed to fetch media list: $e');
    }
  }
}
