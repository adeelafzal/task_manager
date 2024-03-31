import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/presentation/bloc/task_bloc.dart';
import 'package:task_manager/presentation/bloc/task_events.dart';

class AddTaskDialog extends StatelessWidget {
  final TextEditingController title;

  const AddTaskDialog({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Title"),
                controller: title,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: () {
                    if (title.text.trim().isEmpty) return;
                    context.read<TaskBloc>().add(
                        CreateTaskEvent(task: TaskModel(title: title.text)));
                    Navigator.pop(context);
                  },
                  child: const Text("Add Task"))
            ],
          ),
        ),
      ),
    );
  }
}
