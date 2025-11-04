import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:task_app/task/presentation/bloc/authors/authors_bloc.dart';

import 'core/constants/urls.dart';
import 'core/network/app_interceptor.dart';
import 'task/data/remote/authors_api_service.dart';
import 'task/data/repositories/authors_repository_impl.dart';
import 'task/domain/repositories/authors_repository.dart';

final sl = GetIt.instance; // sl = service locator

Future<void> init() async {
  final dio = Dio(
    BaseOptions(
      baseUrl: Urls.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
    ),
  );

  dio.interceptors.add(AppInterceptor());

  final authorsApiService = AuthorsApiService(dio);

  sl.registerLazySingleton<AuthorsRepository>(() => AuthorsRepositoryImpl(authorsApiService));

  sl.registerFactory(() => AuthorsBloc(sl()));

  sl.registerLazySingleton<Dio>(() => dio);
}

