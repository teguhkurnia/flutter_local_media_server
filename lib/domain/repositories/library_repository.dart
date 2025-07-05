import 'package:local_media_server/domain/entities/library.dart';

abstract class LibraryRepository {
  Future<List<Library>> fetchLibraries({int page = 1});
}
