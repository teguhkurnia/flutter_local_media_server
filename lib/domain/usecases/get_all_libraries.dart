import 'package:local_media_server/domain/entities/library.dart';
import 'package:local_media_server/domain/repositories/library_repository.dart';

class GetAllLibraries {
  GetAllLibraries({required LibraryRepository repository})
    : _repository = repository;

  final LibraryRepository _repository;

  Future<List<Library>> call({int page = 1}) async {
    return await _repository.fetchLibraries(page: page);
  }
}
