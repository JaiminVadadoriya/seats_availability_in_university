import 'package:flutter/material.dart';
import 'package:seats_availability_in_university/models/student.dart';

import '../pages/home.dart';

class ProfileStudent extends StatelessWidget {
  // const ProfileStudent({super.key});
  Student student = Student.fromMap(userData);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FittedBox(
            child: const CircleAvatar(
              radius: 40,
              // backgroundColor: Theme.of(context).primaryColor,
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Icon(
                  Icons.account_circle,
                  size: 30,
                ),
              ),
            ),
          ),
          Text(
            "${userData['user']}",
            style: TextStyle(fontSize: 29),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "${student}",
                    style: TextStyle(fontSize: 19),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
