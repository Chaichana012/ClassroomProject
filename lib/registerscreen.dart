import 'package:classroomproject/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class registerscreen extends StatefulWidget {
  const registerscreen({super.key});

  @override
  State<registerscreen> createState() => _registerscreenState();
}

class _registerscreenState extends State<registerscreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  int MyCurrentIndex = 0; // หน้าเริ่มต้น
  //List pages = [PageHome(),PageAccount(),PageSetting()];

  @override
    Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
        title: Text("ClassRoomApp", style: TextStyle(color: Colors.black)),
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
                  buildTextFieldPassword2(),
                  buildRegister()
                  //buildButtonRegister()
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
  Container buildTextFieldPassword2() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration.collapsed(hintText: "ยืนยันรหัสผ่าน"),
            style: TextStyle(fontSize: 18)));
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
        onPressed: () async{
          if (passwordController.text != confirmPasswordController.text) {
            // แสดงข้อความแจ้งเตือนรหัสผ่านไม่ตรงกัน
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("รหัสผ่านไม่ตรงกัน กรุณาใส่ใหม่อีกครั้ง"),
              ),
            );
            return;
          }
          final String email = emailController.text.trim();
          final String password = passwordController.text.trim();

          try {
            final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
              email: email,
              password: password,
            );
            print("registered ${userCredential.user?.email}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("สมัครสมาชิกสำเร็จ"),
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const login()),
            );

          }on FirebaseAuthException catch (error) {
            print(error);
            // แสดงข้อความแจ้งเตือน when error occurs
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("ล้มเหลว"),
              ),
            );
          }
        },
      ),
    );
  }
}

