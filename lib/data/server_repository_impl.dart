import 'package:local_media_server/data/sources/local/server_local_data_source.dart';
import 'package:local_media_server/domain/entities/server.dart';
import 'package:local_media_server/domain/repositories/server_repository.dart';

class ServerRepositoryImpl implements ServerRepository {
  final ServerLocalDataSource localDataSource;

  ServerRepositoryImpl({required this.localDataSource});

  @override
  Future<void> saveServer(Server data) async {
    await localDataSource.saveServer(data);
  }

  @override
  Future<List<Server>> loadServers() async {
    return await localDataSource.loadServers();
  }
}
