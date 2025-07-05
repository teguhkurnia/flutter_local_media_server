part of 'home_page_bloc.dart';

sealed class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object?> get props => [];
}

final class FetchLibrariesEvent extends HomePageEvent {
  const FetchLibrariesEvent({this.page = 1});
  final int page;

  @override
  List<Object?> get props => [page];
}
