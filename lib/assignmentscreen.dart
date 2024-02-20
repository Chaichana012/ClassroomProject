import 'package:classroomproject/createassignmentscreen.dart';
import 'package:flutter/material.dart';

class assignmentpage extends StatefulWidget {
  const assignmentpage({super.key});

  @override
  State<assignmentpage> createState() => _assignmentpageState();
}

class _assignmentpageState extends State<assignmentpage> {
  @override
  Widget build(BuildContext context) {
    Widget MyFloating_createclass = FloatingActionButton(
      onPressed: () async{
        var MyRespone = await
        Navigator.push(context,MaterialPageRoute(builder: (context)=>createassignmentpage()));
      },
      child: Icon(Icons.add),
    );

    return Scaffold(
      floatingActionButton: MyFloating_createclass,
    );
  }
}
