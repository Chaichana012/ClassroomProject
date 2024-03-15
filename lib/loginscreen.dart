import 'dart:async';
import 'package:classroomproject/Teacher/classscreen.dart';
import 'package:classroomproject/Teacher/homescreen.dart';
import 'package:classroomproject/Student/homescreen_student.dart';
import 'package:classroomproject/registerscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'classuser.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String currentUser = '';

  void checkUsernameAndPassword() async {
    await Firebase.initializeApp();
    final firestore = FirebaseFirestore.instance;
    final Users = usernameController.text;
    final Pass = passwordController.text;

    Stream<QuerySnapshot> snapshots = firestore.collection('users').where('username', isEqualTo: Users).snapshots();
    snapshots.listen((snapshot) {
      for (var doc in snapshot.docs) {
        if (doc['username'.toString()] == Users && doc['password'].toString() == Pass) {

          currentUser = doc['firstname'].toString();

          Profile.setUsername(doc['firstname'].toString());
          Profile.setfirstname(doc['firstname'].toString());
          Profile.setlastname(doc['lastname'].toString());
          Profile.setEmail(doc['email'].toString());

          if (doc['role'] == 'ครู') {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => classpage()));
          } else if (doc['role'] == 'นักเรียน') {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => home_studentpage()));
          } else {
            // แสดงข้อความแจ้งเตือน
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('สิทธิ์การเข้าใช้งานไม่ถูกต้อง'),
            ));
          }
        } else {
          // รหัสและชื่อผู้ใช้งานไม่ถูกต้อง
          // แสดงข้อความแจ้งเตือน
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('ชื่อผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง'),
          ));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ClassRoomApp", style: TextStyle(color: Colors.black)),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.blueGrey[50],
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
                  buildLogo(),
                  buildTextFieldEmail(),
                  buildTextFieldPassword(),
                  buildLogin(),
                  buildOtherLine(),
                  buildRegister(),
                ],
              ),
            )
        ),
      ),
    );
  }
  Widget buildLogo() {
    return Image.asset(
      'asset/EDUCATION_2.png',
      width: 270,
      height: 270,
    );
  }
  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: usernameController,
            decoration: InputDecoration.collapsed(hintText: "ชื่อผู้ใช้งาน"),
            style: TextStyle(fontSize: 18)));
  }
  Container buildTextFieldPassword() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "รหัสผ่าน"),
            style: TextStyle(fontSize: 18)));
  }
  Widget buildOtherLine() {
    return Container(
        margin: EdgeInsets.only(top: 16),
        child: Row(children: <Widget>[
          Expanded(child: Divider(color: Colors.green[800])),
          Padding(
              padding: EdgeInsets.all(6),
              child: Text("ยังไม่ได้สมัครสมาชิก?",
                  style: TextStyle(color: Colors.black87))),
          Expanded(child: Divider(color: Colors.green[800])),
        ]));
  }
  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: InkWell(
        onTap: () {
          checkUsernameAndPassword();
        },
        child: ElevatedButton(
          child: const Text(
            'เข้าสู่ระบบ',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
            shape: StadiumBorder(),
            padding: EdgeInsets.all(12),
          ), onPressed: () {
          checkUsernameAndPassword();
        },
        ),
      ),
    );
  }
  Container buildRegister() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: ElevatedButton(
        child: const Text('สมัครสมาชิก',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.black)
        ),
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          padding: EdgeInsets.all(12),
        ),
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => const registerscreen()),
          );
        },
      ),
    );
  }

}