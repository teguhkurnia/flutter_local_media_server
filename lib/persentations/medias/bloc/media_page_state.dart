part of 'media_page_bloc.dart';

enum MediaPageStatus { initial, loading, fetchMore, loaded, error }

class MediaPageState extends Equatable {
  final MediaPageStatus status;
  final String? errorMessage;
  final List<Media> medias;

  const MediaPageState({
    this.status = MediaPageStatus.initial,
    this.errorMessage,
    this.medias = const [],
  });

  @override
  List<Object?> get props => [status, errorMessage, medias];

  MediaPageState copyWith({
    MediaPageStatus? status,
    String? errorMessage,
    List<Media>? medias,
  }) {
    return MediaPageState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      medias: medias ?? this.medias,
    );
  }
}
