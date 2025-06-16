
import 'package:berkel_tracking_servise/widgets/report_widgets/excelexport.dart';
import 'package:berkel_tracking_servise/widgets/report_widgets/tabel_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class PersonDetailsScreen extends StatefulWidget {
  final String name;


  const PersonDetailsScreen({
    Key? key,
    required this.name,
    
  }) : super(key: key);

  @override
  _PersonDetailsScreenState createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {
  Future<List<Map<String, dynamic>>> fetchLocationDetails(String name) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('userplans')
          .where('gonerName', isEqualTo: 'abdelrahman')
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
     
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchLocationDetails(widget.name),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final dataList = snapshot.data ?? [];

          if (dataList.isEmpty) {
            return const Center(child: Text('No data found for this location.'));
          }
    

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Details for ${widget.name}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    ExcelExportTabelWidget.exportToExcel(dataList);
                    
                  },
                  child: const Text('Export to Excel'),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: StationTable(dataList: dataList,
                  startDate: DateTime(2025, 1, 1),
                  endDate: DateTime(2025, 5, 29),
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
