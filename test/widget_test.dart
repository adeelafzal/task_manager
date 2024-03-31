import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_manager/presentation/dialog/add_task_dialog.dart';
import 'package:task_manager/presentation/view/task_view.dart';

void main() {
  testWidgets('TaskView UI Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: TaskView()));

    expect(find.text('Task Manager'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(ListView), findsOneWidget);

    await tester.tap(find.text('Add Task'));
    await tester.pumpAndSettle();
    expect(find.byType(AddTaskDialog), findsOneWidget);

    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();

    expect(find.byType(ListTile), findsNWidgets(1));
  });
}
