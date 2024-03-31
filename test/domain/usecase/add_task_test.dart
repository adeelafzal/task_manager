import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/domain/repository/task_repo.dart';
import 'package:task_manager/domain/usecases/add_task.dart';

import 'task_repo.mock.dart';

main() {
  late AddTask useCase;
  late TaskRepo repo;
  const params = TaskModel(title: "Flutter Task Management");

  setUpAll(() {
    repo = MockTaskRepo();
    useCase = AddTask(repo);
  });

  test("Add Task", () async {
    when(() => repo.addTask(
      task: const TaskModel(title:"Flutter Task Management")),
    ).thenAnswer((_) async => const Right(null));
    final result = await useCase(params);
    expect(result, equals(const Right(null)));
    verify(() => repo.addTask(task: params)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
