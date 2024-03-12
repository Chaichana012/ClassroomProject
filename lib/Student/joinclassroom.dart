import 'package:classroomproject/Student/classscreen_student.dart';
import 'package:classroomproject/Student/homescreen_student.dart';
import 'package:classroomproject/Teacher/classscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../classuser.dart';

class joinclassroom extends StatefulWidget {
  const joinclassroom({super.key});

  @override
  State<joinclassroom> createState() => _joinclassroom();
}

class _joinclassroom extends State<joinclassroom> {
  final TextEditingController subjectController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Join Classroom", style: TextStyle(color: Colors.black)),
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
                    buildJoinRoom()
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
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: subjectController,
        decoration: InputDecoration.collapsed(hintText: "ใส่ชื่อวิชา"),
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Container buildJoinRoom() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: ElevatedButton(
        child: const Text(
          'เข้าร่วม Classroom',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          padding: EdgeInsets.all(12),
        ),
        onPressed: () {
          String subject = subjectController.text.trim();
          if (subject.isNotEmpty) {
            FirebaseFirestore.instance
                .collection("classrooms")
                .where('subject', isEqualTo: subject)
                .get()
                .then((QuerySnapshot querySnapshot) {
              if (querySnapshot.docs.isNotEmpty) {
                String classroomCode = querySnapshot.docs[0].id;
                FirebaseFirestore.instance
                    .collection("classrooms")
                    .doc(classroomCode)
                    .update({
                  'member': FieldValue.arrayUnion([Profile.username]),
                }).then((_) {
                  // Navigate to the student home page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          home_studentpage(),
                    ),
                  );
                }).catchError((error) {
                  print("Error joining classroom: $error");
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('ชื่อวิชาไม่ถูกต้อง'),
                ));
                print("Subject or current user is empty");
              }
            }).catchError((error) {
              print("Error querying Firestore: $error");
            });
          } else {
            // Handle empty subject or current user
            print("Subject or current user is empty");
          }
        },
      ),
    );
  }
}

