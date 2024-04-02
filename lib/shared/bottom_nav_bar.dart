import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../routes.dart';

class BottomNavBarItemParams {
  final String label;
  final IconData icon;
  final String routeName;

  const BottomNavBarItemParams({
    required this.label,
    required this.icon,
    required this.routeName,
  });
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  static const Map<int, BottomNavBarItemParams> bottomNavBarItems = {
    0: BottomNavBarItemParams(
      label: AppRouteLabel.about,
      icon: FontAwesomeIcons.info,
      routeName: AppRoutePath.about,
    ),
    1: BottomNavBarItemParams(
      label: AppRouteLabel.profile,
      icon: FontAwesomeIcons.user,
      routeName: AppRoutePath.profile,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: bottomNavBarItems.entries
          .map(
            (entry) => BottomNavigationBarItem(
              icon: Icon(entry.value.icon),
              label: entry.value.label,
            ),
          )
          .toList(),
      onTap: (index) {
        Navigator.pushNamed(context, bottomNavBarItems[index]!.routeName);
      },
    );
  }
}
