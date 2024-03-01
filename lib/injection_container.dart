import 'package:clean/features/posts/data/datasources/post_local_datasource.dart';
import 'package:clean/features/posts/data/datasources/post_remote_datasource.dart';
import 'package:clean/features/posts/data/repositories/post_repositories_impl.dart';
import 'package:clean/features/posts/domain/repositories/post.dart';
import 'package:clean/features/posts/domain/usecases/add_post.dart';
import 'package:clean/features/posts/domain/usecases/get_all_posts.dart';
import 'package:clean/features/posts/domain/usecases/delete_post.dart';
import 'package:clean/features/posts/domain/usecases/update_post.dart';
import 'package:clean/features/posts/presentation/blocs/add_delete_update/add_delete_update_bloc.dart';
import 'package:clean/features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:clean/features/users/data/datasources/user_remote_datasource.dart';
import 'package:clean/features/users/data/repositories/user_repositories_impl.dart';
import 'package:clean/features/users/domain/repositories/user.dart';
import 'package:clean/features/users/domain/usecases/add_user.dart';
import 'package:clean/features/users/domain/usecases/delete_user.dart';
import 'package:clean/features/users/domain/usecases/get_all_user.dart';
import 'package:clean/features/users/domain/usecases/update_user.dart';
import 'package:clean/features/users/presentation/blocs/user_bloc.dart';

import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc
  //post
  sl.registerFactory(() => PostBloc(getAllPosts: sl()));
  sl.registerFactory(() => AddDeleteUpdateBloc(
      addPost: sl(), updatePost: sl(), deletePost: sl()));
  //user
  sl.registerFactory(() => UserBloc(getAllUsers: sl(), addUser: sl(), updateUser: sl(),deleteUser: sl()));

// Usecases
  //post
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUSeCase(sl()));
  //user
  sl.registerLazySingleton(() => GetAllUserUseCase(sl()));
  sl.registerLazySingleton(() => AddUserUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserUseCase(sl()));
  sl.registerLazySingleton(() => UpdateUserUseCase(sl()));

// Repository
  //post
  sl.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
  //user
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
      userRemoteDataSource: sl(), networkInfo: sl()));

// Datasources

  //post
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImpl(sharedPreferences : sl()));
  //user
  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl());

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External


  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}