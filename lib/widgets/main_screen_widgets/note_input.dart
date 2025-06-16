import 'package:flutter/material.dart';



class NoteInput extends StatelessWidget {
  final TextEditingController controller;
  final Color? noteColor;

  const NoteInput({
    super.key,
    required this.controller,
    this.noteColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = noteColor ?? const Color(0xFF8B5CF6);
    
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
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
        padding: const EdgeInsets.all(6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.sticky_note_2_rounded,
                    size: 20,
                    color: color,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Notlar',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 18),
            
            // Modern text field
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                  width: 1,
                ),
              ),
              child: TextFormField(
                controller: controller,
                maxLines: 4,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF374151),
                  height: 1.5,
                ),
                decoration: InputDecoration(
                  hintText: 'İşlem ile ilgili notlarınızı buraya yazın...',
                  hintStyle: const TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Icon(
                      Icons.edit_note_rounded,
                      color: color,
                      size: 20,
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}