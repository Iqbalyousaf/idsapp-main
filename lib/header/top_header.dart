import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/button_components/logo.dart';
import 'package:inventor_desgin_studio/theme/constants.dart';
import 'package:inventor_desgin_studio/button_components/three_icon_button.dart';
class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: kPanel,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: kStroke),
      ),
      child: Row(
        children: [
          const LogoAnimation(size: 28),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Design Studio',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
                SizedBox(height: 1),
                Text('Welcome back, Designer',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white60, fontSize: 11)),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Search',
            onPressed: () {},
            icon: const Icon(Icons.search, color: Colors.white70),
          ),
          _BellWithDropdown(
            notifications: const [
              _NotifItem('New comment on “Mobile App UI”', '2m'),
              _NotifItem('File approved: brand_guidelines.pdf', '1h'),
              _NotifItem('Anna invited you to “Dashboard Design”', 'yesterday'),
            ],
          ),
          const SizedBox(width: 4),
          const UserMenu(),
        ],
      ),
    );
  }
}

/// 🔹 Sliver Delegate for Pinned Header
class TopBarSliver extends SliverPersistentHeaderDelegate {
  final double height;

  TopBarSliver({required this.height});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const TopBar(); // 👈 hamara TopBar yahan render ho raha
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}

/* ----------------- Notification bell (dropdown / popup) ---------------- */
class _NotifItem {
  final String title;
  final String time;
  const _NotifItem(this.title, this.time);
}

class _BellWithDropdown extends StatefulWidget {
  final List<_NotifItem> notifications;
  const _BellWithDropdown({required this.notifications});

  @override
  State<_BellWithDropdown> createState() => _BellWithDropdownState();
}

class _BellWithDropdownState extends State<_BellWithDropdown> {
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
    final bottomRight = renderObject.localToGlobal(renderObject.size.bottomRight(Offset.zero));
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
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 320),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(12, 10, 12, 6),
                  child: Text('Notifications',
                      style: TextStyle(fontWeight: FontWeight.w700)),
                ),
                const Divider(height: 1, color: kStroke),
                ...widget.notifications.map(
                      (n) => InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                      child: Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: kNeon.withValues(alpha: .18),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.notifications_active,
                                color: kNeon, size: 18),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(n.title,
                                style: const TextStyle(fontSize: 13)),
                          ),
                          const SizedBox(width: 8),
                          Text(n.time,
                              style: const TextStyle(
                                  color: Colors.white54, fontSize: 12)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          key: _key,
          tooltip: 'Notifications',
          onPressed: _openMenu,
          icon: const Icon(Icons.notifications_none, color: Colors.white70),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(color: kNeon, shape: BoxShape.circle),
          ),
        )
      ],
    );
  }
}
