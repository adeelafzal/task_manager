import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/presentation/bloc/task_bloc.dart';
import 'package:task_manager/presentation/bloc/task_events.dart';
import 'package:task_manager/presentation/bloc/task_state.dart';
import 'package:task_manager/presentation/dialog/add_task_dialog.dart';
import 'package:task_manager/presentation/dialog/loading_dialog.dart';
import 'package:task_manager/presentation/widget/task_list_view.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  final title = TextEditingController();

  @override
  void initState() {
    getTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Task Manager"),),
      body: BlocConsumer<TaskBloc, TaskState>(
        listener: (BuildContext context, TaskState state) async {
          if (state is TaskErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is TaskCreatedState) {
            getTask();
          }
        },
        builder: (BuildContext context, TaskState state) {
          return Scaffold(
            body: state is EmptyTaskState
                ? const Center(child: Text("Data Not Found"))
                :state is TaskErrorState
                ? Center(child: Text(state.message))
                : state is GettingTaskState
                ? const Center(child: CircularProgressIndicator())
                : state is TaskLoadedState
                ? TaskListView(tasks: state.tasks)
                :  Text(""),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                await showDialog(
                    context: context,
                    builder: (context) => AddTaskDialog(title: title));
              },
              label: const Text("Add Task"),
              icon: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }

  void getTask() {
    context.read<TaskBloc>().add(GetTaskEvent());
  }
}
