
import 'package:flutter/material.dart';

class ModernAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onMenuPressed;
  final VoidCallback? onSearchPressed;
  final VoidCallback? onNotificationPressed;
  final VoidCallback? onSettingsPressed;
  final VoidCallback? onProfilePressed;
  final bool hasNotification;

  const ModernAppBar({
    Key? key,
    required this.title,
    this.onMenuPressed,
    this.onSearchPressed,
    this.onNotificationPressed,
    this.onSettingsPressed,
    this.onProfilePressed,
    this.hasNotification = false,
  }) : super(key: key);

  @override
  State<ModernAppBar> createState() => _ModernAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ModernAppBarState extends State<ModernAppBar> {
  bool _isSearchExpanded = false;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      backgroundColor: Colors.white,
      foregroundColor: Colors.grey[800],
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.grey[200],
      leading: _buildMenuButton(),
      title: _buildTitle(),
      actions: _buildActions(),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey[100],
          height: 1.0,
        ),
      ),
    );
  }

  Widget _buildMenuButton() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: widget.onMenuPressed ?? () => Scaffold.of(context).openDrawer(),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.menu_rounded,
              color: Colors.grey[700],
              size: 24,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    if (_isSearchExpanded) {
      return _buildSearchField();
    }

    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF3B82F6), // Blue
                Color(0xFF8B5CF6), // Purple
              ],
            ),
          ),
          child: const Center(
            child: Text(
              'A',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey[900],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        controller: _searchController,
        focusNode: _searchFocusNode,
        decoration: InputDecoration(
          hintText: 'İstasyon seçmek için tıklayın',
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.grey[400],
            size: 20,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.close_rounded,
              color: Colors.grey[600],
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _isSearchExpanded = false;
                _searchController.clear();
              });
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
        style: const TextStyle(fontSize: 14),
        onSubmitted: (value) {
          widget.onSearchPressed?.call();
        },
      ),
    );
  }

  List<Widget> _buildActions() {
    return [
      // Search Button
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              if (!_isSearchExpanded) {
                setState(() {
                  _isSearchExpanded = true;
                });
                _searchFocusNode.requestFocus();
              } else {
                widget.onSearchPressed?.call();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.search_rounded,
                color: Colors.grey[700],
                size: 22,
              ),
            ),
          ),
        ),
      ),

      // Notification Button
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: widget.onNotificationPressed,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Stack(
                children: [
                  Icon(
                    Icons.notifications_outlined,
                    color: Colors.grey[700],
                    size: 22,
                  ),
                  if (widget.hasNotification)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.red[500],
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),

      // Settings Button
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: widget.onSettingsPressed,
            child: Container(
              padding: const EdgeInsets.all(12),
              child: Icon(
                Icons.settings_outlined,
                color: Colors.grey[700],
                size: 22,
              ),
            ),
          ),
        ),
      ),

      // Profile Button
      Container(
        margin: const EdgeInsets.only(left: 4, right: 12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: widget.onProfilePressed ?? () => _showProfileMenu(context),
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.grey[300]!,
                          Colors.grey[400]!,
                        ],
                      ),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.grey[600],
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: Colors.grey[700],
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];
  }

  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              margin: const EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            
            // Profile Info
            Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.grey[300]!, Colors.grey[400]!],
                      ),
                    ),
                    child: Icon(
                      Icons.person_outline,
                      color: Colors.grey[600],
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kullanıcı',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.grey[900],
                        ),
                      ),
                      Text(
                        'user@example.com',
                        style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Menu Items
            _buildMenuItem(Icons.person_outline, 'Profil', () {}),
            _buildMenuItem(Icons.settings_outlined, 'Ayarlar', () {}),
            _buildMenuItem(Icons.help_outline, 'Yardım', () {}),
            
            const Divider(height: 1),
            
            _buildMenuItem(
              Icons.logout_rounded, 
              'Çıkış Yap', 
              () {},
              isDestructive: true,
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
    IconData icon, 
    String title, 
    VoidCallback onTap, {
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isDestructive ? Colors.red[600] : Colors.grey[700],
        size: 22,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isDestructive ? Colors.red[600] : Colors.grey[800],
          fontSize: 16,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}



