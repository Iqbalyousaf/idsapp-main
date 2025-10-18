import 'package:flutter/material.dart';

import '../screens/login_screen.dart';
import '../theme/constants.dart';
import 'package:inventor_desgin_studio/services/auth_service.dart';

class UserMenu extends StatefulWidget {
  const UserMenu({super.key});

  @override
  State<UserMenu> createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  final GlobalKey _key = GlobalKey();

  void _openMenu() {
    final targetContext = _key.currentContext;
    if (targetContext == null) return;

    final renderObject = targetContext.findRenderObject();
    if (renderObject is! RenderBox) return;

    final overlayRenderObject = Overlay.maybeOf(context)?.context.findRenderObject();
    Rect overlayRect;
    if (overlayRenderObject is RenderBox) {
      overlayRect = Offset.zero & overlayRenderObject.size;
    } else {
      final size = MediaQuery.of(context).size;
      overlayRect = Offset.zero & size;
    }

    final topLeft = renderObject.localToGlobal(Offset.zero);
    final bottomRight =
    renderObject.localToGlobal(renderObject.size.bottomRight(Offset.zero));
    final targetRect = Rect.fromPoints(topLeft, bottomRight);

    showMenu(
      context: context,
      color: kCard,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      position: RelativeRect.fromRect(targetRect, overlayRect),
      items: [
        PopupMenuItem(
          enabled: false,
          padding: EdgeInsets.zero,
          child: Container(
            width: 220,
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Profile Info
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                        "https://i.pravatar.cc/150?img=5", // 👈 yahan apni user pic do
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("John Doe",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                          SizedBox(height: 2),
                          Text("UI/UX Designer",
                              style: TextStyle(
                                  fontSize: 12, color: Colors.white60)),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 20, color: kStroke),

                // 🔹 Logout Button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: () async {
                      debugPrint("Logout pressed!");
                      try {
                        await AuthService().logout();
                      } catch (_) {}
                      if (!mounted) return;
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.logout, color: Colors.red, size: 18),
                    label: const Text("Logout",
                        style: TextStyle(color: Colors.red)),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      key: _key,
      tooltip: "User Menu",
      onPressed: _openMenu,
      icon: const Icon(Icons.more_vert, color: Colors.white70),
    );
  }
}
