import 'package:classroomproject/Teacher/createclassscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';


class classpage extends StatefulWidget {
  const classpage({super.key});

  @override
  State<classpage> createState() => _classpageState();
}
class _classpageState extends State<classpage> {

  @override
  Widget build(BuildContext context) {
    Widget MyFloating_addclasspage = FloatingActionButton(
      onPressed: () async{
        var MyRespone = await
        Navigator.push(context,MaterialPageRoute(builder: (context)=>createclasspage()));
      },
      child: Icon(Icons.add),
    );
    return Scaffold(
      floatingActionButton: MyFloating_addclasspage,
    );
  }
}
