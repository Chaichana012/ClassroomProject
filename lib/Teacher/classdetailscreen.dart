import 'package:classroomproject/Teacher/createannouncementscreen.dart';
import 'package:flutter/material.dart';

//หน้านี้เป็นที่ผู้กดคลิกเข้ามา Classroom อีกที
class classdetailpage extends StatefulWidget {
  const classdetailpage({super.key});

  @override
  State<classdetailpage> createState() => _classdetailpageState();
}

class _classdetailpageState extends State<classdetailpage> {
  @override
  Widget build(BuildContext context) {
    Widget MyFloating_createannouncementpage = FloatingActionButton(
      onPressed: () async{
        var MyRespone = await
        Navigator.push(context,MaterialPageRoute(builder: (context)=>createannouncementpage()));
      },
      child: Icon(Icons.add),
    );

    return Scaffold(
      floatingActionButton: MyFloating_createannouncementpage,
    );
  }
}
