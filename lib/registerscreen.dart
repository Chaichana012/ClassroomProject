import 'package:classroomproject/loginscreen.dart';
import 'package:flutter/material.dart';

class registerscreen extends StatefulWidget {
  const registerscreen({super.key});

  @override
  State<registerscreen> createState() => _registerscreenState();
}

class _registerscreenState extends State<registerscreen> {

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
        onPressed: () {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => const login()),
          );
        },
      ),
    );
  }
}

