import 'package:classroomproject/Teacher/memberinclassscreen.dart';
import 'package:classroomproject/Student/assignmentscreen_student.dart';
import 'package:classroomproject/Student/classscreen_student.dart';
import 'package:classroomproject/loginscreen.dart';
import 'package:flutter/material.dart';
// หน้า Home ของนักศึกษา

class home_studentpage extends StatefulWidget {

  final String currentUser;
  const home_studentpage({super.key,required this.currentUser,});

  @override
  State<home_studentpage> createState() => _home_studentpageState();
}

class _home_studentpageState extends State<home_studentpage> {

  int MyCurrentIndex = 0; // หน้าเริ่มต้น
  List pages = [class_studentpage(),assignment_studentpage()];
  void logout() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => login()));
  }
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
          BottomNavigationBarItem(icon: Icon(Icons.class_),label: 'ชั้นเรียน',),
          BottomNavigationBarItem(icon: Icon(Icons.assignment),label: 'งาน',),
        ]);
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.blueAccent,
      title: Center(child: Text('ยินดีต้อนรับ ${widget.currentUser}')),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          icon: Icon(Icons.logout),
          onPressed: logout,
        ),
      ],
    ),
      body: pages[MyCurrentIndex],
      bottomNavigationBar: MyNavBar,
    );
  }
}
