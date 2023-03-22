import 'dart:ffi';

class Student {
  final String name;
  final String email;
  final Float maths;
  final Float science;
  final Float english;
  final List<String> fav;

  Student(
    this.email, {
    required this.name,
    required this.maths,
    required this.science,
    required this.english,
    required this.fav,
  });
}
