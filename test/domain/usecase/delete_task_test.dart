import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manager/domain/repository/task_repo.dart';
import 'package:task_manager/domain/usecases/delete_task.dart';

import 'task_repo.mock.dart';

main() {
  late DeleteTask useCase;
  late TaskRepo repo;
  const params = 1;

  setUpAll(() {
    repo = MockTaskRepo();
    useCase = DeleteTask(repo);
  });

  test("Delete Task", () async {
    when(() => repo.deleteTask(id: 1),
    ).thenAnswer((_) async => const Right(null));
    final result = await useCase(params);
    expect(result, equals(const Right(null)));
    verify(() => repo.deleteTask(id: params)).called(1);
    verifyNoMoreInteractions(repo);
  });
}
