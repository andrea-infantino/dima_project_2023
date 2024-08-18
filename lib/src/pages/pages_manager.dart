import 'package:dima_project_2023/assets/colors.dart';
import 'package:dima_project_2023/src/pages/achievements.dart';
import 'package:dima_project_2023/src/pages/friends.dart';
import 'package:dima_project_2023/src/pages/home.dart';
import 'package:dima_project_2023/src/pages/leaderboard.dart';
import 'package:dima_project_2023/main.dart';
import 'package:flutter/material.dart';

/// Stateful Widget which manage and switch pages through a Navigation Bar
class PagesManager extends StatefulWidget {
  const PagesManager({super.key});

  @override
  State<StatefulWidget> createState() => _PagesManagerState();
}

class _PagesManagerState extends State<PagesManager> {
  int _index = 0;
  final PageController _controller = PageController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Wait for all the network requests
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(context) {
      return Scaffold(
        body: Stack(
        children: [
          Column(
          children: [
            const SizedBox(height: 75),
            Expanded(
          child: OrientationBuilder(builder: (context, orientation) {
          if (deviceType == 1) {

            if (orientation == Orientation.portrait) {
              return Center(
                child: Column(
                  children: [
                    const Expanded(
                      child: HomePage()
                    ),
                    const Divider(height: 2),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView(
                              controller: _controller,
                              onPageChanged: (int page) {
                                setState(() {
                                  _index = page;
                                });
                              },
                              children: const [
                                FriendsPage(),
                                LeaderboardPage(),
                                AchievementsPage(),
                              ],
                          ),
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (index) => buildDot(index, context)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            else {

              return Center(
                child: Row(
                  children: [
                    const Expanded(
                      child: HomePage()
                    ),
                    const VerticalDivider(width: 2),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          PageView(
                              controller: _controller,
                              onPageChanged: (int page) {
                                setState(() {
                                  _index = page;
                                });
                              },
                              children: const [
                                FriendsPage(),
                                LeaderboardPage(),
                                AchievementsPage(),
                              ],
                          ),
                          SizedBox(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(3, (index) => buildDot(index, context)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }

          return Scaffold(
            body: IndexedStack(
              index: _index,
              children: const <Widget>[
                HomePage(),
                FriendsPage(),
                LeaderboardPage(),
                AchievementsPage()
              ],
            ),
            bottomNavigationBar: NavigationBar(
              height: 60,
              selectedIndex: _index,
              onDestinationSelected: (index) => setState(() => _index = index),
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
      )
      )]),

      if (_isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
      ]));
  }

  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      height: 12.0,
      width: _index == index ? 24.0 : 12.0,
      decoration: BoxDecoration(
        color: _index == index ? WATER_GREEN : Colors.grey,
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}
