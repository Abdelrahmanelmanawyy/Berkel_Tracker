import 'package:berkel_tracking_servise/widgets/report_widgets/excelexport.dart';
import 'package:berkel_tracking_servise/widgets/report_widgets/tabel_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsReportNavigator extends StatefulWidget {
  final String category;
  final DateTime startDate;
  final DateTime endDate;

  const DetailsReportNavigator({
    Key? key,
    required this.category,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  _DetailsReportNavigatorState createState() => _DetailsReportNavigatorState();
}

class _DetailsReportNavigatorState extends State<DetailsReportNavigator> {
  Future<List<Map<String, dynamic>>> fetchLocationDetails() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('userplans')
          .where('category', isEqualTo: widget.category)
          .where('saveFault', isEqualTo: true) // Assuming you meant this
          .get();

      return snapshot.docs.map((doc) => doc.data()).toList();
    } catch (e) {
      print("Error fetching data: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text(widget.category),
        elevation: 0,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchLocationDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final dataList = snapshot.data ?? [];

          if (dataList.isEmpty) {
            return const Center(child: Text('No data found for this category.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Details for ${widget.category}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ExcelExportTabelWidget.exportToExcel(dataList);
                  },
                  child: const Text('Export to Excel'),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: StationTable(
                    dataList: dataList,
                    startDate: widget.startDate,
                    endDate: widget.endDate,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
