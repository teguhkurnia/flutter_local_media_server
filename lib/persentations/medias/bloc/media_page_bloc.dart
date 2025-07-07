import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:local_media_server/domain/entities/media.dart';
import 'package:local_media_server/domain/repositories/media_repository.dart';

part 'media_page_event.dart';
part 'media_page_state.dart';

class MediaPageBloc extends Bloc<MediaPageEvent, MediaPageState> {
  final MediaRepository _mediaRepository;

  MediaPageBloc({required MediaRepository mediaRepository})
    : _mediaRepository = mediaRepository,
      super(const MediaPageState()) {
    on<FetchMediasEvent>(_onFetchMedias);
    on<FetchMoreMediasEvent>(_onFetchMoreMedias);
  }

  Future<void> _onFetchMedias(
    FetchMediasEvent event,
    Emitter<MediaPageState> emit,
  ) async {
    emit(state.copyWith(status: MediaPageStatus.loading));
    try {
      final List<Media> medias = await _mediaRepository.fetchMedias(
        libraryId: event.libraryId,
        page: event.page,
      );

      emit(state.copyWith(status: MediaPageStatus.loaded, medias: medias));
    } catch (e) {
      emit(
        state.copyWith(
          status: MediaPageStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchMoreMedias(
    FetchMoreMediasEvent event,
    Emitter<MediaPageState> emit,
  ) async {
    emit(state.copyWith(status: MediaPageStatus.fetchMore));
    try {
      final List<Media> medias = await _mediaRepository.fetchMedias(
        libraryId: event.libraryId,
        page: event.page,
      );

      emit(
        state.copyWith(
          status: MediaPageStatus.loaded,
          medias: List.of(state.medias)..addAll(medias),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: MediaPageStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
