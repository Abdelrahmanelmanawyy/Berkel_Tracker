import 'package:flutter/material.dart';

class ModernAppBar2 extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Icon icon;
  final VoidCallback? onSearch;
  final VoidCallback? onMore;

  const ModernAppBar2({
    Key? key,
    required this.title,
    required this.icon,
    this.onSearch,
    this.onMore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey[800],
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
              ),
            ),
            child: Center(
              child: Icon(
                icon.icon, // Use the passed icon
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      actions: [
        if (onSearch != null)
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: onSearch,
          ),
        if (onMore != null)
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: onMore,
          ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(height: 1, color: Colors.grey[200]),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}
