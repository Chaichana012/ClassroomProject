import 'package:classroomproject/Teacher/memberinclassscreen.dart';
import 'package:classroomproject/Student/assignmentscreen_student.dart';
import 'package:classroomproject/Student/classscreen_student.dart';
import 'package:classroomproject/drawer.dart';
import 'package:classroomproject/loginscreen.dart';
import 'package:flutter/material.dart';

import '../classuser.dart';
import '../profile.dart';
// หน้า Home ของนักศึกษา

class home_studentpage extends StatefulWidget {

  const home_studentpage({super.key});

  @override
  State<home_studentpage> createState() => _home_studentpageState();
}

class _home_studentpageState extends State<home_studentpage> {

  int MyCurrentIndex = 0; // หน้าเริ่มต้น
  List pages = [class_studentpage(),assignment_studentpage()];
  void logout() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => login()));
  }

  //navigate to profile page
  void goToProfilePage() {
    //pop menu drawer
    Navigator.pop(context);

    //go to profile page
    Navigator.push(
        context,
        MaterialPageRoute(
        builder: (context) => const ProfilePage(),
      ),
    );
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
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.blueAccent,
      title: Center(child: Text('ยินดีต้อนรับ ${Profile.username}')),
     // automaticallyImplyLeading: false,
    ),
      drawer: MyDrawer(
          onProfileTap: goToProfilePage,
          onSignOut: logout,
      ),
      body: pages[MyCurrentIndex],
      bottomNavigationBar: MyNavBar,
    );
  }
}
