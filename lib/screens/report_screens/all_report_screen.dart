import 'package:berkel_tracking_servise/screens/new/report_navigator.dart';
import 'package:berkel_tracking_servise/screens/report_screens/fault_report_details_screen.dart';
import 'package:berkel_tracking_servise/widgets/main_screen_widgets/customerdrawe.dart';
import 'package:berkel_tracking_servise/widgets/main_screen_widgets/modern_custome_appbar.dart';
import 'package:flutter/material.dart';

class AllReportScreen extends StatefulWidget {
  const AllReportScreen({super.key});

  @override
  State<AllReportScreen> createState() => _AllReportScreenState();
}

class _AllReportScreenState extends State<AllReportScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<ReportSection> _reportSections = [
    ReportSection(
      title: 'Tüm Kabin',
      icon: Icons.apartment_rounded,
      color: Colors.green,
      description: 'Kabin durumu ve raporları',
    ),
    ReportSection(
      title: 'Arıza',
      icon: Icons.warning_rounded,
      color: Colors.red,
      description: 'Arıza raporları ve takibi',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onSectionSelected(int index) {
    if (index != _selectedIndex) {
      _animationController.reset();
      setState(() {
        _selectedIndex = index;
      });
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: ModernAppBar2(
        title: 'Raporlar',
        icon: Icon(Icons.bar_chart),
      ),
      drawer: CustomDrawer(name: 'raporlar'),
      body: Column(
        children: [
          _buildNavigationTabs(),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: IndexedStack(
                index: _selectedIndex,
                children: [
                  _buildAllCabinView(),
                  _buildFaultView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

 

  Widget _buildNavigationTabs() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _reportSections.length,
        itemBuilder: (context, index) {
          final section = _reportSections[index];
          final isSelected = index == _selectedIndex;
          
          return GestureDetector(
            onTap: () => _onSectionSelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected ? section.color.withOpacity(0.1) : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? section.color : Colors.grey[300]!,
                  width: isSelected ? 2 : 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    section.icon,
                    color: isSelected ? section.color : Colors.grey[600],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    section.title,
                    style: TextStyle(
                      color: isSelected ? section.color : Colors.grey[700],
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAllCabinView() {
    return const AllReportNavigator();
  }

  Widget _buildFaultView() {
    return const FaultListScreen();
  }
}

class ReportSection {
  final String title;
  final IconData icon;
  final Color color;
  final String description;

  ReportSection({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
  });
}