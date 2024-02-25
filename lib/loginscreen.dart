import 'dart:async';
import 'package:classroomproject/homescreen.dart';
import 'package:classroomproject/registerscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}
class _loginState extends State<login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void checkUsernameAndPassword() async {
    await Firebase.initializeApp();

    final firestore = FirebaseFirestore.instance;
    final Users = emailController.text;
    final Pass = passwordController.text;

    Stream<QuerySnapshot> snapshots = firestore.collection('users').where('username', isEqualTo: Users).snapshots();
    //Stream<QuerySnapshot> snapshots = firestore.collection('User').snapshots();

    snapshots.listen((snapshot) {
      for (var doc in snapshot.docs) {
        if (doc['username'.toString()] == Users && doc['password'].toString() == Pass) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (
              context)
          {
            return homepage();
          }));
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
  Container buildTextFieldEmail() {
    return Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
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
  Container buildLoginstd() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: InkWell(
        onTap: () {

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

        },
        ),
      ),
    );
  }
}
