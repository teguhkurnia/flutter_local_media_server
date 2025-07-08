import 'package:local_media_server/domain/entities/server.dart';

abstract class ServerRepository {
  Future<void> saveServer(Server data);
  Future<List<Server>> loadServers();
}
