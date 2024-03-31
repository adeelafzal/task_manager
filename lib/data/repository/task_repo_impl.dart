import 'package:dartz/dartz.dart';
import 'package:task_manager/core/utils/typedef.dart';
import 'package:task_manager/data/datasource/data_source.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/domain/entitie/task.dart' as model;
import 'package:task_manager/domain/repository/task_repo.dart';

class TaskRepoImpl implements TaskRepo {
  final TaskDataSource _taskDataSource;

  TaskRepoImpl(this._taskDataSource);

  @override
  ResultFuture<List<model.Task>> getTask() async {
    try {
      final result = await _taskDataSource.getTasks();
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ResultVoid addTask({required TaskModel task}) async {
    try {
      await _taskDataSource.addTask(task: task);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  ResultVoid deleteTask({required int id}) async {
    return Left("Error");
    // try {
    //   await _taskDataSource.deleteTask(id: id);
    //   return const Right(null);
    // } catch (e) {
    //   return Left(e.toString());
    // }
  }
}
