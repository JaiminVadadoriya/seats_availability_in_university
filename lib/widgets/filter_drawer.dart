import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class FilterDrawer extends StatelessWidget {
  const FilterDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: ElevatedButton(
            child: Text("data"),
            onPressed: null,
          ),
          // child: ListView.separated(
          //   itemBuilder: (BuildContext context, int index) {
          //     return headerItems[index].isButton
          //         ? MouseRegion(
          //             cursor: SystemMouseCursors.click,
          //             child: Container(
          //               decoration: BoxDecoration(
          //                 color: kDangerColor,
          //                 borderRadius: BorderRadius.circular(8.0),
          //               ),
          //               padding: const EdgeInsets.symmetric(horizontal: 28.0),
          //               child: TextButton(
          //                 onPressed: () => headerItems[index].onTap(context),
          //                 child: Text(
          //                   headerItems[index].title,
          //                   style: const TextStyle(
          //                     // color: kBackgroundColor,
          //                     color: Colors.white,
          //                     letterSpacing: 1.75,
          //                     fontSize: 13.0,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           )
          //         : ListTile(
          //             title: GestureDetector(
          //               onTap: () => headerItems[index].onTap(context),
          //               child: Text(
          //                 headerItems[index].title,
          //                 style: const TextStyle(
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //           );
          //   },
          //   separatorBuilder: (BuildContext context, int index) {
          //     return const SizedBox(
          //       height: 10.0,
          //     );
          //   },
          //   itemCount: headerItems.length,
          // ),
        ),
      ),
    );
  }
}
