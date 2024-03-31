import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_manager/domain/entitie/task.dart' as model;
import 'package:task_manager/domain/repository/task_repo.dart';
import 'package:task_manager/domain/usecases/get_task.dart';
import 'task_repo.mock.dart';

main() {
  late GetTask useCase;
  late TaskRepo repo;
  const tResponse = [model.Task(title: "New coding challenge")];
  setUp(() {
    repo = MockTaskRepo();
    useCase = GetTask(repo);
  });
  test("List of Tasks", () async {
    when(() => repo.getTask()).thenAnswer((_) async => const Right(tResponse));
    final result = await useCase();
    expect(result, equals(const Right(tResponse)));
    verify(() => repo.getTask()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
