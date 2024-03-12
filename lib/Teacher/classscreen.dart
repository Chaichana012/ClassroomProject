import 'package:classroomproject/Teacher/classdetailscreen.dart';
import 'package:classroomproject/Teacher/classscreen.dart';
import 'package:classroomproject/Teacher/createassignmentscreen.dart';
import 'package:classroomproject/Teacher/createclassscreen.dart';
import 'package:classroomproject/Teacher/memberinclassscreen.dart';
import 'package:classroomproject/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../classuser.dart';


class classpage extends StatefulWidget {

  const classpage({super.key});

  @override
  State<classpage> createState() => _classpageState();
}
class _classpageState extends State<classpage> {


  @override
  void logout() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => login()));
  }
  Widget build(BuildContext context) {
    Widget MyFloating_addclasspage = FloatingActionButton(
      onPressed: () async{
        var MyRespone = await
        Navigator.push(context,MaterialPageRoute(builder: (context)=>createclasspage()));
      },
      child: Icon(Icons.add),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Center(child: Text('ยินดีต้อนรับ ${Profile.username}')),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      floatingActionButton: MyFloating_addclasspage,
      body:
      Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('classrooms').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading!");
            }
            // กรองข้อมูลเฉพาะที่ teacher เป็น CurrentUser
            var filteredDocs = snapshot.data!.docs.where((doc) =>
            (doc.data() as Map<String, dynamic>)['teacher'] == Profile.username
            ).toList();

            return ListView(
              children: filteredDocs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;


                return Card(
                  child: ListTile(
                    title: Text(data['subject']),
                    subtitle: Text(data['teacher']),

                    onTap: () {
                      Profile.setSubject(data['subject']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => classdetailpage()
                        ),
                      );
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),

    );
  }
}
