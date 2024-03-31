import 'package:task_manager/core/utils/typedef.dart';
import 'package:task_manager/core/utils/use_case.dart';
import 'package:task_manager/domain/repository/task_repo.dart';

class DeleteTask extends UseCaseWithParams<void, int> {
  final TaskRepo _repo;

  DeleteTask(this._repo);

  @override
  ResultVoid call(params) async => _repo.deleteTask(id: params);
}
