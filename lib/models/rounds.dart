// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Rounds {
  final Timestamp registerStart;
  final Timestamp registerEnd;
  final Timestamp mockRoundStart;
  final Timestamp mockRoundEnd;
  final Timestamp firstRoundStart;
  final Timestamp firstRoundEnd;
  final Timestamp secondRoundStart;
  final Timestamp secondRoundEnd;
  bool firstRoundOpen(Timestamp cureentTime) {
    // if (
    if (registerStart.compareTo(cureentTime) < 0 &&
        registerEnd.compareTo(cureentTime) > 0) {
      return true;
    }
    return false;
  }

//vaidik
  bool mockRoundOpen(Timestamp cureentTime) {
    // if (
    if (registerStart.compareTo(cureentTime) < 0 &&
        registerEnd.compareTo(cureentTime) > 0) {
      return true;
    }
    return false;
  }

  //vaidik end

  bool secondRoundOpen(Timestamp cureentTime) {
    if (firstRoundStart.compareTo(cureentTime) < 0 &&
        firstRoundEnd.compareTo(cureentTime) > 0) {
      return true;
    }
    return false;
  }

  bool registerOpen(Timestamp cureentTime) {
    if (registerStart.compareTo(cureentTime) < 0 &&
        registerEnd.compareTo(cureentTime) > 0) {
      return true;
    }
    return false;
  }

  bool roundOpen(Timestamp cureentTime) {
    if (mockRoundStart.compareTo(cureentTime) < 0 &&
        mockRoundEnd.compareTo(cureentTime) > 0) {
      return true;
    } else if (firstRoundStart.compareTo(cureentTime) < 0 &&
        firstRoundEnd.compareTo(cureentTime) > 0) {
      return true;
    } else if (secondRoundStart.compareTo(cureentTime) < 0 &&
        secondRoundEnd.compareTo(cureentTime) > 0) {
      return true;
    }
    return false;
  }

  bool roundEnds(Timestamp cureentTime) {
    // if (mockRoundEnd.compareTo(cureentTime) < 0 &&
    //     firstRoundStart.compareTo(cureentTime) > 0) {
    //   return true;
    if (!(firstRoundEnd.compareTo(cureentTime) < 0)) {
      return false;
    }
    if (firstRoundEnd.compareTo(cureentTime) < 0 &&
        secondRoundStart.compareTo(cureentTime) > 0) {
      return true;
    } else if (secondRoundEnd.compareTo(cureentTime) < 0) {
      return true;
    }
    return false;
  }

  bool mockRoundEnds(Timestamp cureentTime) {
    if (mockRoundEnd.compareTo(cureentTime) < 0 &&
        firstRoundStart.compareTo(cureentTime) > 0) {
      return true;
    }

    return false;
  }

  bool firstRoundEnds(Timestamp cureentTime) {
    if (firstRoundEnd.compareTo(cureentTime) < 0 &&
        secondRoundStart.compareTo(cureentTime) > 0) {
      return true;
    }

    return false;
  }

  bool secondRoundEnds(Timestamp cureentTime) {
    if (secondRoundEnd.compareTo(cureentTime) < 0) {
      return true;
    }

    return false;
  }

  Rounds({
    required this.registerStart,
    required this.registerEnd,
    required this.mockRoundStart,
    required this.mockRoundEnd,
    required this.firstRoundStart,
    required this.firstRoundEnd,
    required this.secondRoundStart,
    required this.secondRoundEnd,
  });

  Rounds copyWith({
    final Timestamp? registerStart,
    final Timestamp? registerEnd,
    final Timestamp? mockRoundStart,
    final Timestamp? mockRoundEnd,
    Timestamp? firstRoundStart,
    Timestamp? firstRoundEnd,
    Timestamp? secondRoundStart,
    Timestamp? secondRoundEnd,
  }) {
    return Rounds(
      firstRoundStart: firstRoundStart ?? this.firstRoundStart,
      firstRoundEnd: firstRoundEnd ?? this.firstRoundEnd,
      secondRoundStart: secondRoundStart ?? this.secondRoundStart,
      secondRoundEnd: secondRoundEnd ?? this.secondRoundEnd,
      mockRoundEnd: mockRoundEnd ?? this.mockRoundEnd,
      registerStart: registerStart ?? this.registerStart,
      registerEnd: registerEnd ?? this.registerEnd,
      mockRoundStart: mockRoundStart ?? this.mockRoundStart,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstRoundStart': firstRoundStart,
      'firstRoundEnd': firstRoundEnd,
      'secondRoundStart': secondRoundStart,
      'secondRoundEnd': secondRoundEnd,
      'registerStart': registerStart,
      'registerEnd': registerEnd,
      'mockRoundStart': mockRoundStart,
      'mockRoundEnd': mockRoundEnd,
    };
  }

  factory Rounds.fromMap(Map<String, dynamic> map) {
    return Rounds(
      firstRoundStart: map['firstRoundStart'] as Timestamp,
      firstRoundEnd: map['firstRoundEnd'] as Timestamp,
      secondRoundStart: map['secondRoundStart'] as Timestamp,
      secondRoundEnd: map['secondRoundEnd'] as Timestamp,
      registerStart: map['registerStart'] as Timestamp,
      registerEnd: map['registerEnd'] as Timestamp,
      mockRoundStart: map['mockRoundStart'] as Timestamp,
      mockRoundEnd: map['mockRoundEnd'] as Timestamp,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (firstRoundStart != null) 'firstRoundStart': firstRoundStart,
      if (firstRoundEnd != null) 'firstRoundEnd': firstRoundEnd,
      if (secondRoundStart != null) 'secondRoundStart': secondRoundStart,
      if (secondRoundEnd != null) 'secondRoundEnd': secondRoundEnd,
      if (registerStart != null) 'registerStart': registerStart,
      if (registerEnd != null) 'registerEnd': registerEnd,
      if (mockRoundStart != null) 'mockRoundStart': mockRoundStart,
      if (mockRoundEnd != null) 'mockRoundEnd': mockRoundEnd,
      // if ( != null) "": ,
    };
  }

  factory Rounds.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Rounds(
      // 'id': id,
      firstRoundStart: data?['firstRoundStart'],
      firstRoundEnd: data?['firstRoundEnd'],
      secondRoundStart: data?['secondRoundStart'],
      secondRoundEnd: data?['secondRoundEnd'],
      registerStart: data?['registerStart'],
      registerEnd: data?['registerEnd'],
      mockRoundStart: data?['mockRoundStart'],
      mockRoundEnd: data?['mockRoundEnd'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Rounds.fromJson(String source) =>
      Rounds.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Rounds(firstRoundStart: $firstRoundStart, firstRoundEnd: $firstRoundEnd, secondRoundStart: $secondRoundStart, secondRoundEnd: $secondRoundEnd)';
  }

  @override
  bool operator ==(covariant Rounds other) {
    if (identical(this, other)) return true;

    return other.firstRoundStart == firstRoundStart &&
        other.firstRoundEnd == firstRoundEnd &&
        other.secondRoundStart == secondRoundStart &&
        other.secondRoundEnd == secondRoundEnd;
  }

  @override
  int get hashCode {
    return firstRoundStart.hashCode ^
        firstRoundEnd.hashCode ^
        secondRoundStart.hashCode ^
        secondRoundEnd.hashCode;
  }
}
