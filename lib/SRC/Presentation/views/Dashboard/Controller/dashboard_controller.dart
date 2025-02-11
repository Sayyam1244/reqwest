import 'package:flutter/material.dart';
import 'package:reqwest/SRC/Presentation/views/AllTasks/all_tasks_screen.dart';
import 'package:reqwest/SRC/Presentation/views/Home/home_screen.dart';
import 'package:reqwest/SRC/Presentation/views/Profile/profile_screen.dart';
import 'package:reqwest/SRC/Presentation/views/Search/search_screen.dart';
import 'package:reqwest/gen/assets.gen.dart';

class DashboardController {
  DashboardController._();
  static DashboardController get instance => DashboardController._();
  List<DashboardItemModel> dashboardItems = [
    DashboardItemModel(
      title: 'Home',
      icon: Assets.icons.home,
      screen: const HomeScreen(),
    ),
    DashboardItemModel(
      title: 'Search',
      icon: Assets.icons.search,
      screen: const SearchScreen(),
    ),
    DashboardItemModel(
      title: 'Task',
      icon: Assets.icons.task,
      screen: const AllTasksScreen(),
    ),
    DashboardItemModel(
      title: 'Profile',
      icon: Assets.icons.profile,
      screen: const ProfileScreen(),
    ),
  ];
  ValueNotifier<int> index = ValueNotifier(0);
}

class DashboardItemModel {
  final String title;
  final String icon;
  final Widget screen;

  DashboardItemModel({
    required this.title,
    required this.icon,
    required this.screen,
  });
}
