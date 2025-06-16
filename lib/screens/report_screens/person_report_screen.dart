import 'package:berkel_tracking_servise/screens/report_screens/person_details_screen.dart';
import 'package:flutter/material.dart';

class PersonScreen extends StatelessWidget {
  final List<String> personNames = [
    'Abdelrahman Ashraf',
    'Cihan Bey',
    'Burak EFE',
    'Burak sen',
  
   
  ];

  void _navigateWithName(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonDetailsScreen(name: name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Person List'),
        backgroundColor: Colors.white,
      ),
      body: 
      Padding(
        padding: const EdgeInsets.all(25.0),
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: personNames.map((name) {
            return SizedBox(
              width: isSmallScreen ? double.infinity : 250,
              height: 200,
              child: ElevatedButton(
                onPressed: () => _navigateWithName(context, name),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 38, 127, 159),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  name,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
