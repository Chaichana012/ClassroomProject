import 'package:classroomproject/Student/classscreen_student.dart';
import 'package:classroomproject/Student/homescreen_student.dart';
import 'package:classroomproject/Teacher/classscreen.dart';
import 'package:flutter/material.dart';

class joinclassroom extends StatefulWidget {
  const joinclassroom({super.key});

  @override
  State<joinclassroom> createState() => _createclassState();
}

class _createclassState extends State<joinclassroom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Join Class room", style: TextStyle(color: Colors.black)),
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
                buildTextCodeRoom(),
                buildJoinRoom()
              ],
            ),
          )
      ),
    )

    );

  }
  Container buildTextCodeRoom() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            decoration: InputDecoration.collapsed(hintText: "กรอกรหัสห้อง"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildJoinRoom() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: ElevatedButton(
        child: const Text('เข้าร่วมห้อง',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black)
        ),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          padding: EdgeInsets.all(12),
        ),
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => home_studentpage()),
          );
        },
      ),
    );
  }
}

