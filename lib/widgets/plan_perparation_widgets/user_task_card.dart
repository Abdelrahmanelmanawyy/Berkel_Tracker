import 'package:flutter/material.dart';
import 'package:berkel_tracking_servise/models/user_plan.dart';
import 'package:berkel_tracking_servise/firebase_services/firestoreservies.dart';

class UserTaskCard extends StatefulWidget {
  final UserPlanModel task;
  final UserPlanService userPlanService;

  const UserTaskCard({
    super.key,
    required this.task,
    required this.userPlanService,
  });

  @override
  State<UserTaskCard> createState() => _UserTaskCardState();
}

class _UserTaskCardState extends State<UserTaskCard> {
  final TextEditingController _noteTakerController = TextEditingController();

  @override
  void dispose() {
    _noteTakerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Location
                      Row(
                        children: [
                          Container(
                            width: 3,
                            height: 18,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.orange.shade600, Colors.orange.shade400],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.location_on_outlined,
                            size: 16,
                            color: Colors.orange.shade600,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.task.stationName,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Problem
                      Row(
                        children: [
                          const SizedBox(width: 15),
                          Icon(
                            Icons.error_outline,
                            size: 16,
                            color: Colors.blue.shade600,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              widget.task.problem,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // Finder Note
                      if (widget.task.finderNote.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(width: 15),
                            Icon(
                              Icons.note_outlined,
                              size: 16,
                              color: Colors.green.shade600,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                widget.task.finderNote,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // Action buttons
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _ModernActionButton(
                      onPressed: () async {
                        if (widget.task.docId != null) {
                           final note = _noteTakerController.text.trim();
                          await widget.userPlanService.updateUserPlanDoneStatus(
                            widget.task.docId!,
                            true,
                            note,
                            DateTime.now(),
                        
                            
                          );
                        }
                      },
                      label: "Done",
                      icon: Icons.check_circle,
                      color: Colors.green.shade600,
                      backgroundColor: Colors.green.shade50,
                    ),
                    const SizedBox(height: 8),
                    _ModernActionButton(
                      onPressed: () async {
                        if (widget.task.docId != null) {
                          await widget.userPlanService.updateUserPlanAssignedStatus(
                            widget.task.docId!,
                            false,

                          );
                        }
                      },
                      label: "Remove",
                      icon: Icons.delete_outline,
                      color: Colors.red.shade600,
                      backgroundColor: Colors.red.shade50,
                    ),
                  ],
                ),
              ],
            ),
            // Note taker input
            const SizedBox(height: 16),
            Row(
              children: [
                const SizedBox(width: 15),
                Icon(
                  Icons.person_outline,
                  size: 16,
                  color: Colors.purple.shade600,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                    ),
                    child: TextField(
                      controller: _noteTakerController,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: "Not alan kişi",
                        hintStyle: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ModernActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const _ModernActionButton({
    required this.onPressed,
    required this.label,
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.15), width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 16, color: color),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
