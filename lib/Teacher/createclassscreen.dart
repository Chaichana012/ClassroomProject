import 'package:classroomproject/Teacher/classscreen.dart';
import 'package:classroomproject/Teacher/homescreen.dart';
import 'package:classroomproject/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import '../classuser.dart';

class createclasspage extends StatefulWidget {

  const createclasspage({super.key});

  @override
  State<createclasspage> createState() => _addclasspageState();
}

class _addclasspageState extends State<createclasspage> {

  final TextEditingController SubjectController = TextEditingController();
  late TextEditingController TeacherController = TextEditingController();
  final CollectionReference users = FirebaseFirestore.instance.collection('classrooms');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  Future<void> _save([DocumentSnapshot? documentSnapshot]) async {
    try {
      final Map<String, dynamic> data = {
        "subject": SubjectController.text,
        "teacher": TeacherController.text,
      };
      await users.add(data);
      // ล้างข้อมูลในฟอร์ม
      SubjectController.clear();
      TeacherController.clear();
      // แสดงข้อความว่า "บันทึกข้อมูลเรียบร้อยแล้ว"
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('สร้างชั้นเรียนเรียบร้อย')),
      );
    } catch (e) {
      print('เกิดข้อผิดพลาดในการสร้าง: $e');
    }
  }
  @override
  void initState() {
    super.initState();
    TeacherController = TextEditingController(text: Profile.username); // กำหนดค่าเริ่มต้นให้กับ teacherController
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            title: Text("Create Classroom", style: TextStyle(color: Colors.black))
    ),
        body: Container(
          child: Center(
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                        colors: [Colors.blue, Colors.blue])),
                margin: EdgeInsets.all(32),
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildTextSubject(),
                    buildCreateRoom()
                  ],
                ),
              )
          ),
        )
    );
  }

  Container buildTextSubject() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: SubjectController,
            decoration: InputDecoration.collapsed(hintText: "ชื่อวิชา"),
            style: TextStyle(fontSize: 18)));
  }
  Container buildCreateRoom() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: ElevatedButton(
        child: const Text('สร้างชั้นเรียน',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black)
        ),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          padding: EdgeInsets.all(12),
        ),
        onPressed: () {
          _save();
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }
}
