import 'package:classroomproject/homescreen.dart';
import 'package:classroomproject/registerscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}
class _loginState extends State<login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  signIn() async{
    final String email = emailController.text;
    final String password = passwordController.text;

    try {
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      print("signed in ${userCredential.user?.email}");

      // นำทางไปยังหน้าต่อไปเมื่อเข้าสู่ระบบสำเร็จ
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const homepage()),
      );
    } on FirebaseAuthException catch (error) {
      print(error);
      // แสดงข้อความแจ้งเตือนเมื่อเข้าสู่ระบบไม่สำเร็จ
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("อีเมล์หรือรหัสผ่านไม่ถูกต้อง"),
        ),
      );
    }
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
          signIn();
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
            signIn();
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
          signIn();
        },
        ),
      ),
    );
  }
}
