import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/usecases/add_task.dart';
import 'package:task_manager/domain/usecases/delete_task.dart';
import 'package:task_manager/domain/usecases/get_task.dart';
import 'package:task_manager/presentation/bloc/task_events.dart';
import 'package:task_manager/presentation/bloc/task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTask _getTask;
  final AddTask _addTask;
  final DeleteTask _deleteTask;

  TaskBloc({
    required GetTask getTask,
    required AddTask addTask,
    required DeleteTask deleteTask,
  })  : _getTask = getTask,
        _addTask = addTask,
        _deleteTask = deleteTask,
        super(const TaskInitialState()) {
    on<GetTaskEvent>(_onGetTaskEvent);
    on<CreateTaskEvent>(_onCreateTaskEvent);
    on<DeleteTaskEvent>(_onDeleteTaskEvent);
  }

  Future<void> _onGetTaskEvent(
    GetTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(GettingTaskState());
    final result = await _getTask();
    result.fold(
      (failure) => emit(TaskErrorState(failure)),
      (tasks) => emit(tasks.isEmpty?EmptyTaskState():TaskLoadedState(tasks)),
    );
  }

  Future<void> _onCreateTaskEvent(
    CreateTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    emit(CreatingTaskState());
    final result = await _addTask(event.task);
    result.fold(
      (failure) => emit(TaskErrorState(failure)),
      (_) => emit(TaskCreatedState()),
    );
  }

  Future<void> _onDeleteTaskEvent(
    DeleteTaskEvent event,
    Emitter<TaskState> emit,
  ) async {
    final result = await _deleteTask(event.id);
    result.fold(
      (failure) => emit(TaskErrorState(failure)),
      (_) => emit(TaskCreatedState()),
    );
  }
}
