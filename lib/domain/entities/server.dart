import 'package:objectbox/objectbox.dart';

@Entity()
class Server {
  @Id()
  int id = 0;
  String? ipAddress;
  int? port;

  Server({this.ipAddress, this.port});
}
