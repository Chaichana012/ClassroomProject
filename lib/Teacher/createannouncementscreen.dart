import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../classuser.dart';


class createannouncementpage extends StatefulWidget {
  const createannouncementpage({super.key});

  @override
  State<createannouncementpage> createState() => _createannouncementState();
}

class _createannouncementState extends State<createannouncementpage> {
  @override

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final CollectionReference users = FirebaseFirestore.instance.collection(
      'Announcements');
  Timestamp myTimestamp = Timestamp.now();

  Future<void> _save([DocumentSnapshot? documentSnapshot]) async {
    try {
      final Map<String, dynamic> data = {
        "title": titleController.text,
        "content": contentController.text,
        'date': myTimestamp,
        'subject' : Profile.subject,

      };
      await users.add(data);
      // ล้างข้อมูลในฟอร์ม
      titleController.clear();
      contentController.clear();
      // แสดงข้อความว่า "บันทึกข้อมูลเรียบร้อยแล้ว"
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('สร้างเรียบร้อย')),
      );
    } catch (e) {
      print('เกิดข้อผิดพลาดในการสร้าง: $e');
    }
  }

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: Text("Create Announcement"),
        ),
        body: SingleChildScrollView(
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
                    buildTextTitle(),
                    buildTextContent(),
                    buildCreateAnnounce()
                  ],
                ),
              )
          ),
        )
    );
  }

  Container buildTextTitle() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: titleController,
            decoration: InputDecoration.collapsed(hintText: "ชื่อหัวข้อ"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextContent() {
    return Container(
        margin: EdgeInsets.only(top: 12),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: contentController,
            maxLines: null,
            decoration: InputDecoration.collapsed(hintText: "รายละเอียด"),
            style: TextStyle(fontSize: 18)));
  }
  Container buildCreateAnnounce() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: ElevatedButton(
        child: const Text('ยืนยัน',
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