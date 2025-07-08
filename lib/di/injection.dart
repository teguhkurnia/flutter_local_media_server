import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:local_media_server/data/library_repository_impl.dart';
import 'package:local_media_server/data/media_repository_impl.dart';
import 'package:local_media_server/data/server_repository_impl.dart';
import 'package:local_media_server/data/sources/local/server_local_data_source.dart';
import 'package:local_media_server/data/sources/remote/dynamic_base_url_interceptor.dart';
import 'package:local_media_server/data/sources/remote/library_remote_data_source.dart';
import 'package:local_media_server/data/sources/remote/media_remote_data_source.dart';
import 'package:local_media_server/domain/repositories/library_repository.dart';
import 'package:local_media_server/domain/repositories/media_repository.dart';
import 'package:local_media_server/domain/repositories/server_repository.dart';
import 'package:local_media_server/objectbox.g.dart';
import 'package:local_media_server/persentations/home/bloc/home_page_bloc.dart';
import 'package:local_media_server/persentations/medias/bloc/media_page_bloc.dart';
import 'package:local_media_server/persentations/select_servers_page/bloc/servers_page_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies(Store objectBoxStore) {
  // DIO
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.interceptors.add(DynamicBaseUrlInterceptor(getIt<ServersPageBloc>()));
    return dio;
  });

  // ObjectBox
  getIt.registerLazySingleton<Store>(() => objectBoxStore);

  // Remote Data Source
  getIt.registerLazySingleton<LibraryRemoteDataSource>(
    () => LibraryRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  getIt.registerLazySingleton<MediaRemoteDataSource>(
    () => MediaRemoteDataSourceImpl(dio: getIt<Dio>()),
  );

  // Local Data Source
  getIt.registerLazySingleton<ServerLocalDataSource>(
    () => ServerLocalDataSourceImpl(getIt<Store>()),
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
  getIt.registerLazySingleton<ServerRepository>(
    () => ServerRepositoryImpl(localDataSource: getIt<ServerLocalDataSource>()),
  );

  // Blocs
  getIt.registerFactory(
    () => HomePageBloc(libraryRepository: getIt<LibraryRepository>()),
  );
  getIt.registerFactory(
    () => MediaPageBloc(mediaRepository: getIt<MediaRepository>()),
  );
  getIt.registerLazySingleton(
    () => ServersPageBloc(serverRepository: getIt<ServerRepository>()),
  );
}
