import 'package:classroomproject/Student/joinclassroom.dart';
import 'package:flutter/material.dart';

class class_studentpage extends StatefulWidget {
  const class_studentpage({super.key});

  @override
  State<class_studentpage> createState() => _classscreen_studentState();
}

class _classscreen_studentState extends State<class_studentpage> {
  @override
  Widget build(BuildContext context) {
    Widget MyFloating_createclass = FloatingActionButton(
      onPressed: () async{
        var MyRespone = await
        Navigator.push(context,MaterialPageRoute(builder: (context)=> joinclassroom()));
      },
      child: Icon(Icons.add),
    );

    return Scaffold(

      floatingActionButton: MyFloating_createclass,
    );
  }
}
