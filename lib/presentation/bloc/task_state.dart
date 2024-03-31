import 'package:equatable/equatable.dart';
import 'package:task_manager/domain/entitie/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

class TaskInitialState extends TaskState {
  const TaskInitialState();
}

class EmptyTaskState extends TaskState {}

class CreatingTaskState extends TaskState {}

class GettingTaskState extends TaskState {}

class TaskCreatedState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<Task> tasks;

  const TaskLoadedState(this.tasks);

  @override
  List<Object> get props => tasks.map((e) => e.id!).toList();
}

class TaskErrorState extends TaskState {
  final String message;

  const TaskErrorState(this.message);

  @override
  List<Object> get props => [message];
}
