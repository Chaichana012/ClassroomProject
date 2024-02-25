import 'package:flutter/material.dart';

class addclasspage extends StatefulWidget {
  const addclasspage({super.key});

  @override
  State<addclasspage> createState() => _addclasspageState();
}

class _addclasspageState extends State<addclasspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add Classroom", style: TextStyle(color: Colors.black)))
    );
  }
}
