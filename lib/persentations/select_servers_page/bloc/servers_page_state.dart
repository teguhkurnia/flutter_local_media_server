part of 'servers_page_bloc.dart';

enum ServersPageStatus { initial, loading, loaded, error }

class ServersPageState extends Equatable {
  final ServersPageStatus status;
  final String? errorMessage;
  final List<Server> servers;
  final Server? selectedServer;

  const ServersPageState({
    this.status = ServersPageStatus.initial,
    this.errorMessage,
    this.servers = const [],
    this.selectedServer,
  });

  String get selectedServerUrl => selectedServer != null
      ? 'http://${selectedServer!.ipAddress}:${selectedServer!.port}/api/v1/'
      : '';

  String get selectedServerHost => selectedServer != null
      ? 'http://${selectedServer!.ipAddress}:${selectedServer!.port}'
      : '';

  @override
  List<Object?> get props => [
    status,
    errorMessage,
    servers,
    selectedServer,
    selectedServerUrl,
    selectedServerHost,
  ];

  ServersPageState copyWith({
    ServersPageStatus? status,
    String? errorMessage,
    List<Server>? servers,
    Server? selectedServer,
  }) {
    return ServersPageState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      servers: servers ?? this.servers,
      selectedServer: selectedServer ?? this.selectedServer,
    );
  }
}
