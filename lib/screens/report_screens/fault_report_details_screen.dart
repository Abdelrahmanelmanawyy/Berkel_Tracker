import 'package:berkel_tracking_servise/widgets/report_widgets/excelexport.dart';
import 'package:berkel_tracking_servise/widgets/report_widgets/fault_table.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FaultListScreen extends StatefulWidget {
  const FaultListScreen({Key? key}) : super(key: key);

  @override
  _FaultListScreenState createState() => _FaultListScreenState();
}

class _FaultListScreenState extends State<FaultListScreen> {
  Future<List<Map<String, dynamic>>> reportFault() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('userplans').get();

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
      appBar: AppBar(title: const Text("All Faults"),
      backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: reportFault(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final dataList = snapshot.data ?? [];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                 SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () {
                    ExcelExportFaultTable.exportToExcel(dataList);   
                  },
                  child: const Text('Export to Excel'),
                ),
                
                SizedBox(height: 20),
                Expanded(child: FaultTable(dataList: dataList)),
              ],
            ),
          );
        },
      ),
    );
  }
}
