import 'package:flutter/material.dart';

class CustomCheckboxGroup extends StatelessWidget {
  final List<bool> checkboxes;
  final Function(int index, bool value) onChanged;

  const CustomCheckboxGroup({
    super.key,
    required this.checkboxes,
    required this.onChanged,
  });

  static const List<String> _checkboxLabels = [
    'Para Makinesi',
    'Temizlik',
    'Kamera',
    'İnternet',
    'LED',
    'Plexi',
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Control',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 0,
              children: List.generate(_checkboxLabels.length, (index) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: checkboxes[index],
                      onChanged: (value) => onChanged(index, value!),
                    ),
                    Text(
                      _checkboxLabels[index],
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
