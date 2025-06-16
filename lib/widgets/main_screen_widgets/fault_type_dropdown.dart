import 'package:flutter/material.dart';

// Modern Fault Type Dropdown
class FaultTypeDropdown extends StatelessWidget {
  final String? selectedFaultType;
  final Function(String?) onChanged;

  const FaultTypeDropdown({
    super.key,
    required this.selectedFaultType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
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
            // Header with icon
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.warning_rounded,
                    size: 20,
                    color: Color(0xFFEF4444),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Arıza Türü',
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
            
            // Modern dropdown
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF8FAFC),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE5E7EB),
                  width: 1,
                ),
              ),
              child: DropdownButtonFormField<String>(
                value: selectedFaultType,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Lütfen bir arıza türü seçin';
                  }
                  return null;
                },
                items: [
                  'Kamera',
                  'Bilgisayar',
                  'Ekran',
                  'Para makinesi',
                  'Led',
                  'Plexi',
                  'Yazıcı',
                  'Kontrol',
                  'Citizen Kağıt',
                  'RX1 Kağıt',
                  'Kamera camı',
                  'Tahsilat',
                  'Kredi kart cihaz'
                ].map((name) => DropdownMenuItem(
                  value: name,
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF374151),
                    ),
                  ),
                )).toList(),
                onChanged: onChanged,
                decoration: const InputDecoration(
                  hintText: 'Arıza türünü seçin',
                  hintStyle: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(
                    Icons.error_outline_rounded,
                    color: Color(0xFFEF4444),
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}