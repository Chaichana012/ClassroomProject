import 'package:classroomproject/createclassscreen.dart';
import 'package:classroomproject/loginscreen.dart';
import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  int MyCurrentIndex = 0; // หน้าเริ่มต้น
  //List pages = [PageHome(),PageAccount(),PageSetting()];

  @override
  Widget build(BuildContext context) {
    Widget MyFloating = FloatingActionButton(
      onPressed: () async{
        var MyRespone = await
        Navigator.push(context,MaterialPageRoute(builder: (context)=>createclass()));
      },
      child: Icon(Icons.add),
    );
    Widget MyNavBar = BottomNavigationBar(
        currentIndex: MyCurrentIndex,
        onTap: (int index){
          setState(() {
            MyCurrentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.assignment),label: 'งาน',),
          BottomNavigationBarItem(icon: Icon(Icons.people),label: 'สมาชิก'),
        ]);
    return  Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.blueAccent,
      title: Text("Classroom"),

    ),
      bottomNavigationBar: MyNavBar,
      floatingActionButton: MyFloating,
    );
  }
}
