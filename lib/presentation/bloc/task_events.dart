import 'package:equatable/equatable.dart';
import 'package:task_manager/data/model/task_model.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetTaskEvent extends TaskEvent {}

class CreateTaskEvent extends TaskEvent {
  final TaskModel task;

  const CreateTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final int id;

  const DeleteTaskEvent({required this.id});

  @override
  List<Object> get props => [id];
}
