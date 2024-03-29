import 'package:classroomproject/Teacher/assignmentscreen.dart';
import 'package:classroomproject/Teacher/createannouncementscreen.dart';
import 'package:classroomproject/Teacher/createassignmentscreen.dart';
import 'package:classroomproject/Teacher/homescreen.dart';
import 'package:classroomproject/Teacher/memberinclassscreen.dart';
import 'package:flutter/material.dart';

//หน้านี้เป็นที่ผู้กดคลิกเข้ามา Classroom อีกที
class classdetailpage extends StatefulWidget {
  final String subject;

  const classdetailpage({required this.subject});

  @override
  State<classdetailpage> createState() => _classdetailpageState();
}

class _classdetailpageState extends State<classdetailpage> {
  int MyCurrentIndex = 0;
  late List pages;

  @override
  void initState() {
    super.initState();
    pages = [
       // ส่ง currentUser ไปยัง classpage
      homepage(),
      assignmentpage(),
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

    Widget MyFloating_createannouncementpage = FloatingActionButton(
      onPressed: () async{
        var MyRespone = await
        Navigator.push(context,MaterialPageRoute(builder: (context)=>createannouncementpage()));
      },
      child: Icon(Icons.add),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(widget.subject),
      ),
      body: pages[MyCurrentIndex],
      bottomNavigationBar: MyNavBar,
      //floatingActionButton: MyFloating_createannouncementpage,
    );
  }
}
