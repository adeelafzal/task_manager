import 'package:task_manager/core/utils/database_helper.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/domain/entitie/task.dart';

abstract class TaskDataSource {
  Future<List<Task>> getTasks();

  Future<void> addTask({required TaskModel task});

  Future<void> deleteTask({required int id});
}

class TaskDataSourceImpl implements TaskDataSource {
  final DatabaseHelper _databaseHelper;

  TaskDataSourceImpl(this._databaseHelper);

  @override
  Future<List<Task>> getTasks() async {
    try {
      List<Task> tasks = await _databaseHelper.getTasks();
      return tasks;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addTask({required TaskModel task}) async {
    try {
      await _databaseHelper.insertTask(task);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteTask({required int id}) async {
    try {
      await _databaseHelper.deleteTask(id);
    } catch (e) {
      throw Exception(e);
    }
  }
}
