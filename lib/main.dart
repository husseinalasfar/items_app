import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_1/views/add_item_view.dart';
import 'package:task_1/views/choice_view.dart';
import 'package:task_1/views/items_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const ChoiceView(),
    );
  }
}
