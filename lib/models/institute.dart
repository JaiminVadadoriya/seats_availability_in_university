// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Institute {
  final String user;
  final String name;
  final String loginemail;
  final String email;
  final int ashiiCode;
  final String address;
  final String site;
  final String phone;
  final String password;

  Institute({
    required this.user,
    required this.name,
    required this.email,
    required this.loginemail,
    required this.ashiiCode,
    required this.address,
    required this.site,
    required this.phone,
    required this.password,
  });

  Institute copyWith({
    String? user,
    String? name,
    String? email,
    String? loginemail,
    int? ashiiCode,
    String? address,
    String? site,
    String? phone,
  }) {
    return Institute(
      user: user ?? this.user,
      name: name ?? this.name,
      email: email ?? this.email,
      loginemail: loginemail ?? this.loginemail,
      ashiiCode: ashiiCode ?? this.ashiiCode,
      address: address ?? this.address,
      site: site ?? this.site,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'user': user,
      'name': name,
      'email': email,
      'loginemail': loginemail,
      'ashiiCode': ashiiCode,
      'address': address,
      'site': site,
      'phone': phone,
      'password,': password,
    };
  }

  // factory City.fromFirestore(
  //   DocumentSnapshot<Map<String, dynamic>> snapshot,
  //   SnapshotOptions? options,
  // ) {
  //   final data = snapshot.data();
  //   return City(
  //     name: data?['name'],
  //     state: data?['state'],
  //     country: data?['country'],
  //     capital: data?['capital'],
  //     population: data?['population'],
  //     regions:
  //         data?['regions'] is Iterable ? List.from(data?['regions']) : null,
  //   );
  // }

  factory Institute.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Institute(
      user: data?['user'],
      name: data?['name'],
      email: data?['email'],
      loginemail: data?['loginemail'],
      ashiiCode: data?['ashiiCode'],
      address: data?['address'],
      site: data?['site'],
      phone: data?['phone'],
      password: data?['password'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (user != null) "user": user,
      if (email != null) "email": email,
      if (loginemail != null) "loginemail": loginemail,
      if (ashiiCode != null) "ashiiCode": ashiiCode,
      if (address != null) "address": address,
      if (site != null) "site": site,
      if (phone != null) "phone": phone,
      if (password != null) "password": password,
      // if ( != null) "": ,
    };
  }

  factory Institute.fromMap(Map<String, dynamic> map) {
    return Institute(
      user: map['user'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      loginemail: map['loginemail'] as String,
      ashiiCode: map['ashiiCode'] as int,
      address: map['address'] as String,
      site: map['site'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Institute.fromJson(String source) =>
      Institute.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Institute(user: $user, name: $name, email: $email, ashiiCode: $ashiiCode, address: $address, site: $site, phone: $phone)';
  }

  @override
  bool operator ==(covariant Institute other) {
    if (identical(this, other)) return true;

    return other.user == user &&
        other.name == name &&
        other.email == email &&
        other.ashiiCode == ashiiCode &&
        other.address == address &&
        other.site == site &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        name.hashCode ^
        email.hashCode ^
        ashiiCode.hashCode ^
        address.hashCode ^
        site.hashCode ^
        phone.hashCode;
  }
}

class BranchInstitute extends Institute {
  final int minMarks; //
  final int totalSeats; //
  final int filledSeats; //
  bool isFav = false; //
  final String branch; //
  BranchInstitute({
    required this.isFav,
    required this.minMarks,
    required this.branch,
    required this.filledSeats,
    required this.totalSeats,
    required super.user,
    required super.name,
    required super.email,
    required super.loginemail,
    required super.ashiiCode,
    required super.address,
    required super.site,
    required super.phone,
    required super.password,
  });

  // @override
  // BranchInstitute copyWith({
  //   int? minMarks,
  //   bool? isFav,
  //   String? branch,
  // }) {
  //   super.copyWith(
  //     user: user ?? super.user,
  //     name: name ?? super.name,
  //     email: email ?? super.email,
  //     ashiiCode: ashiiCode ?? super.ashiiCode,
  //     address: address ?? super.address,
  //     site: site ?? super.site,
  //     phone: phone ?? super.phone,
  //   );
  //   return BranchInstitute(
  //     user: user ?? super.user,
  //     name: name ?? super.name,
  //     email: email ?? super.email,
  //     ashiiCode: ashiiCode ?? super.ashiiCode,
  //     address: address ?? super.address,
  //     site: site ?? super.site,
  //     phone: phone ?? super.phone,
  //     branch: branch ?? this.branch,
  //     minMarks: minMarks ?? this.minMarks,
  //     isFav: isFav ?? this.isFav,
  //     // minMarks ?? this.minMarks,
  //     // branch ?? this.branch,
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'user': user,
  //     'name': name,
  //     'email': email,
  //     'ashiiCode': ashiiCode,
  //     'address': address,
  //     'site': site,
  //     'phone': phone,
  //     'minMarks': minMarks,
  //     'isFav': isFav,
  //     'branch': branch,
  //   };
  // }

  factory BranchInstitute.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return BranchInstitute(
      isFav: data?['isFav'],
      user: data?['user'],
      name: data?['name'],
      email: data?['email'],
      loginemail: data?['loginemail'],
      totalSeats: data?['totalSeats'],
      filledSeats: data?['filledSeats'],
      ashiiCode: data?['ashiiCode'],
      address: data?['address'],
      site: data?['site'],
      phone: data?['phone'],
      minMarks: data?['minMarks'],
      branch: data?['branch'],
      password: data?['password'],
    );
  }

  @override
  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (user != null) "user": user,
      if (email != null) "email": email,
      if (loginemail != null) "loginemail": loginemail,
      if (filledSeats != null) "filledSeats": filledSeats,
      if (totalSeats != null) "totalSeats": totalSeats,
      if (ashiiCode != null) "ashiiCode": ashiiCode,
      if (address != null) "address": address,
      if (site != null) "site": site,
      if (phone != null) "phone": phone,
      if (isFav != null) "isFav": isFav,
      if (branch != null) "branch": branch,
      if (minMarks != null) "minMarks": minMarks,
      if (password != null) "password": password,
    };
  }

  // factory BranchInstitute.fromMap(Map<String, dynamic> map) {
  //   return BranchInstitute(
  //     map['minMarks'] as int,
  //     map['isFav'] as bool,
  //     map['branch'] as String,
  //     user: map['user'] as String,
  //     name: map['name'] as String,
  //     email: map['email'] as String,
  //     ashiiCode: map['ashiiCode'] as int,
  //     address: map['address'] as String,
  //     site: map['site'] as String,
  //     phone: map['phone'] as String,
  //   );
  // }
}

  // String toJson() => json.encode(toMap());

  // factory BranchInstitute.fromJson(String source) =>
  //     BranchInstitute.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // String toString() =>
  //     'BranchInstitute(minMarks: $minMarks, isFav: $isFav, branch: $branch)';

  // @override
  // bool operator ==(covariant BranchInstitute other) {
  //   if (identical(this, other)) return true;

  //   return other.minMarks == minMarks &&
  //       other.isFav == isFav &&
  //       other.branch == branch;
  // }

  // @override
  // int get hashCode => minMarks.hashCode ^ isFav.hashCode ^ branch.hashCode;
// }
