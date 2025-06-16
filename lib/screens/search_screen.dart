import 'package:berkel_tracking_servise/constants/dataset.dart';
import 'package:berkel_tracking_servise/widgets/main_screen_widgets/searchwidget.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('İstasyon Seç'),
        backgroundColor: Colors.white,
        ),
      backgroundColor: Colors.white,
      body: MetroStationSearchWidget(
        onStationSelected: (Station station) {
          Navigator.pop(context, station); 
        },
      ),
    );
  }
}
