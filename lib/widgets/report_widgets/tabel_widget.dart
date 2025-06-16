import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StationTable extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;
  final DateTime startDate;
  final DateTime endDate;

  const StationTable({
    super.key,
    required this.dataList,
    required this.startDate,
    required this.endDate,
  });

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'N/A';

    DateTime? date;
    if (timestamp is Timestamp) {
      date = timestamp.toDate();
    } else if (timestamp is String) {
      try {
        date = DateTime.parse(timestamp);
      } catch (e) {
        return 'Invalid Date';
      }
    } else {
      return 'Invalid Type';
    }

    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }

  DateTime? _parseTimestamp(dynamic timestamp) {
    if (timestamp == null) return null;

    if (timestamp is Timestamp) {
      return timestamp.toDate();
    } else if (timestamp is String) {
      try {
        return DateTime.parse(timestamp);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final filteredData = dataList.where((item) {
      final timestamp = _parseTimestamp(item['timestamp']);
      if (timestamp == null) return false;
      return timestamp.isAfter(startDate.subtract(const Duration(seconds: 1))) &&
             timestamp.isBefore(endDate.add(const Duration(seconds: 1)));
    }).toList();

    filteredData.sort((a, b) {
      final dateA = _parseTimestamp(a['timestamp'])!;
      final dateB = _parseTimestamp(b['timestamp'])!;
      return dateB.compareTo(dateA); // Descending order
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Table(
            border: TableBorder.all(),
            columnWidths: const {
              0: FlexColumnWidth(),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
              5: FlexColumnWidth(),
              6: FlexColumnWidth(),
              7: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[300]),
                children: [
                  _buildHeader('bulunan tarih'),
                  _buildHeader('İstasyon Adı'),
                  _buildHeader('bilgi bulucu'),
                  _buildHeader('Not bulucu'),
                  _buildHeader('Arıza'),
                  _buildHeader('Arızanın giderildiği tarih'),
                  _buildHeader('Gidecek kişinin'),
                  _buildHeader('not alan kişi'),
                ],
              ),
              ...filteredData.map((item) {
                return TableRow(
                  children: [
                    _buildCell(_formatTimestamp(item['timestamp'])),
                    _buildCell(item['stationName']),
                    _buildCell(item['finderName']),
                    _buildCell(item['finderNote']),
                    _buildCell(item['problem']),
                    _buildCell(_formatTimestamp(item['fixedTime'])),
                    _buildCell(item['gonerName']),
                    _buildCell(item['gonerNote']),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String text) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      );

  Widget _buildCell(dynamic value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(value?.toString() ?? 'N/A'),
      );
}
