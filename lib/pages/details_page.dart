import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../models/institute.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.institute});

  @override
  final Institute institute;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text("Institute"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 40,
                child: Padding(
                  padding: EdgeInsets.all(6),
                  child: FittedBox(
                    child: Icon(
                      Icons.account_balance,
                      size: 38,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Name: ${institute.name}",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Address: ${institute.address}",
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Ashii code: ${institute.ashiiCode}",
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Email: ${institute.email}",
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Site: ${institute.site}",
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Phone: ${institute.phone}",
              style: TextStyle(fontSize: 17),
            ),
            SizedBox(
              height: 10,
            ),
          ]),
        ));
  }
}
