import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? buttonColor;
  final String label;
  final IconData icon;

  const SaveButton({
    super.key,
    required this.onPressed,
    this.buttonColor,
    this.label = 'KAYDET',
    this.icon = Icons.save_rounded,
  });

  @override
  Widget build(BuildContext context) {
    // Default to blue if no custom color is passed
    final primaryBlue = buttonColor ?? const Color(0xFF2196F3); // Light Blue
    final secondaryBlue = const Color(0xFF1565C0); // Darker Blue

    return SizedBox(
      width: double.infinity,
      height: 42,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryBlue, secondaryBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: primaryBlue.withOpacity(0.25),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onPressed,
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(icon, color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
