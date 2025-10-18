import 'package:flutter/material.dart';
import 'package:inventor_desgin_studio/header/top_header.dart';
import 'package:inventor_desgin_studio/components/user_summary.dart';
import 'package:inventor_desgin_studio/components/stats_panel.dart';
import 'package:inventor_desgin_studio/components/recent_projects.dart';
import 'package:inventor_desgin_studio/components/quick_actions.dart';
import 'package:inventor_desgin_studio/components/design_tools.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              sliver: SliverPersistentHeader(
                pinned: true,
                delegate: _PinnedHeaderDelegate(
                  minExtentHeight: 60,
                  maxExtentHeight: 68,
                  child: const TopBar(),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 20),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const UserSummary(),
                  const SizedBox(height: 16),
                  const StatsPanel(),
                  const SizedBox(height: 16),
                  const RecentProjects(),
                  const SizedBox(height: 16),
                  const QuickActions(),
                  const SizedBox(height: 16),
                  const DesignTools(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



/* ================================ TOP BAR ============================= */

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TopBarSliver(height: 70),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) => ListTile(title: Text("Item $index")),
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}








class _PinnedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minExtentHeight;
  final double maxExtentHeight;
  final Widget child;

  const _PinnedHeaderDelegate({
    required this.minExtentHeight,
    required this.maxExtentHeight,
    required this.child,
  });

  @override
  double get minExtent => minExtentHeight;

  @override
  double get maxExtent => maxExtentHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.transparent,
      child: child,
    );
  }

  @override
  bool shouldRebuild(covariant _PinnedHeaderDelegate oldDelegate) {
    return oldDelegate.minExtentHeight != minExtentHeight ||
        oldDelegate.maxExtentHeight != maxExtentHeight ||
        oldDelegate.child != child;
  }
}