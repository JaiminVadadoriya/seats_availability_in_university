// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Student {
  final String uid;
  final String user;
  final String password;
  final String name;
  final String email;
  final String seatNo;
  final int meritNo;
  final int maths;
  final int science;
  final int english;
  final int socialScience;
  final int gujrati;
  final List<String> fav;
  final bool isSeatConf;
  final String confbranch;
  final String confinstitute;

  Student({
    required this.meritNo,
    required this.uid,
    required this.user,
    required this.password,
    required this.name,
    required this.email,
    required this.seatNo,
    required this.maths,
    required this.science,
    required this.english,
    required this.socialScience,
    required this.gujrati,
    required this.fav,
    required this.isSeatConf,
    required this.confbranch,
    required this.confinstitute,
  });

  Student copyWith({
    String? uid,
    String? user,
    String? password,
    String? name,
    String? email,
    String? seatNo,
    int? meritNo,
    int? maths,
    int? science,
    int? english,
    int? socialScience,
    int? gujrati,
    List<String>? fav,
    bool? isSeatConf,
    String? confbranch,
    String? confinstitute,
  }) {
    return Student(
      uid: uid ?? this.uid,
      user: user ?? this.user,
      name: name ?? this.name,
      email: email ?? this.email,
      seatNo: seatNo ?? this.seatNo,
      maths: maths ?? this.maths,
      science: science ?? this.science,
      english: english ?? this.english,
      socialScience: socialScience ?? this.socialScience,
      gujrati: gujrati ?? this.gujrati,
      fav: fav ?? this.fav,
      password: password ?? this.password,
      meritNo: meritNo ?? this.meritNo,
      isSeatConf: isSeatConf ?? this.isSeatConf,
      confbranch: confbranch ?? this.confbranch,
      confinstitute: confinstitute ?? this.confinstitute,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'user': user,
      'password': password,
      'name': name,
      'email': email,
      'meritNo': meritNo,
      'seatNo': seatNo,
      'maths': maths,
      'science': science,
      'english': english,
      'socialScience': socialScience,
      'gujrati': gujrati,
      'fav': fav,
      'isSeatConf': isSeatConf,
      'confbranch': confbranch,
      'confinstitute': confinstitute,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) 'uid': uid,
      if (name != null) "name": name,
      if (password != null) 'password': password,
      if (user != null) 'user': user,
      if (seatNo != null) 'seatNo': seatNo,
      if (meritNo != null) 'meritNo': meritNo,
      if (email != null) 'email': email,
      if (maths != null) 'maths': maths,
      if (science != null) 'science': science,
      if (english != null) 'english': english,
      if (socialScience != null) 'socialScience': socialScience,
      if (gujrati != null) 'gujrati': gujrati,
      if (fav != null) 'fav': fav,
      if (isSeatConf != null) 'isSeatConf': isSeatConf,
      if (confbranch != null) 'confbranch': confbranch,
      if (confinstitute != null) 'confinstitute': confinstitute,
    };
  }

  factory Student.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Student(
      uid: data?['uid'] as String,
      user: data?['user'] as String,
      password: data?['password'] as String,
      name: data?['name'] as String,
      email: data?['email'] as String,
      seatNo: data?['seatNo'] as String,
      meritNo: data?['meritNo'] as int,
      maths: data?['maths'] as int,
      science: data?['science'] as int,
      english: data?['english'] as int,
      socialScience: data?['socialScience'] as int,
      gujrati: data?['gujrati'] as int,
      fav: List<String>.from(
        (data?['fav']),
      ),
      isSeatConf: data?['isSeatConf'] as bool,
      confbranch: data?['confbranch'] as String,
      confinstitute: data?['confinstitute'] as String,
    );
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      uid: map['uid'] as String,
      name: map['name'] as String,
      user: map['user'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      seatNo: map['seatNo'] as String,
      meritNo: map['meritNo'] as int,
      maths: map['maths'] as int,
      science: map['science'] as int,
      english: map['english'] as int,
      socialScience: map['socialScience'] as int,
      gujrati: map['gujrati'] as int,
      fav: List<String>.from(
        (map['fav']),
      ),
      isSeatConf: map['isSeatConf'] as bool,
      confbranch: map['confbranch'] as String,
      confinstitute: map['confinstitute'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(name: $name, email: $email, maths: $maths, science: $science, english: $english, socialScience: $socialScience, gujrati: $gujrati, fav: $fav, isSeatConf: $isSeatConf, confbranch: $confbranch, confinstitute: $confinstitute)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.password == password && other.email == email;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        user.hashCode ^
        password.hashCode ^
        name.hashCode ^
        email.hashCode ^
        seatNo.hashCode ^
        maths.hashCode ^
        science.hashCode ^
        english.hashCode ^
        socialScience.hashCode ^
        gujrati.hashCode ^
        fav.hashCode ^
        isSeatConf.hashCode ^
        confbranch.hashCode ^
        confinstitute.hashCode;
  }
}
