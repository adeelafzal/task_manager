import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/domain/entitie/task.dart' as model;
import 'package:task_manager/domain/usecases/add_task.dart';
import 'package:task_manager/domain/usecases/delete_task.dart';
import 'package:task_manager/domain/usecases/get_task.dart';
import 'package:task_manager/presentation/bloc/task_bloc.dart';
import 'package:task_manager/presentation/bloc/task_events.dart';
import 'package:task_manager/presentation/bloc/task_state.dart';
import 'package:bloc_test/bloc_test.dart';

class MockGetTask extends Mock implements GetTask {}

class MockAddTask extends Mock implements AddTask {}

class MockDeleteTask extends Mock implements DeleteTask {}

main() {
  late GetTask getTask;
  late AddTask addTask;
  late DeleteTask deleteTask;
  late TaskBloc taskBloc;

  setUp(() {
    getTask = MockGetTask();
    addTask = MockAddTask();
    deleteTask = MockDeleteTask();
    taskBloc =
        TaskBloc(getTask: getTask, addTask: addTask, deleteTask: deleteTask);
  });

  tearDown(() => taskBloc.close());

  group('Task Bloc test', () {
    test("initial state should be ", () async {
      expect(taskBloc.state, const TaskInitialState());
    });

    blocTest<TaskBloc, TaskState>(
      'emits [GettingTaskState, EmptyTaskState] when GetTask returns an empty list',
      build: () {
        when(getTask.call).thenAnswer((_) async => const Right([]));
        return taskBloc;
      },
      act: (bloc) => bloc.add(GetTaskEvent()),
      expect: () => [
        GettingTaskState(),
        EmptyTaskState(),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [GettingTaskState, TaskLoadedState] when GetTask returns tasks',
      build: () {
        final tasks = [const model.Task(id: 1, title: 'Task 1')];
        when(getTask.call).thenAnswer((_) async => Right(tasks));
        return taskBloc;
      },
      act: (bloc) => bloc.add(GetTaskEvent()),
      expect: () => [
        GettingTaskState(),
        const TaskLoadedState([model.Task(id: 1, title: 'Task 1')]),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [CreatingTaskState, TaskCreatedState] when CreateTaskEvent is added',
      build: () => taskBloc,
      act: (bloc) {
        const task = TaskModel(id: 1, title: 'Task 1');
        when(addTask.call(task) as Function()).thenAnswer((_) async => const Right(null));
        bloc.add(const CreateTaskEvent(task: task));
      },
      expect: () => [
        CreatingTaskState(),
        TaskCreatedState(),
      ],
    );

    blocTest<TaskBloc, TaskState>(
      'emits [TaskErrorState] when DeleteTaskEvent is added and DeleteTask fails',
      build: () => taskBloc,
      act: (bloc) {
        const int id = 1;
        when(deleteTask.call(id) as Function()).thenAnswer((_) async => const Left("Failed"));
        bloc.add(const DeleteTaskEvent(id: id));
      },
      expect: () => [
        isA<TaskErrorState>(),
      ],
    );
  });
}
