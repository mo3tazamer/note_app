import 'package:flutter/material.dart';
import 'package:note_app/AddNewNote.dart';
import 'package:note_app/sqldb_model.dart';
import 'package:note_app/Homescreen.dart';

void main() {
  runApp(MyNoteApp());
}

class MyNoteApp extends StatefulWidget {
  const MyNoteApp({super.key});

  @override
  State<MyNoteApp> createState() => _MyNoteAppState();
}

class _MyNoteAppState extends State<MyNoteApp> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: {
          '/x': (context) => AddNewNote(),
        });
  }
}
