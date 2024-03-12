import 'package:classroomproject/Student/joinclassroom.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../classuser.dart';
import 'classdetailscreen_student.dart';

class class_studentpage extends StatefulWidget {
  const class_studentpage({super.key});

  @override
  State<class_studentpage> createState() => _classscreen_studentState();
}

class _classscreen_studentState extends State<class_studentpage> {

  @override
  Widget build(BuildContext context) {
    Widget MyFloating_createclass = FloatingActionButton(
      onPressed: () async{
        var MyRespone = await
        Navigator.push(context,MaterialPageRoute(builder: (context)=> joinclassroom()));
      },
      child: Icon(Icons.add),
    );

    return Scaffold(
      floatingActionButton: MyFloating_createclass,
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

            var filteredDocs = snapshot.data!.docs.where((doc) {
              var members = (doc.data() as Map<String, dynamic>)['member'];
              return members != null && members.contains(Profile.username);
            }).toList();

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
                            builder: (context) => classdetail_studentpage()
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
