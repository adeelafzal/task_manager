import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/di/injection_container.dart';
import 'package:task_manager/presentation/bloc/task_bloc.dart';
import 'package:task_manager/presentation/view/task_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TaskBloc>(),
      child: MaterialApp(
        title: 'Task Manager',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          useMaterial3: true,
        ),
        home: const TaskView(),
      ),
    );
  }
}
