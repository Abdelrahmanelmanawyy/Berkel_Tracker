import 'package:berkel_tracking_servise/models/user_plan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserPlanCard extends StatelessWidget {
  final UserPlanModel plan;
  final List<String> users;
  final Future<void> Function(String user, UserPlanModel plan) onAssign;
  final Future<void> Function(String docId) onDelete;

  const UserPlanCard({
    required this.plan,
    required this.users,
    required this.onAssign,
    required this.onDelete,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('HH:mm').format(plan.timestamp);
    final formattedDate = DateFormat('dd MMM').format(plan.timestamp);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Station Header
            _buildStationHeader(context),
            
            const SizedBox(height: 16),
            
            // Date & Time Row
            _buildDateTimeRow(formattedDate, formattedTime),
            
            const SizedBox(height: 16),
            
            // Problem Section with Reported By in Row
            _buildProblemAndReporterRow(),
            
            // Finder Note (if exists)
            if (plan.finderNote.isNotEmpty) ...[
              const SizedBox(height: 16),
              _buildFinderNote(),
            ],
            
            const SizedBox(height: 18),
            
            // Assignment Section
            _buildAssignmentSection(),
          ],
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.red.shade600,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Görevi Sil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          content: Text(
            'Bu görevi silmek istediğinizden emin misiniz? Bu işlem geri alınamaz.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'İptal',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await onDelete(plan.docId!);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade600,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Sil',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStationHeader(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.location_on_rounded,
            size: 20,
            color: const Color(0xFF6366F1),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            plan.stationName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
              letterSpacing: -0.3,
            ),
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (value) async {
            if (value == 'delete') {
              await _showDeleteConfirmation(context);
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'delete',
              child: Row(
                children: [
                  Icon(
                    Icons.delete_outline_rounded,
                    size: 18,
                    color: Colors.red.shade600,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Görevi Sil',
                    style: TextStyle(
                      color: Colors.red.shade600,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              Icons.more_horiz_rounded,
              color: Colors.grey.shade500,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimeRow(String formattedDate, String formattedTime) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today_rounded,
            size: 16,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 8),
          Text(
            formattedDate,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Icon(
            Icons.schedule_rounded,
            size: 16,
            color: Colors.grey.shade600,
          ),
          const SizedBox(width: 8),
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProblemAndReporterRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Problem Section
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Problem Description
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sorun Açıklaması',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF3C7),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFFDE68A), width: 1),
                    ),
                    child: Text(
                      plan.problem,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF92400E),
                        height: 1.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Reported By Section
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Raporlayan',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_rounded,
                          size: 16,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            plan.finderName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF374151),
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFinderNote() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDBEAFE), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.sticky_note_2_rounded,
                size: 16,
                color: const Color(0xFF2563EB),
              ),
              const SizedBox(width: 8),
              Text(
                'Ek Notlar',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1D4ED8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            plan.finderNote,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF1E40AF),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignmentSection() {
    if (!plan.isAssigned && users.isNotEmpty) {
      return _buildUnassignedSection();
    } else if (plan.isAssigned) {
      return _buildAssignedSection();
    }
    return const SizedBox.shrink();
  }

  Widget _buildUnassignedSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Görevi Ata',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: users.map((user) {
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onAssign(user, plan),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF6366F1).withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person_add_rounded,
                        size: 16,
                        color: const Color(0xFF6366F1),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        user,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF4F46E5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAssignedSection() {
    final isCompleted = plan.isDone;
    final statusColor = isCompleted ? const Color(0xFF059669) : const Color(0xFFD97706);
    final bgColor = isCompleted 
        ? const Color(0xFFECFDF5) 
        : const Color(0xFFFEF3C7);
    final borderColor = isCompleted 
        ? const Color(0xFFBBF7D0) 
        : const Color(0xFFFDE68A);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isCompleted 
                  ? Icons.check_circle_rounded 
                  : Icons.schedule_rounded,
              size: 18,
              color: statusColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Görev Durumu',
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  isCompleted ? 'Tamamlandı' : 'Devam Ediyor',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: statusColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}