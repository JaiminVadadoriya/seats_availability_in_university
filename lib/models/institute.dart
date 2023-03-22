class Institute {
  final String name;
  final String email;
  final int ashiiCode;
  final int minMarks;
  final String address;
  bool isFav;
  final String site;
  final String phone;
  List<String> branch;

  Institute({
    required this.name,
    required this.email,
    required this.ashiiCode,
    required this.address,
    required this.isFav,
    required this.site,
    required this.phone,
    required this.branch,
    required this.minMarks,
  });
}
