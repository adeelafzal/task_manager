import 'package:get_it/get_it.dart';
import 'package:task_manager/core/utils/database_helper.dart';
import 'package:task_manager/data/datasource/data_source.dart';
import 'package:task_manager/data/repository/task_repo_impl.dart';
import 'package:task_manager/domain/repository/task_repo.dart';
import 'package:task_manager/domain/usecases/add_task.dart';
import 'package:task_manager/domain/usecases/delete_task.dart';
import 'package:task_manager/domain/usecases/get_task.dart';
import 'package:task_manager/presentation/bloc/task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(
        () => TaskBloc(getTask: sl(), addTask: sl(), deleteTask: sl()))
    ..registerLazySingleton(() => GetTask(sl()))
    ..registerLazySingleton(() => AddTask(sl()))
    ..registerLazySingleton(() => DeleteTask(sl()))
    ..registerLazySingleton<TaskRepo>(() => TaskRepoImpl(sl()))
    ..registerLazySingleton<TaskDataSource>(() => TaskDataSourceImpl(sl()))
    ..registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
