import 'package:cloud_firestore/cloud_firestore.dart';

class UserPlanModel {
  final String? docId;
  final String boothId;
  final String stationName;
  final String category;
  final String problem;
  final String finderName;
  final String finderNote;
  final String gonerName;
  final String gonerNote;
  final DateTime timestamp;
  final DateTime ?fixedTime;
  final bool isAssigned;
  final bool isDone;
  final bool saveFault;

  UserPlanModel({
    required this.docId,
    required this.boothId,
    required this.stationName,
    required this.category,
    required this.problem,
    required this.finderName,
    required this.finderNote,
    required this.gonerName,
    required this.gonerNote,
    required this.timestamp,
    this.fixedTime,
    required this.isAssigned,
    required this.isDone,
    required this.saveFault,
  });

  Map<String, dynamic> toMap() {
    return {
      'boothId': boothId,
      'stationName': stationName,
      'category': category,
      'problem': problem,
      'finderName': finderName,
      'finderNote': finderNote,
      'gonerName': gonerName,
      'gonerNote': gonerNote,
      'timestamp': Timestamp.fromDate(timestamp),
      'fixedTime': fixedTime != null ? Timestamp.fromDate(fixedTime!) : null,
      'isAssigned': isAssigned,
      'isDone': isDone,
      'saveFault': saveFault,
    };
  }

  factory UserPlanModel.fromMap(Map<String, dynamic> map, String docId) {
    return UserPlanModel(
      docId: docId,
      boothId: map['boothId'] ?? '',
      stationName: map['stationName'] ?? '',
      category: map['category'] ?? '',
      problem: map['problem'] ?? '',
      finderName: map['finderName'] ?? '',
      finderNote: map['finderNote'] ?? '',
      gonerName: map['gonerName'] ?? '',
      gonerNote: map['gonerNote'] ?? '',
      timestamp: (map['timestamp'] as Timestamp).toDate(),
      fixedTime: map['fixedTime'] != null ? (map['fixedTime'] as Timestamp).toDate() : null,
      isAssigned: map['isAssigned'] ?? false,
      isDone: map['isDone'] ?? false,
      saveFault: map['saveFault'] ?? false,
    );
  }
}
