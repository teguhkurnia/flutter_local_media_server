import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_media_server/domain/entities/server.dart';
import 'package:local_media_server/domain/repositories/server_repository.dart';

part 'servers_page_event.dart';
part 'servers_page_state.dart';

class ServersPageBloc extends Bloc<ServersPageEvent, ServersPageState> {
  final ServerRepository _serverRepository;

  ServersPageBloc({required ServerRepository serverRepository})
    : _serverRepository = serverRepository,
      super(const ServersPageState()) {
    on<FetchServersEvent>(_onFetchServers);
    on<AddServerEvent>(_onAddServer);
    on<SelectServerEvent>(_onSelectServer);
  }

  Future<void> _onFetchServers(
    FetchServersEvent event,
    Emitter<ServersPageState> emit,
  ) async {
    emit(state.copyWith(status: ServersPageStatus.loading));
    try {
      final List<Server> servers = await _serverRepository.loadServers();
      emit(state.copyWith(status: ServersPageStatus.loaded, servers: servers));
    } catch (e) {
      emit(
        state.copyWith(
          status: ServersPageStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onAddServer(
    AddServerEvent event,
    Emitter<ServersPageState> emit,
  ) async {
    emit(state.copyWith(status: ServersPageStatus.loading));
    try {
      await _serverRepository.saveServer(event.server);
      emit(
        state.copyWith(
          status: ServersPageStatus.loaded,
          servers: List.from(state.servers)..add(event.server),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ServersPageStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onSelectServer(
    SelectServerEvent event,
    Emitter<ServersPageState> emit,
  ) async {
    emit(state.copyWith(selectedServer: event.server));
  }
}
