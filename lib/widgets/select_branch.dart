// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SelectBranch extends StatefulWidget {
  static String dropdownvalue = "Computer Engineering";

  const SelectBranch({super.key});
  // Function dropDownFun;

  // SelectBranch({
  //   required this.dropdownvalue,
  //   // required this.dropDownFun,
  // });

  @override
  State<SelectBranch> createState() => _SelectBranchState();
}

class _SelectBranchState extends State<SelectBranch> {
  void dropDownFun(String? value) {
    setState(() {
      SelectBranch.dropdownvalue = value.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: DropdownButton(
            hint: const Text("Select Your Branch"),
            value: SelectBranch.dropdownvalue,
            isExpanded: true,
            borderRadius: const BorderRadius.all(Radius.circular(.2)),
            items: const [
              DropdownMenuItem(
                value: "Computer Engineering",
                child: Text("Computer Engineering"),
              ),
              DropdownMenuItem(
                value: "Mechanical Engineering",
                child: Text("Mechanical Engineering"),
              ),
              DropdownMenuItem(
                value: "Information Technology Engineering",
                child: Text("Information Technology Engineering"),
              ),
            ],
            // value: dropdownvalue,
            onChanged: (value) => dropDownFun(value),
          ),
        ),
        SelectBranch.dropdownvalue.isEmpty
            ? const Text("Please select Branch from above")
            : Container(),
      ],
    );
  }
}
