import 'dart:io';

import 'package:flutter/material.dart';
import 'package:task_app/task/presentation/pages/authors_page.dart';

import 'di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init(); // get_it init

  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: Platform.isAndroid,
      child: MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: Color(0xFF3F51B5),

          ),
          title: 'Authors Demo', home: const AuthorsPage()),
    );
  }
}
