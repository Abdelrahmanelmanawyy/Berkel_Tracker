

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FaultTable extends StatelessWidget {
  final List<Map<String, dynamic>> dataList;

  const FaultTable({super.key, required this.dataList});

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

  @override
  Widget build(BuildContext context) {
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
                ],
              ),
              ...dataList.map((item) {
               

                return TableRow(
                  children: [
                    _buildCell(_formatTimestamp(item['timestamp'])),
                    _buildCell(item['stationName']),
                    _buildCell(item['finderName']),
                    _buildCell(item['finderNote']),
                    _buildCell(item['problem']),
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