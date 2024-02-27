import 'package:classroomproject/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class registerscreen extends StatefulWidget {
  const registerscreen({super.key});

  @override
  State<registerscreen> createState() => _registerscreenState();
}

class _registerscreenState extends State<registerscreen> {

  final _formKey = GlobalKey<FormState>();
  List<String> list = <String>['กรุณาเลือก','นักเรียน', 'ครู'];
  String role= 'กรุณาเลือก';
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  Future<void> _save([DocumentSnapshot? documentSnapshot]) async {
    try {
      final Map<String, dynamic> data = {
        "username": usernameController.text,
        "firstname": firstnameController.text,
        "lastname": lastnameController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "role": role,
      };
      await users.add(data);
      // ล้างข้อมูลในฟอร์ม
      usernameController.clear();
      firstnameController.clear();
      lastnameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
      setState(() {
        role = 'กรุณาเลือก';
      });

      // แสดงข้อความว่า "บันทึกข้อมูลเรียบร้อยแล้ว"
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('บันทึกข้อมูลเรียบร้อยแล้ว')),
      );
    } catch (e) {
      print('เกิดข้อผิดพลาดในการสร้างหรืออัปเดตเอกสาร: $e');
    }
  }

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
                  buildTextFieldfirstname(),
                  buildTextFieldlastname(),
                  buildTextFieldEmail(),
                  buildTextFieldUsername(),
                  buildTextFieldPassword(),
                  buildTextFieldPassword2(),
                  buildDropdownRole(),
                  buildRegister(),
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
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: emailController,
            decoration: InputDecoration.collapsed(hintText: "อีเมล"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldUsername() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
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

  Container buildTextFieldfirstname() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: firstnameController,
            decoration: InputDecoration.collapsed(hintText: "ชื่อจริง"),
            style: TextStyle(fontSize: 18)));
  }

  Container buildTextFieldlastname() {
    return Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.blue[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: lastnameController,
            decoration: InputDecoration.collapsed(hintText: "นามสกุล"),
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
        onPressed: () async {
          if (passwordController.text != confirmPasswordController.text) {
            // แสดงข้อความแจ้งเตือนรหัสผ่านไม่ตรงกัน
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("รหัสผ่านไม่ตรงกัน กรุณาใส่ใหม่อีกครั้ง"),
              ),
            );
            return;
          }
          if (emailController.text.isEmpty) {
            // แสดงข้อความแจ้งเตือน
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("กรุณากรอกอีเมล"),
              ),
            );
            return;
          }
          _save();
          Navigator.pushReplacement(context,MaterialPageRoute(
              builder: (context){
                return login();
              })
          );
          },
          // final String email = emailController.text.trim();
          // final String password = passwordController.text.trim();
      ),
    );
  }

  Container buildDropdownRole() {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        value: role,
        items: list.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        hint: Text('เลือกสถานะ'),
        onChanged: (String? newValue) {
          setState(() {
            role = newValue!;
          });
        },
      ),
    );
  }
}


