import 'package:local_media_server/domain/entities/server.dart';
import 'package:local_media_server/objectbox.g.dart';

abstract class ServerLocalDataSource {
  Future<void> saveServer(Server data);
  Future<List<Server>> loadServers();
}

class ServerLocalDataSourceImpl implements ServerLocalDataSource {
  final Box<Server> _serverBox;

  ServerLocalDataSourceImpl(Store store) : _serverBox = store.box<Server>();

  @override
  Future<void> saveServer(Server data) async {
    _serverBox.put(data);
  }

  @override
  Future<List<Server>> loadServers() async {
    final servers = _serverBox.getAll();
    return servers;
  }
}
