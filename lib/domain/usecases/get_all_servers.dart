import 'package:local_media_server/domain/entities/server.dart';
import 'package:local_media_server/domain/repositories/server_repository.dart';

class GetAllServers {
  final ServerRepository repository;

  GetAllServers(this.repository);

  Future<List<Server>> call() async {
    return await repository.loadServers();
  }
}
