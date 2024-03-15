import 'package:classroomproject/text_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../classuser.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  final CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> editField(String field) async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        title: Text("Profile Page"),
          backgroundColor: Colors.blue,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 50),

          //profile pic
         const Icon(
              Icons.person,
              size: 72,
          ),

          const SizedBox(height: 10),

          //user email
          Text(
            Profile.email ?? 'No email found',
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 50),

          //user details
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            'My Details',
            style: TextStyle(color: Colors.black),
            ),
          ),

          //username
          MyTextBox(
            text: Profile.firstname ?? 'No display name found' ,
            sectionName: 'firstname',
            onPressed:()=>editField('firstname'),
          ),

          MyTextBox(
            text: Profile.lastname ?? 'No display name found',
            sectionName: 'lastname',
            onPressed:()=>editField('lastname'),
          ),
        ],
      ),
    );
  }
}
