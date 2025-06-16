import 'package:flutter/material.dart';

class NameDropdown extends StatelessWidget {
  final String? selectedName;
  final Function(String?) onChanged;
  final Color? namedropColor;

  const NameDropdown({
    super.key,
    required this.selectedName,
    required this.onChanged, this.namedropColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Teknisyen Bilgileri',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: namedropColor,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              dropdownColor: Colors.white,
              value: selectedName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen bir teknisyen seçin';
                }
                return null;
              },
              items:
                  ['Abdelrahman Ashraf', 'Cihan Bey', 'Burak Efe', 'Call Center']
                      .map(
                        (name) =>
                            DropdownMenuItem(value: name, child: Text(name)),
                      )
                      .toList(),
              onChanged: onChanged,
              decoration: InputDecoration(
                labelText: 'Ad Soyad',
                prefixIcon: const Icon(Icons.person),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
