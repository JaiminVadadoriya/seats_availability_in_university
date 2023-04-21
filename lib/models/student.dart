// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Student {
  final String user;
  final String password;
  final String name;
  final String email;
  final int maths;
  final int science;
  final int english;
  final int socialScience;
  final int gujrati;
  final List<String> fav;

  Student({
    required this.user,
    required this.password,
    required this.name,
    required this.email,
    required this.maths,
    required this.science,
    required this.english,
    required this.socialScience,
    required this.gujrati,
    required this.fav,
  });

  Student copyWith({
    String? user,
    String? password,
    String? name,
    String? email,
    int? maths,
    int? science,
    int? english,
    int? socialScience,
    int? gujrati,
    List<String>? fav,
  }) {
    return Student(
      user: user ?? this.user,
      name: name ?? this.name,
      email: email ?? this.email,
      maths: maths ?? this.maths,
      science: science ?? this.science,
      english: english ?? this.english,
      socialScience: socialScience ?? this.socialScience,
      gujrati: gujrati ?? this.gujrati,
      fav: fav ?? this.fav,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'password': password,
      'name': name,
      'email': email,
      'maths': maths,
      'science': science,
      'english': english,
      'socialScience': socialScience,
      'gujrati': gujrati,
      'fav': fav,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (password != null) 'password': password,
      if (user != null) 'user': user,
      if (email != null) 'email': email,
      if (maths != null) 'maths': maths,
      if (science != null) 'science': science,
      if (english != null) 'english': english,
      if (socialScience != null) 'socialScience': socialScience,
      if (gujrati != null) 'gujrati': gujrati,
      if (fav != null) 'fav': fav,
    };
  }

  factory Student.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Student(
      user: data?['user'] as String,
      password: data?['password'] as String,
      name: data?['name'] as String,
      email: data?['email'] as String,
      maths: data?['maths'] as int,
      science: data?['science'] as int,
      english: data?['english'] as int,
      socialScience: data?['socialScience'] as int,
      gujrati: data?['gujrati'] as int,
      fav: List<String>.from(
        (data?['fav']),
      ),
    );
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'] as String,
      user: map['user'] as String,
      password: map['password'] as String,
      email: map['email'] as String,
      maths: map['maths'] as int,
      science: map['science'] as int,
      english: map['english'] as int,
      socialScience: map['socialScience'] as int,
      gujrati: map['gujrati'] as int,
      fav: List<String>.from(
        (map['fav'] as List<String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(name: $name, email: $email, maths: $maths, science: $science, english: $english, socialScience: $socialScience, gujrati: $gujrati, fav: $fav)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.maths == maths &&
        other.science == science &&
        other.english == english &&
        other.socialScience == socialScience &&
        other.gujrati == gujrati &&
        listEquals(other.fav, fav);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        maths.hashCode ^
        science.hashCode ^
        english.hashCode ^
        socialScience.hashCode ^
        gujrati.hashCode ^
        fav.hashCode;
  }
}
