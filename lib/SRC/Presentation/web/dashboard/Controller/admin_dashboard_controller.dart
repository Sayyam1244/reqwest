import 'package:flutter/material.dart';
import 'package:reqwest/SRC/Presentation/web/employees/employees.dart';
import 'package:reqwest/SRC/Presentation/web/orders/orders_screen.dart';
import 'package:reqwest/SRC/Presentation/web/services/services_screen.dart';
import 'package:reqwest/SRC/Presentation/web/stats/stats.dart';

class AdminDashboardController {
  AdminDashboardController._();
  static AdminDashboardController get instance => AdminDashboardController._();
  List<DashboardItemModel> dashboardItems = [
    DashboardItemModel(
      title: 'Dashboard',
      icon: Icons.dashboard,
      screen: const StatsScreen(),
    ),
    DashboardItemModel(
      title: 'Services',
      icon: Icons.design_services,
      screen: const ServicesScreen(),
    ),
    DashboardItemModel(
      title: 'Order',
      icon: Icons.shopping_cart,
      screen: const OrdersScreen(),
    ),
    DashboardItemModel(
      title: 'Employee',
      icon: Icons.people,
      screen: const EmployeesScreen(),
    ),
    // DashboardItemModel(
    //   title: 'Settings',
    //   icon: Icons.settings,
    //   screen: const SizedBox(),
    // ),
  ];
  ValueNotifier<int> index = ValueNotifier(0);
}

class DashboardItemModel {
  final String title;
  final IconData icon;
  final Widget screen;

  DashboardItemModel({
    required this.title,
    required this.icon,
    required this.screen,
  });
}
