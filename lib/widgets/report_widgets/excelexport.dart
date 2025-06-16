import 'dart:html' as html;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:intl/intl.dart';



class ExcelExportTabelWidget {
  static void exportToExcel(List<Map<String, dynamic>> dataList) {
    final excel = Excel.createExcel(); // Create a new Excel file
    final Sheet sheet = excel['Sheet1'];

    // Add headers (same order as StationTable)
    sheet.appendRow([
      'bulunan tarih',
      'İstasyon Adı',
      'bilgi bulucu',
      'Not bulucu',
      'Arıza',
      'Arızanın giderildiği tarih',
      'Gidecek kişinin',
      'not alan kişi',
    ]);

    // Add data rows
    for (final item in dataList) {
      sheet.appendRow([
        _formatTimestamp(item['timestamp']),
        item['stationName'] ?? 'N/A',
        item['finderName'] ?? 'N/A',
        item['finderNote'] ?? 'N/A',
        item['problem'] ?? 'N/A',
        item['fixedTime'] ?? 'N/A',
        item['gonerName'] ?? 'N/A',
        item['gonerNote'] ?? 'N/A',
      ]);
    }

    // Encode the Excel file
    final bytes = excel.encode();
    if (bytes == null) return;

    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'station_data.xlsx')
      ..click();

    html.Url.revokeObjectUrl(url);
  }

 static String _formatTimestamp(dynamic timestamp) {
  if (timestamp == null) return 'N/A';

  DateTime? date;
  if (timestamp is Timestamp) {
    date = timestamp.toDate();
  } else if (timestamp is String) {
    try {
      date = DateTime.parse(timestamp);
    } catch (_) {
      return 'Invalid Date';
    }
  } else if (timestamp is DateTime) {
    date = timestamp;
  } else {
    return 'Invalid Type';
  }

  return DateFormat('dd MMM yyyy, HH:mm').format(date);
}

}

class ExcelExportFaultTable {
  static void exportToExcel(List<Map<String, dynamic>> dataList) {
    var excel = Excel.createExcel();
    Sheet sheet = excel['Sheet1'];

    // Add headers (Turkish, like the FaultTable)
    sheet.appendRow([
      'bulunan tarih',
      'İstasyon Adı',
      'bilgi bulucu',
      'Not bulucu',
      'Arıza',
    ]);

    // Add data rows
    for (var item in dataList) {
      sheet.appendRow([
        _formatTimestamp(item['timestamp']),
        item['stationName'] ?? 'N/A',
        item['finderName'] ?? 'N/A',
        item['finderNote'] ?? 'N/A',
        item['problem'] ?? 'N/A',
      ]);
    }

    // Download the file
    final bytes = excel.encode();
    if (bytes == null) return;

    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);

    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'fault_table.xlsx')
      ..click();

    html.Url.revokeObjectUrl(url);
  }

  static String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'N/A';

    DateTime? date;
    if (timestamp is Timestamp) {
      date = timestamp.toDate();
    } else if (timestamp is String) {
      try {
        date = DateTime.parse(timestamp);
      } catch (_) {
        return 'Invalid Date';
      }
    } else {
      return 'Invalid Type';
    }

    return DateFormat('dd MMM yyyy, HH:mm').format(date);
  }
}
