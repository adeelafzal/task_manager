import 'package:task_manager/core/utils/typedef.dart';
import 'package:task_manager/domain/entitie/task.dart';

class TaskModel extends Task {
  const TaskModel({
    super.id,
    required super.title,
  });

  TaskModel.fromMap(DataMap json)
      : this(
          id: json['id'],
          title: json['title'],
        );

  DataMap toMap() => {
        'id': id,
        'title': title,
      };
}
