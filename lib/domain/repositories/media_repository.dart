import 'package:local_media_server/domain/entities/media.dart';

abstract class MediaRepository {
  Future<List<Media>> fetchMedias({required String libraryId, int page = 1});
}
