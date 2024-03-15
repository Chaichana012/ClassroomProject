import 'package:classroomproject/Teacher/classdetailscreen.dart';
import 'package:classroomproject/Teacher/classscreen.dart';
import 'package:classroomproject/Teacher/assignmentscreen.dart.';
import 'package:classroomproject/Teacher/createassignmentscreen.dart';
import 'package:classroomproject/Teacher/homescreen.dart';
import 'package:classroomproject/loginscreen.dart';
import 'package:classroomproject/Teacher/memberinclassscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../classuser.dart';
import 'createannouncementscreen.dart';

class homepage extends StatefulWidget {

  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {

  @override

  @override
  Widget build(BuildContext context) {
    Widget MyFloating_createannouncementpage = FloatingActionButton(
      onPressed: () async{
        var MyRespone = await
        Navigator.push(context,MaterialPageRoute(builder: (context)=>createannouncementpage()));
      },
      child: Icon(Icons.add),
    );

    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: MyFloating_createannouncementpage,

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Announcements').snapshots(),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading!");
          }


          // กรองข้อมูลเฉพาะที่ teacher เป็น CurrentUser
          var filteredDocs = snapshot.data!.docs.where((doc) =>
          (doc.data() as Map<String, dynamic>)['subject'] == Profile.subject
          ).toList();


          return ListView(
            children: filteredDocs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              Timestamp timestamp = data['date'];
              DateTime dateTime = timestamp.toDate();
              String formattedDateTime = DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);

              return Card(
                child: ListTile(
                  title: Text(data['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data['content']),
                      Text(formattedDateTime),
                    ],
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => classdetailpage()
                    //   ),
                    // );
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
