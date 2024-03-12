import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../classuser.dart';

class memberinclasspage extends StatefulWidget {
  const memberinclasspage({super.key});

  @override
  State<memberinclasspage> createState() => _peopleinclasspageState();
}

class _peopleinclasspageState extends State<memberinclasspage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, left: 15, bottom: 10),
            child: Text(
              "Teachers",
              style: TextStyle(
                fontSize: 24, // ขนาดข้อความ
                fontWeight: FontWeight.bold, // ตัวหน้า
              ),
            ),
          ),

          Container(
            child: Divider(
              color: Colors.black,
              thickness: 1.5,
              indent: 20,
              endIndent: 20,
            ),
          ),

          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('classrooms')
                  .where('subject', isEqualTo: Profile.subject)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('เกิดข้อผิดพลาด');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("กำลังโหลดข้อมูล...");
                }

                var filteredDocs = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredDocs.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map<String, dynamic> data = filteredDocs[index].data() as Map<String, dynamic>;

                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data['teacher']),
                          // เพิ่มรายละเอียดอื่น ๆ ที่คุณต้องการแสดงเกี่ยวกับอาจารย์
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: 30, left: 15, bottom: 10),
            child: Text(
              "Students",
              style: TextStyle(
                fontSize: 24, // ขนาดข้อความ
                fontWeight: FontWeight.bold, // ตัวหน้า
              ),
            ),
          ),

          Container(
            child: Divider(
              color: Colors.black,
              thickness: 1.5,
              indent: 20,
              endIndent: 20,
            ),
          ),

          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('classrooms')
                  .where('subject', isEqualTo: Profile.subject)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading!");
                }
                // กรองข้อมูลเฉพาะที่ teacher เป็น CurrentUser
                var filteredDocs = snapshot.data!.docs;

                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: filteredDocs.length,
                    itemBuilder: (BuildContext context, int index) {
                  Map<String, dynamic> data = filteredDocs[index].data() as Map<String, dynamic>;
                  List<dynamic> dataArray = data['member']; // เปลี่ยน 'your_array_key' เป็น key ของ array ของคุณ
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: dataArray.map((item) => Text(item.toString())).toList(),
                    ),
                    );
                  }
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}