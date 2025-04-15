import 'package:flutter/material.dart';
import 'package:reqwest/SRC/Application/Services/AuthServices/auth_services.dart';
import 'package:reqwest/SRC/Presentation/Common/app_icon_handler.dart';
import 'package:reqwest/SRC/Presentation/views/Dashboard/Controller/dashboard_controller.dart';
import 'package:collection/collection.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardController controller = DashboardController.instance;
  @override
  void initState() {
    if (AuthServices.instance.userModel!.role != 'customer') {
      controller.dashboardItems.removeAt(1);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: controller.index,
        builder: (context, value, child) =>
            controller.dashboardItems[value].screen,
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: controller.index,
        builder: (context, value, child) => BottomNavigationBar(
          currentIndex: value,
          onTap: (v) {
            setState(() {
              controller.index.value = v;
            });
          },
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.secondary,
          type: BottomNavigationBarType.fixed,
          items: controller.dashboardItems
              .mapIndexed(
                (i, e) => BottomNavigationBarItem(
                  icon: DynamicAppIconHandler.buildIcon(
                    margins: const EdgeInsets.only(bottom: 4),
                    context: context,
                    svg: e.icon,
                    iconColor: i == value
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                  ),
                  label: e.title,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
