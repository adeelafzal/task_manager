import 'package:task_manager/core/utils/typedef.dart';
import 'package:task_manager/core/utils/use_case.dart';
import 'package:task_manager/domain/entitie/task.dart';
import 'package:task_manager/domain/repository/task_repo.dart';

class GetTask extends UseCaseWithOutParams<List<Task>> {
  final TaskRepo _repo;

  GetTask(this._repo);

  @override
  ResultFuture<List<Task>> call() async => _repo.getTask();
}
