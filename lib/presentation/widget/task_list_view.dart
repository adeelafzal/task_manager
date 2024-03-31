import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/domain/entitie/task.dart';
import 'package:task_manager/presentation/bloc/task_bloc.dart';
import 'package:task_manager/presentation/bloc/task_events.dart';

class TaskListView extends StatelessWidget {
  final List<Task> tasks;

  const TaskListView({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            tasks[index].title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: IconButton(
              onPressed: () {
                context
                    .read<TaskBloc>()
                    .add(DeleteTaskEvent(id: tasks[index].id!));
              },
              icon: const Icon(Icons.delete)),
        );
      },
      separatorBuilder: (_, int index) => const Divider(),
    );
  }
}
