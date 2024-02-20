import 'package:classroomproject/addclassscreen.dart';
import 'package:flutter/material.dart';

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
        Navigator.push(context,MaterialPageRoute(builder: (context)=>addclasspage()));
      },
      child: Icon(Icons.add),
    );

    return Scaffold(

      floatingActionButton: MyFloating_addclasspage,
    );
  }
}
