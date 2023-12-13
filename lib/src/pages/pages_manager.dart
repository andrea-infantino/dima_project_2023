import 'package:dima_project_2023/src/pages/achievements.dart';
import 'package:dima_project_2023/src/pages/friends.dart';
import 'package:dima_project_2023/src/pages/home.dart';
import 'package:dima_project_2023/src/pages/leaderboard.dart';
import 'package:flutter/material.dart';

/// Stateful Widget which manage and switch pages through a Navigation Bar
class PagesManager extends StatefulWidget {
  const PagesManager({super.key});

  @override
  State<StatefulWidget> createState() => _PagesManagerState();
}

class _PagesManagerState extends State<PagesManager> {
  int index = 0;

  @override
  Widget build(context) {
    return Scaffold(
      body: IndexedStack(
        index: index,
        children: <Widget>[
          const HomePage(),
          const FriendsPage(),
          const LeaderboardPage(),
          const AchievementsPage() // TODO: AchievementsPage
        ],
      ),
      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: index,
        onDestinationSelected: (index) => setState(() => this.index = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Social',
          ),
          NavigationDestination(
            icon: Icon(Icons.leaderboard_outlined),
            selectedIcon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.emoji_events_outlined),
            selectedIcon: Icon(Icons.emoji_events),
            label: 'Achievements',
          ),
        ],
      ),
    );
  }
}
