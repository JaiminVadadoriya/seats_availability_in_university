import 'package:flutter/material.dart';
import 'package:seats_availability_in_university/pages/home.dart';
import 'package:seats_availability_in_university/widgets/profile_institute.dart';

import '../widgets/profile_student.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 10,
      ),
      child: userData['user'] == "student"
          ? const ProfileStudent()
          : const ProfileInstitute(),
      // Center(
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Expanded(
      //         child: const CircleAvatar(
      //           radius: 40,
      //           child: Padding(
      //             padding: EdgeInsets.all(5),
      //             child: Icon(
      //               Icons.account_circle,
      //               size: 30,
      //             ),
      //           ),
      //         ),
      //       ),
      //       Text(
      //         "${userData['user']}",
      //         style: TextStyle(fontSize: 29),
      //       ),
      //       Expanded(
      //         child: ListView.builder(
      //           itemCount: 3,
      //           itemBuilder: (context, index) {
      //             return ListTile(
      //               title: Text(
      //                 "Admin",
      //                 style: TextStyle(fontSize: 29),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
