import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:home/presentation/screens/home_screen.dart';
import 'package:core/injector.dart' as di;
import 'package:leaderboard/presentation/screens/leaderboard_screen.dart';
import 'package:profile/presentation/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  void setIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Widget buildBody(BuildContext context) {
    switch (currentIndex) {
      case 0:
        return HomeScreen(
          learningTopicBloc: di.locator(),
          shortProfileBloc: di.locator(),
        );
      case 1:
        return LeaderboardScreen(
          leaderboardBloc: di.locator(),
        );
      case 2:
        return ProfileScreen(
          profileBloc: di.locator(),
        );
      default:
        return HomeScreen(
          learningTopicBloc: di.locator(),
          shortProfileBloc: di.locator(),
        );
    }
  }

  BottomNavigationBar buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: accentColor,
      unselectedItemColor: secondaryTextColor,
      backgroundColor: backgroundColor,
      showUnselectedLabels: true,
      currentIndex: currentIndex,
      onTap: setIndex,
      items: bottomNavigationBarItems(),
    );
  }

  List<BottomNavigationBarItem> bottomNavigationBarItems() {
    return const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.leaderboard),
        label: "Leaderboard",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: "Profile",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: buildBottomNavigationBar(context),
      body: buildBody(context),
    );
  }
}
