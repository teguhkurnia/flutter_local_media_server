import 'package:get_it/get_it.dart';
import 'package:local_media_server/data/library_repository_impl.dart';
import 'package:local_media_server/data/media_repository_impl.dart';
import 'package:local_media_server/data/sources/remote/library_remote_data_source.dart';
import 'package:local_media_server/data/sources/remote/media_remote_data_source.dart';
import 'package:local_media_server/domain/repositories/library_repository.dart';
import 'package:local_media_server/domain/repositories/media_repository.dart';
import 'package:local_media_server/persentations/home/bloc/home_page_bloc.dart';
import 'package:local_media_server/persentations/medias/bloc/media_page_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Remote Data Source
  getIt.registerLazySingleton<LibraryRemoteDataSource>(
    () => LibraryRemoteDataSourceImpl(),
  );
  getIt.registerLazySingleton<MediaRemoteDataSource>(
    () => MediaRemoteDataSourceImpl(),
  );

  // Repositories
  getIt.registerLazySingleton<LibraryRepository>(
    () => LibraryRepositoryImpl(
      remoteDataSource: getIt<LibraryRemoteDataSource>(),
    ),
  );
  getIt.registerLazySingleton<MediaRepository>(
    () => MediaRepositoryImpl(remoteDataSource: getIt<MediaRemoteDataSource>()),
  );

  // Blocs
  getIt.registerFactory(
    () => HomePageBloc(libraryRepository: getIt<LibraryRepository>()),
  );
  getIt.registerFactory(
    () => MediaPageBloc(mediaRepository: getIt<MediaRepository>()),
  );
}
