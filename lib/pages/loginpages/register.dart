import 'package:flutter/material.dart';
import 'package:seats_availability_in_university/pages/institute_detail.dart';
import 'package:seats_availability_in_university/pages/student_detail.dart';

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register Details'),
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Student', icon: Icon(Icons.account_box_rounded)),
              Tab(text: 'Institute', icon: Icon(Icons.account_balance)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StudentDetail(),
            InstituteDetail(),
          ],
        ),
      ),
    );
  }
}
