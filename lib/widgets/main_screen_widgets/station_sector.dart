import 'package:flutter/material.dart';

class StationSelector extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onTap;
  final Color? selectorColor;

  const StationSelector({
    Key? key,
    required this.controller,
    required this.onTap,
    this.selectorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = selectorColor ?? const Color(0xFF06B6D4);
    
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
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon - matching the design pattern
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: color.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.location_on_rounded,
                    size: 20,
                    color: color,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'İstasyon Bilgileri',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 18),
            
            // Modern selector field
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 1,
                  ),
                ),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: controller,
                    readOnly: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen bir istasyon seçin';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF374151),
                    ),
                    decoration: InputDecoration(
                      hintText: 'İstasyon seçmek için tıklayın',
                      hintStyle: const TextStyle(
                        color: Color(0xFF9CA3AF),
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Icon(
                        Icons.train_rounded,
                        color: color,
                        size: 20,
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.search_rounded,
                          color: Colors.grey.shade600,
                          size: 16,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}