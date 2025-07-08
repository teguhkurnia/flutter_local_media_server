part of 'servers_page_bloc.dart';

sealed class ServersPageEvent extends Equatable {
  const ServersPageEvent();

  @override
  List<Object?> get props => [];
}

final class FetchServersEvent extends ServersPageEvent {
  const FetchServersEvent();

  @override
  List<Object?> get props => [];
}

final class AddServerEvent extends ServersPageEvent {
  final Server server;

  const AddServerEvent(this.server);

  @override
  List<Object?> get props => [server];
}

final class SelectServerEvent extends ServersPageEvent {
  final Server server;

  const SelectServerEvent(this.server);

  @override
  List<Object?> get props => [server];
}
