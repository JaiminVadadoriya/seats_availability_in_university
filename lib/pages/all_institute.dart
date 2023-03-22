import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:seats_availability_in_university/pages/details_page.dart';

import '../utils/routes.dart';
import 'home.dart';

class AllInstitute extends StatefulWidget {
  const AllInstitute({super.key});

  @override
  State<AllInstitute> createState() => _AllInstituteState();
}

class _AllInstituteState extends State<AllInstitute> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {});
      },
      child: ListView.builder(
        itemCount: institutes.length,
        // prototypeItem: Container(
        //   height: 90,
        //   width: double.infinity,
        // ),
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("${institutes[index].name} "),
              subtitle: Text("${institutes[index].address} "),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsPage(
                            institute: institutes[index],
                          )),
                );
              },
              trailing: IconButton(
                icon: Icon(
                  institutes[index].isFav
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  color: institutes[index].isFav ? Colors.pink : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    institutes[index].isFav =
                        institutes[index].isFav ? false : true;
                  });
                },
              ),
            ),
          );
          // return ListTile(
          //   title: Text(docIds[index]),
          //   trailing: Icon(Icons.edit),
          //   // isThreeLine: true,
          // );
        },
      ),
    );
  }
}
