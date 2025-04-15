import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Data/Resources/Colors/light_colors_palate.dart';
import 'package:reqwest/SRC/Presentation/Common/logo_widget.dart';
import 'package:reqwest/SRC/Presentation/web/dashboard/Controller/admin_dashboard_controller.dart';
import 'package:collection/collection.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final AdminDashboardController adminDashboardController = AdminDashboardController.instance;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: adminDashboardController.index,
        builder: (context, value, child) => Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                color: LightColorsPalate.sheetGred1,
                child: Column(
                  children: [
                    24.verticalSpace,
                    LogoWidget(firstColor: theme.colorScheme.primary, secondColor: theme.colorScheme.surface),
                    Divider(color: theme.colorScheme.surface),
                    70.verticalSpace,
                    ...adminDashboardController.dashboardItems.mapIndexed(
                      (index, element) => InkWell(
                        onTap: () {
                          adminDashboardController.index.value = index;
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 8.h),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: index == value
                                ? theme.colorScheme.primary.withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                element.icon,
                                color: index == value
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.surface.withOpacity(0.7),
                              ),
                              12.horizontalSpace,
                              Text(
                                element.title,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w300,
                                  color: index == value
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.surface.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container(
                margin: const EdgeInsets.all(24),
                color: theme.colorScheme.surface,
                child: adminDashboardController.dashboardItems[adminDashboardController.index.value].screen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
