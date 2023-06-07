import 'package:flutter/material.dart';

import '../models/institute.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.institute});

  final Institute institute;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_rounded),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: const Text("Institute"),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 40,
                child: const Padding(
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
            const SizedBox(
              height: 20,
            ),
            Text(
              "Name: ${institute.name}",
              style: const TextStyle(fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Address: ${institute.address}",
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Ashii code: ${institute.ashiiCode}",
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Email: ${institute.email}",
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Site: ${institute.site}",
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Phone: ${institute.phone}",
              style: const TextStyle(fontSize: 17),
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
        ));
  }
}
