import 'package:berkel_tracking_servise/widgets/main_screen_widgets/customerdrawe.dart';
import 'package:berkel_tracking_servise/widgets/main_screen_widgets/modern_custome_appbar.dart';
import 'package:flutter/material.dart';
import 'package:berkel_tracking_servise/screens/user_screen.dart';

class UsernavigaterScreen extends StatefulWidget {
  @override
  _UsernavigaterScreenState createState() => _UsernavigaterScreenState();
}

class _UsernavigaterScreenState extends State<UsernavigaterScreen> {
  final List<Map<String, dynamic>> personData = [
    {
      'name': 'abdelrahman',
      'displayName': 'Abdelrahman',
      
    },
    {
      'name': 'burak',
      'displayName': 'Burak Efe',
   
    },
    {
      'name': 'cihan bey',
      'displayName': 'Cihan Bey',
     
    },
  ];

  int selectedIndex = 0;
  final Color _primaryColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(name: 'Personli Plan'),
      appBar: ModernAppBar2(title: 'Personli Plan', icon: Icon(Icons.engineering)),
      body: Column(
        children: [
          // Modern buttons at the top
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(
                bottom: BorderSide(color: Colors.grey[200]!, width: 1),
              ),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(personData.length, (index) {
                  final person = personData[index];
                  final isSelected = selectedIndex == index;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: Material(
                        elevation: isSelected ? 3 : 1,
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: isSelected
                                  ? LinearGradient(
                                      colors: [
                                        _primaryColor,
                                        _primaryColor.withOpacity(0.8),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              color: isSelected ? null : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? _primaryColor
                                    : Colors.grey[300]!,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  person['icon'],
                                  size: 18,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey[600],
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  person['displayName'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected
                                        ? FontWeight.w600
                                        : FontWeight.w500,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey[700],
                                  ),
                                ),
                                if (isSelected) ...[
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),

          const Divider(height: 1),

          Expanded(
            child: UserScreen(
              userName: personData[selectedIndex]['name'],
            ),
          ),
        ],
      ),
    );
  }
}