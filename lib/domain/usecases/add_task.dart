import 'package:task_manager/core/utils/typedef.dart';
import 'package:task_manager/core/utils/use_case.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/domain/repository/task_repo.dart';

class AddTask extends UseCaseWithParams<void, TaskModel> {
  final TaskRepo _repo;

  AddTask(this._repo);

  @override
  ResultVoid call(params) async => _repo.addTask(task: params);
}
