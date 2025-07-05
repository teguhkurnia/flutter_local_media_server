import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_media_server/domain/entities/library.dart';
import 'package:local_media_server/domain/entities/media.dart';
import 'package:local_media_server/domain/repositories/library_repository.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final LibraryRepository _libraryRepository;

  HomePageBloc({required LibraryRepository libraryRepository})
    : _libraryRepository = libraryRepository,
      super(const HomePageState()) {
    on<FetchLibrariesEvent>(_onFetchLibraries);
  }

  Future<void> _onFetchLibraries(
    FetchLibrariesEvent event,
    Emitter<HomePageState> emit,
  ) async {
    emit(state.copyWith(status: HomePageStatus.loading));
    try {
      final libraries = await _libraryRepository.fetchLibraries(
        page: event.page,
      );

      emit(state.copyWith(status: HomePageStatus.loaded, libraries: libraries));
    } catch (e) {
      emit(
        state.copyWith(
          status: HomePageStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
