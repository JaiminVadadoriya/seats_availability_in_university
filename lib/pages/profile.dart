import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 10,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: const CircleAvatar(
                  radius: 40,
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
                "Admin",
                style: TextStyle(fontSize: 29),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        "Admin",
                        style: TextStyle(fontSize: 29),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
