// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Institute {
  final String uid;
  final String user;
  final String name;
  final String loginemail;
  final String email;
  final int ashiiCode;
  final String address;
  final String site;
  final String phone;
  final String password;
  List<Branch> branches;

  Institute({
    required this.uid,
    required this.user,
    required this.name,
    required this.loginemail,
    required this.email,
    required this.ashiiCode,
    required this.address,
    required this.site,
    required this.phone,
    required this.password,
    required this.branches,
  });

  Institute copyWith({
    String? uid,
    String? user,
    String? name,
    String? loginemail,
    String? email,
    int? ashiiCode,
    String? address,
    String? site,
    String? phone,
    String? password,
    List<Branch>? branches,
  }) {
    return Institute(
      uid: uid ?? this.uid,
      user: user ?? this.user,
      name: name ?? this.name,
      loginemail: loginemail ?? this.loginemail,
      email: email ?? this.email,
      ashiiCode: ashiiCode ?? this.ashiiCode,
      address: address ?? this.address,
      site: site ?? this.site,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      branches: branches ?? this.branches,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'user': user,
      'name': name,
      'loginemail': loginemail,
      'email': email,
      'ashiiCode': ashiiCode,
      'address': address,
      'site': site,
      'phone': phone,
      'password': password,
      'branches': branches.map((x) => x.toMap()).toList(),
    };
  }

  factory Institute.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    // print("branch- ${jsonDecode(data['branches'].toString())}");
    // print("${branches.toString()}");
    return Institute(
      uid: data['uid'],
      user: data['user'],
      name: data['name'],
      email: data['email'],
      loginemail: data['loginemail'],
      ashiiCode: data['ashiiCode'],
      address: data['address'],
      site: data['site'],
      phone: data['phone'],
      password: data['password'],
      branches: [],
      // branches: data['branches'].map((obj) {
      //   Branch tempBranch = Branch.fromMap(obj);
      //   print("branch - ${tempBranch}");
      //   return tempBranch;
      // }).toList(),
      // //////////
      // List<Branch>.from(
      //   (data['branches'] as List<Map<String, dynamic>>).map<Branch>(
      //     (x) => Branch.fromMap(x),
      //   ),
      // ),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (name != null) "name": name,
      if (user != null) "user": user,
      if (email != null) "email": email,
      if (loginemail != null) "loginemail": loginemail,
      if (ashiiCode != null) "ashiiCode": ashiiCode,
      if (address != null) "address": address,
      if (site != null) "site": site,
      if (phone != null) "phone": phone,
      if (password != null) "password": password,
      if (branches != null)
        // "branches": branches.map((x) => x.toFirestore()).toList(),
        "branches": [],
    };
  }

  factory Institute.fromMap(Map<String, dynamic> map) {
    return Institute(
      uid: map['uid'] as String,
      user: map['user'] as String,
      name: map['name'] as String,
      loginemail: map['loginemail'] as String,
      email: map['email'] as String,
      ashiiCode: map['ashiiCode'] as int,
      address: map['address'] as String,
      site: map['site'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
      branches: List<Branch>.from(
        (map['branches'] as List).map<Branch>(
          (x) {
            Branch tempBranch = Branch.fromMap(x as Map<String, dynamic>);
            if (kDebugMode) {
              print("branch - $tempBranch");
            }
            return tempBranch;
          },
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Institute.fromJson(String source) =>
      Institute.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  int get hashCode {
    return uid.hashCode ^
        user.hashCode ^
        name.hashCode ^
        loginemail.hashCode ^
        email.hashCode ^
        ashiiCode.hashCode ^
        address.hashCode ^
        site.hashCode ^
        phone.hashCode ^
        password.hashCode ^
        branches.hashCode;
  }

  @override
  String toString() {
    return 'Institute(uid: $uid, user: $user, name: $name, loginemail: $loginemail, email: $email, ashiiCode: $ashiiCode, address: $address, site: $site, phone: $phone, password: $password, branches: $branches)';
  }

  @override
  bool operator ==(covariant Institute other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.user == user &&
        other.name == name &&
        other.loginemail == loginemail &&
        other.email == email &&
        other.ashiiCode == ashiiCode &&
        other.address == address &&
        other.site == site &&
        other.phone == phone &&
        other.password == password &&
        listEquals(other.branches, branches);
  }
}

class Branch {
  int minMarks; //
  final int totalSeats; //
  int filledSeats; //
  bool isFav = false; //
  final String branchName;
  final String bID;

  Branch({
    required this.minMarks,
    required this.totalSeats,
    required this.filledSeats,
    this.isFav = false,
    required this.branchName,
    required this.bID,
  });

  Branch copyWith({
    int? minMarks,
    int? totalSeats,
    int? filledSeats,
    bool? isFav,
    String? branchName,
    String? bID,
  }) {
    return Branch(
      isFav: isFav ?? this.isFav,
      minMarks: minMarks ?? this.minMarks,
      totalSeats: totalSeats ?? this.totalSeats,
      filledSeats: filledSeats ?? this.filledSeats,
      branchName: branchName ?? this.branchName,
      bID: bID ?? this.bID,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'minMarks': minMarks,
      'totalSeats': totalSeats,
      'filledSeats': filledSeats,
      'isFav': isFav,
      'branchName': branchName,
      'bID': bID,
    };
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (minMarks != null) 'minMarks': minMarks,
      if (totalSeats != null) 'totalSeats': totalSeats,
      if (filledSeats != null) 'filledSeats': filledSeats,
      if (isFav != null) 'isFav': isFav,
      if (branchName != null) 'branchName': branchName,
    };
  }

  factory Branch.fromMap(Map<String, dynamic> map) {
    return Branch(
      isFav: map['isFav'] as bool,
      minMarks: map['minMarks'] as int,
      totalSeats: map['totalSeats'] as int,
      filledSeats: map['filledSeats'] as int,
      branchName: map['branchName'] as String,
      bID: map['bID'] as String,
    );
  }
  factory Branch.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Branch(
      isFav: data?['isFav'],
      minMarks: data?['minMarks'],
      totalSeats: data?['totalSeats'],
      filledSeats: data?['filledSeats'],
      branchName: data?['branchName'],
      bID: data?['bID'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Branch.fromJson(String source) =>
      Branch.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Branch(minMarks: $minMarks, totalSeats: $totalSeats, filledSeats: $filledSeats, isFav: $isFav, branchName: $branchName, bID: $bID)';
  }

  @override
  bool operator ==(covariant Branch other) {
    if (identical(this, other)) return true;

    return other.minMarks == minMarks &&
        other.totalSeats == totalSeats &&
        other.filledSeats == filledSeats &&
        other.isFav == isFav &&
        other.branchName == branchName &&
        other.bID == bID;
  }

  @override
  int get hashCode {
    return minMarks.hashCode ^
        totalSeats.hashCode ^
        filledSeats.hashCode ^
        isFav.hashCode ^
        branchName.hashCode ^
        bID.hashCode;
  }
}

class BranchInstitute {
  int minMarks; //
  final int totalSeats; //
  int filledSeats; //
  bool isFav = false; //
  final String branchName;
  final String bID; //
  final String uid;
  final String user;
  final String name;
  final String loginemail;
  final String email;
  final int ashiiCode;
  final String address;
  final String site;
  final String phone;
  final String password; //
  BranchInstitute({
    required this.minMarks,
    required this.totalSeats,
    required this.filledSeats,
    required this.isFav,
    required this.branchName,
    required this.bID,
    required this.uid,
    required this.user,
    required this.name,
    required this.loginemail,
    required this.email,
    required this.ashiiCode,
    required this.address,
    required this.site,
    required this.phone,
    required this.password,
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
      uid: data?['uid'],
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
      branchName: data?['branchName'],
      bID: data?['bID'],
      password: data?['password'],
    );
  }

  Institute toInstitute() {
    return Institute(
      uid: uid,
      user: user,
      name: name,
      email: email,
      loginemail: loginemail,
      ashiiCode: ashiiCode,
      address: address,
      site: site,
      phone: phone,
      password: password,
      branches: [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (uid != null) "uid": uid,
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
      if (branchName != null) "branch": branchName,
      if (minMarks != null) "minMarks": minMarks,
      if (password != null) "password": password,
      if (bID != null) "bID": bID,
    };
  }

  // factory BranchInstitute.fromMap(Map<String, dynamic> map) {
  //   return BranchInstitute(
  //     minMarks: map['minMarks'] as int,
  //     totalSeats: map['totalSeats'] as int,
  //     filledSeats: map['filledSeats'] as int,
  //     isFav: map['isFav'] as bool,
  //     branchName: map['branchName'] as String,
  //     uid: map['uid'] as String,
  //     user: map['user'] as String,
  //     name: map['name'] as String,
  //     email: map['email'] as String,
  //     loginemail: map['loginemail'] as String,
  //     ashiiCode: map['ashiiCode'] as int,
  //     address: map['address'] as String,
  //     site: map['site'] as String,
  //     phone: map['phone'] as String,
  //     password: map['password'] as String, bID: map['bID'] as String,
  //   );
  // }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'minMarks': minMarks,
//       'totalSeats': totalSeats,
//       'filledSeats': filledSeats,
//       'isFav': isFav,
//       'branch': branch,
//       'uid': uid,
//       'user': user,
//       'name': name,
//       'email': email,
//       'loginemail': loginemail,
//       'ashiiCode': ashiiCode,
//       'address': address,
//       'site': site,
//       'phone': phone,
//       'password,': password,
//     };
//   }

//   @override
//   bool operator ==(covariant BranchInstitute other) {
//     if (identical(this, other)) return true;

//     return other.minMarks == minMarks &&
//         other.totalSeats == totalSeats &&
//         other.filledSeats == filledSeats &&
//         other.isFav == isFav &&
//         other.branch == branch;
//   }

//   @override
//   int get hashCode {
//     return minMarks.hashCode ^
//         totalSeats.hashCode ^
//         filledSeats.hashCode ^
//         isFav.hashCode ^
//         branch.hashCode;
//   }

  BranchInstitute copyWith({
    int? minMarks,
    int? totalSeats,
    int? filledSeats,
    bool? isFav,
    String? branchName,
    String? bID,
    String? uid,
    String? user,
    String? name,
    String? loginemail,
    String? email,
    int? ashiiCode,
    String? address,
    String? site,
    String? phone,
    String? password,
  }) {
    return BranchInstitute(
      minMarks: minMarks ?? this.minMarks,
      totalSeats: totalSeats ?? this.totalSeats,
      filledSeats: filledSeats ?? this.filledSeats,
      isFav: isFav ?? this.isFav,
      branchName: branchName ?? this.branchName,
      bID: bID ?? this.bID,
      uid: uid ?? this.uid,
      user: user ?? this.user,
      name: name ?? this.name,
      loginemail: loginemail ?? this.loginemail,
      email: email ?? this.email,
      ashiiCode: ashiiCode ?? this.ashiiCode,
      address: address ?? this.address,
      site: site ?? this.site,
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'minMarks': minMarks,
      'totalSeats': totalSeats,
      'filledSeats': filledSeats,
      'isFav': isFav,
      'branchName': branchName,
      'bID': bID,
      'uid': uid,
      'user': user,
      'name': name,
      'loginemail': loginemail,
      'email': email,
      'ashiiCode': ashiiCode,
      'address': address,
      'site': site,
      'phone': phone,
      'password': password,
    };
  }

  factory BranchInstitute.fromMap(Map<String, dynamic> map) {
    return BranchInstitute(
      minMarks: map['minMarks'] as int,
      totalSeats: map['totalSeats'] as int,
      filledSeats: map['filledSeats'] as int,
      isFav: map['isFav'] as bool,
      branchName: map['branchName'] as String,
      bID: map['bID'] as String,
      uid: map['uid'] as String,
      user: map['user'] as String,
      name: map['name'] as String,
      loginemail: map['loginemail'] as String,
      email: map['email'] as String,
      ashiiCode: map['ashiiCode'] as int,
      address: map['address'] as String,
      site: map['site'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BranchInstitute.fromJson(String source) =>
      BranchInstitute.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'BranchInstitute(minMarks: $minMarks, totalSeats: $totalSeats, filledSeats: $filledSeats, isFav: $isFav, branchName: $branchName, bID: $bID, uid: $uid, user: $user, name: $name, loginemail: $loginemail, email: $email, ashiiCode: $ashiiCode, address: $address, site: $site, phone: $phone, password: $password)';
  }

  @override
  bool operator ==(covariant BranchInstitute other) {
    if (identical(this, other)) return true;

    return other.minMarks == minMarks &&
        other.totalSeats == totalSeats &&
        other.filledSeats == filledSeats &&
        other.isFav == isFav &&
        other.branchName == branchName &&
        other.bID == bID &&
        other.uid == uid &&
        other.user == user &&
        other.name == name &&
        other.loginemail == loginemail &&
        other.email == email &&
        other.ashiiCode == ashiiCode &&
        other.address == address &&
        other.site == site &&
        other.phone == phone &&
        other.password == password;
  }

  @override
  int get hashCode {
    return minMarks.hashCode ^
        totalSeats.hashCode ^
        filledSeats.hashCode ^
        isFav.hashCode ^
        branchName.hashCode ^
        bID.hashCode ^
        uid.hashCode ^
        user.hashCode ^
        name.hashCode ^
        loginemail.hashCode ^
        email.hashCode ^
        ashiiCode.hashCode ^
        address.hashCode ^
        site.hashCode ^
        phone.hashCode ^
        password.hashCode;
  }
// }

//   String toJson() => json.encode(toMap());

//   factory BranchInstitute.fromJson(String source) =>
//       BranchInstitute.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() =>
//       'BranchInstitute(minMarks: $minMarks, isFav: $isFav, branch: $branch)';

//   @override
//   bool operator ==(covariant BranchInstitute other) {
//     if (identical(this, other)) return true;

//     return other.minMarks == minMarks &&
//         other.isFav == isFav &&
//         other.branch == branch;
//   }

//   @override
//   int get hashCode => minMarks.hashCode ^ isFav.hashCode ^ branch.hashCode;
}
