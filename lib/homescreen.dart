import 'package:classroomproject/classscreen.dart';
import 'package:classroomproject/assignmentscreen.dart.';
import 'package:classroomproject/loginscreen.dart';
import 'package:classroomproject/memberinclassscreen.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {


  int MyCurrentIndex = 0; // หน้าเริ่มต้น
  List pages = [classpage(),assignmentpage(),memberinclasspage()];
  @override
  Widget build(BuildContext context) {

    Widget MyNavBar = BottomNavigationBar(
        currentIndex: MyCurrentIndex,
        onTap: (int index){
          setState(() {
            MyCurrentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.class_),label: 'ห้องเรียน',),
          BottomNavigationBarItem(icon: Icon(Icons.assignment),label: 'งาน',),
          BottomNavigationBarItem(icon: Icon(Icons.people),label: 'สมาชิก'),
        ]);

    return  Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.blueAccent,
      title: Text("Classroom"),
    ),
      body: pages[MyCurrentIndex],
      bottomNavigationBar: MyNavBar,
    );
  }
}
