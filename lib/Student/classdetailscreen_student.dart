import 'package:classroomproject/Student/announcementscreen_student.dart';
import 'package:classroomproject/Student/assignmentscreen_student.dart';
import 'package:classroomproject/Teacher/memberinclassscreen.dart';
import 'package:flutter/material.dart';

import '../classuser.dart';

class classdetail_studentpage extends StatefulWidget {
  const classdetail_studentpage({super.key});

  @override
  State<classdetail_studentpage> createState() => _classdetail_studentpageState();
}

class _classdetail_studentpageState extends State<classdetail_studentpage> {
  int MyCurrentIndex = 0;
  late List pages;

  @override
  void initState() {
    super.initState();
    pages = [
      // ส่ง currentUser ไปยัง classpage
      announcements_studentpage(),
      assignment_studentpage(),
      memberinclasspage(),
    ];
  }

  Widget build(BuildContext context) {
    Widget MyNavBar = BottomNavigationBar(
        currentIndex: MyCurrentIndex,
        onTap: (int index){
          setState(() {
            MyCurrentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.newspaper),label: 'ประกาศ',),
          BottomNavigationBarItem(icon: Icon(Icons.assignment),label: 'งาน',),
          BottomNavigationBarItem(icon: Icon(Icons.people),label: 'สมาชิก'),
        ]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('ยินดีต้อนรับสู่วิชา ${Profile.subject}'),
      ),
      body: pages[MyCurrentIndex],
      bottomNavigationBar: MyNavBar,
    );
  }
}

