import 'package:flutter/material.dart';


class createannouncementpage extends StatefulWidget {
  const createannouncementpage({super.key});

  @override
  State<createannouncementpage> createState() => _createannouncementState();
}

class _createannouncementState extends State<createannouncementpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Create Announcement"),
      ),
    );
  }
}
