import 'package:task_manager/core/utils/typedef.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/domain/entitie/task.dart';

abstract class TaskRepo {
  const TaskRepo();

  ResultFuture<List<Task>> getTask();

  ResultVoid addTask({required TaskModel task});

  ResultVoid deleteTask({required int id});
}
