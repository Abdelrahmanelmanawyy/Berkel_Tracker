import 'package:berkel_tracking_servise/models/table_row_data.dart';
import 'package:intl/intl.dart';

class FaultModel {
  final String id;
  final String stationName;
  final String name;
  final String faultinfo;
  final String note;
  final String category;
  final DateTime timestamp;
  final bool isBending;

  FaultModel({
    required this.id,
    required this.stationName,
    required this.name,
    required this.faultinfo,
    required this.note,
    required this.category,
    required this.timestamp,
    this.isBending = false, 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stationName': stationName,
      'findername': name,
      'faultinfo': faultinfo,
      'note': note,
      'category': category,
      'timestamp': timestamp.toIso8601String(),
      'isBending': isBending,
    };
  }

  factory FaultModel.fromMap(Map<String, dynamic> map) {
    return FaultModel(
      id: map['id'] ?? '',
      stationName: map['stationName'] ?? '',
      name: map['findername'] ?? '',
      faultinfo: map['faultinfo'] ?? '',
      note: map['note'] ?? '',
      category: map['category'] ?? '',
      timestamp: DateTime.tryParse(map['timestamp'] ?? '') ?? DateTime.now(),
      isBending: map['isBending'] ?? false,
    );
  }
}

extension FaultToTableRow on FaultModel {
  TableRowData toTableRowData() {
    return TableRowData(
      id: id,
      date: DateFormat('dd MMM yyyy, HH:mm').format(timestamp),
      name: name,
      category: category,
      problem: faultinfo,
      location: stationName,
      note: note,
    );
  }
}
