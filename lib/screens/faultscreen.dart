import 'package:berkel_tracking_servise/constants/dataset.dart';
import 'package:berkel_tracking_servise/firebase_services/firestoreservies.dart';
import 'package:berkel_tracking_servise/models/user_plan.dart';
import 'package:berkel_tracking_servise/screens/search_screen.dart';
import 'package:berkel_tracking_servise/widgets/main_screen_widgets/custom_appbar.dart';
import 'package:berkel_tracking_servise/widgets/main_screen_widgets/customerdrawe.dart';
import 'package:berkel_tracking_servise/widgets/main_screen_widgets/fault_type_dropdown.dart';
import 'package:berkel_tracking_servise/widgets/main_screen_widgets/name_dropdown.dart';
import 'package:berkel_tracking_servise/widgets/main_screen_widgets/note_input.dart';
import 'package:berkel_tracking_servise/widgets/main_screen_widgets/save_button.dart';
import 'package:berkel_tracking_servise/widgets/main_screen_widgets/station_sector.dart';
import 'package:flutter/material.dart';

class Faultscreen extends StatefulWidget {
  const Faultscreen({super.key});

  @override
  State<Faultscreen> createState() => _FaultscreenState();
}

class _FaultscreenState extends State<Faultscreen> {
  final TextEditingController _selectedStationController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String? _selectedName;
  String? _selectedFault;
  Station? _selectedStation;

  Future<void> _openSearchScreen() async {
    final Station? selectedStation = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SearchScreen()),
    );

    if (selectedStation != null) {
      setState(() {
        _selectedStation = selectedStation;
        _selectedStationController.text = 'Kod: ${selectedStation.id} ${selectedStation.name}';
      });
    }
  }

  void _onNameSelected(String? name) {
    setState(() => _selectedName = name);
  }

  void _onFaultTypeSelected(String? faultType) {
    setState(() => _selectedFault = faultType);
  }



  @override
  void dispose() {
    _selectedStationController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      drawer: CustomDrawer(
        name: 'Arıza'
        ),
      appBar: ModernAppBar(
        title: 'Arıza',
         hasNotification: false,
        ),
      body: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFE3F2FD), // Light sky blue (top)
        Color(0xFFF1F5F9), // Soft gray/white smoke (bottom)
  ],
),

        ),
        child: SingleChildScrollView(
          padding:const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              StationSelector(
                selectorColor: const Color.fromARGB(255, 14, 134, 164),
                controller: _selectedStationController,
                onTap: _openSearchScreen,
              ),
             
              NameDropdown(
                namedropColor: Colors.blue,
                selectedName: _selectedName,
                onChanged: _onNameSelected,
              ),
              const SizedBox(height: 8),
              FaultTypeDropdown(
                selectedFaultType: _selectedFault,
                onChanged: _onFaultTypeSelected,
              ),
              const SizedBox(height: 8),
              NoteInput(
                noteColor: Colors.purple,
                controller: _noteController,
                
                ),

                
              const SizedBox(height: 16),
              SaveButton(
                buttonColor: Colors.green,
          onPressed: () async {
            if (_selectedStationController.text.isEmpty ||
          _selectedName == null ||
          _selectedFault == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Lütfen tüm alanları doldurunuz'),
            backgroundColor: Colors.red,
          ),
        );
        return;
            }
      final userPlan = UserPlanModel(
    docId: null, // Will be set by Firestore
    boothId: _selectedStation!.id.toString(),
    stationName: _selectedStationController.text,
    category: _selectedStation!.category,
    problem: _selectedFault!,
    finderName: _selectedName!,
    finderNote: _noteController.text.trim(),
    gonerName: '', // Not yet assigned
    gonerNote: '', // Not yet added
    timestamp: DateTime.now(),
    isAssigned: false,
    isDone: false,
    saveFault: false
    
  );

  try {
    await UserPlanService().addUserPlan(userPlan);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Kayıt başarıyla tamamlandı'),
        backgroundColor: Colors.green,
      ),
    );
    setState(() {
      _selectedStationController.clear();
      _noteController.clear();
      _selectedName = null;
      _selectedFault = null;
      _selectedStation = null;
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Hata oluştu: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
},
              )
            ],
          ),
        ),
      ),
    );
  }
}
