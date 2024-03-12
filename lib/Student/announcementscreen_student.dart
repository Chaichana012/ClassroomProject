import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../classuser.dart';
class announcements_studentpage extends StatefulWidget {
  const announcements_studentpage({super.key});

  @override
  State<announcements_studentpage> createState() => _announcements_studentpageState();
}

class _announcements_studentpageState extends State<announcements_studentpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
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
