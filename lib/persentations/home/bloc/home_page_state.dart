part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  final HomePageStatus status;
  final String? errorMessage;
  final List<Library> libraries;

  const HomePageState({
    this.status = HomePageStatus.initial,
    this.errorMessage,
    this.libraries = const [],
  });

  @override
  List<Object?> get props => [status, errorMessage];

  HomePageState copyWith({
    HomePageStatus? status,
    String? errorMessage,
    List<Library>? libraries,
  }) {
    return HomePageState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      libraries: libraries ?? this.libraries,
    );
  }
}

enum HomePageStatus { initial, loading, loaded, error }
