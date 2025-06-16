import 'package:berkel_tracking_servise/screens/planscreen.dart';
import 'package:berkel_tracking_servise/screens/report_screens/all_report_screen.dart';
import 'package:berkel_tracking_servise/screens/faultscreen.dart';
import 'package:berkel_tracking_servise/screens/usernavigater_screen.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final String name;

  const CustomDrawer({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFF8FAFC),
      elevation: 0,
      child: Column(
        children: [
          // Modern Header with glassmorphism effect
          _buildModernHeader(),
          
          // Menu items with modern cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                _buildModernMenuItem(
                  context,
                  icon: Icons.build_rounded,
                  title: 'Arıza Türü',
                  subtitle: 'Fault management',
                  destination: Faultscreen(),
                  color: const Color(0xFFEF4444),
                ),
                
                const SizedBox(height: 8),
                
                _buildModernMenuItem(
                  context,
                  icon: Icons.analytics_rounded,
                  title: 'Tüm Raporlar',
                  subtitle: 'View all reports',
                  destination: AllReportScreen(),
                  color: const Color(0xFF8B5CF6),
                ),
                
                const SizedBox(height: 8),
                
                _buildModernMenuItem(
                  context,
                  icon: Icons.task_rounded,
                  title: 'Plan Hazırlama',
                  subtitle: 'Create new plans',
                  destination: PlanScreen(),
                  color: const Color(0xFF06B6D4),
                ),
                
                const SizedBox(height: 8),
                
                _buildModernMenuItem(
                  context,
                  icon: Icons.people_rounded,
                  title: 'Personel',
                  subtitle: 'Manage staff',
                  destination: UsernavigaterScreen(),
                  color: const Color(0xFF10B981),
                ),
                
                const SizedBox(height: 16),
                
                // Divider with modern styling
                Container(
                  height: 1,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.grey.shade300,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 16),
                
                _buildModernMenuItem(
                  context,
                  icon: Icons.settings_rounded,
                  title: 'Settings',
                  subtitle: 'App preferences',
                  destination: null,
                  color: Colors.grey.shade600,
                  showNavArrow: false,
                ),
              ],
            ),
          ),
          
          // Modern footer
          _buildModernFooter(),
        ],
      ),
    );
  }
  
  Widget _buildModernHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF6366F1),
            const Color(0xFF8B5CF6),
            const Color(0xFFEC4899),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Avatar with modern styling
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              size: 32,
              color: Colors.white,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Name with modern typography
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          
          const SizedBox(height: 4),
          
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            
          ),
        ],
      ),
    );
  }
  
  Widget _buildModernMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget? destination,
    required Color color,
    bool showNavArrow = true,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: destination == null ? null : () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Icon container with modern styling
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: color.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Title and subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1F2937),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Navigation arrow
                if (showNavArrow)
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: Colors.grey.shade500,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildModernFooter() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // App info card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.info_outline_rounded,
                    size: 16,
                    color: const Color(0xFF6366F1),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      'Berkel Tracking Service',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}