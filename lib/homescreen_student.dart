import 'package:classroomproject/memberinclassscreen.dart';
import 'package:classroomproject/assignmentscreen_student.dart';
import 'package:classroomproject/classscreen_student.dart';
import 'package:flutter/material.dart';
// หน้า Home ของนักศึกษา

class home_studentpage extends StatefulWidget {
  const home_studentpage({super.key});

  @override
  State<home_studentpage> createState() => _home_studentpageState();
}

class _home_studentpageState extends State<home_studentpage> {

  int MyCurrentIndex = 0; // หน้าเริ่มต้น
  List pages = [class_studentpage(),assignment_studentpage(),memberinclasspage()];
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

    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.blueAccent,
      title: Text("Classroom"),
    ),
      body: pages[MyCurrentIndex],
      bottomNavigationBar: MyNavBar,
    );
  }
}
