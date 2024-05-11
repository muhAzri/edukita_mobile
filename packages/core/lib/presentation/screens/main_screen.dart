import 'package:core/common/styles.dart';
import 'package:flutter/material.dart';

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
        return const Placeholder();
      case 1:
        return const Placeholder();
      case 2:
        return const Placeholder();
      default:
        return const Placeholder();
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
      backgroundColor: backgroundColor,
      bottomNavigationBar: buildBottomNavigationBar(context),
      body: buildBody(context),
    );
  }
}