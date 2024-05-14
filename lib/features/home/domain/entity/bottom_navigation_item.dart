// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';

import '../../../dashboard/presentation/pages/home_page.dart';
import '../../../directories/presentation/directories_page.dart';
import '../../../notifications/presentation/notifications_page.dart';
import '../../../users/presentation/users_page.dart';

enum BottomNavigationItem {
  home(icon: Icons.home, routeName: HomePage.routeName),
  users(icon: Icons.account_circle, routeName: UsersPage.routeName),
  notifications(icon: Icons.history, routeName: NotificationsPage.routeName),
  directories(icon: Icons.folder, routeName: DirectoriesPage.routeName);

  final IconData icon;
  final String routeName;

  const BottomNavigationItem({required this.icon, required this.routeName});

  String get title => switch (this) {
        home => 'Home',
        users => 'Users',
        notifications => 'Notifications',
        directories => 'Directories',
      };

  static int getIndexForLocation(String? location) =>
      BottomNavigationItem.values
          .firstWhere(
            (element) => location?.startsWith(element.routeName) == true,
            orElse: () => BottomNavigationItem.home,
          )
          .index;
}
