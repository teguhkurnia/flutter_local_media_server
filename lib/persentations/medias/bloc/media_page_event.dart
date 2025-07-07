part of 'media_page_bloc.dart';

sealed class MediaPageEvent extends Equatable {
  const MediaPageEvent();

  @override
  List<Object?> get props => [];
}

final class FetchMediasEvent extends MediaPageEvent {
  const FetchMediasEvent({this.page = 1, required this.libraryId});

  final int page;
  final String libraryId;

  @override
  List<Object?> get props => [page, libraryId];
}

final class FetchMoreMediasEvent extends MediaPageEvent {
  const FetchMoreMediasEvent({this.page = 1, required this.libraryId});

  final int page;
  final String libraryId;

  @override
  List<Object?> get props => [page, libraryId];
}

final class RefreshMediasEvent extends MediaPageEvent {
  const RefreshMediasEvent({required this.libraryId});

  final String libraryId;

  @override
  List<Object?> get props => [libraryId];
}
