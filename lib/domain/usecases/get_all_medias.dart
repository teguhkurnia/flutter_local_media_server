import 'package:local_media_server/domain/entities/media.dart';
import 'package:local_media_server/domain/repositories/media_repository.dart';

class GetAllMedias {
  GetAllMedias({required MediaRepository repository})
    : _repository = repository;
  final MediaRepository _repository;

  Future<List<Media>> call({String libraryId = '', int page = 1}) async {
    return await _repository.fetchMedias(libraryId: libraryId, page: page);
  }
}
