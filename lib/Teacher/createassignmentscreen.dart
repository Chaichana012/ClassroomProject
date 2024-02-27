import 'package:flutter/material.dart';

class createassignmentpage extends StatefulWidget {
  const createassignmentpage({super.key});

  @override
  State<createassignmentpage> createState() => _createassignmentpageState();
}

class _createassignmentpageState extends State<createassignmentpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Create Assignment", style: TextStyle(color: Colors.black)),
      ),
    );
  }
}