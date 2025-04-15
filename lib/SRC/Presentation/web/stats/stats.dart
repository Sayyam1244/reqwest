import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/task_service.dart';
import 'package:reqwest/SRC/Presentation/web/orders/orders_screen.dart';
import 'package:reqwest/SRC/Presentation/web/stats/widgets/stat_card.dart';
import 'package:reqwest/SRC/Presentation/web/stats/widgets/charts/line_chart_widget.dart';
import 'package:reqwest/SRC/Presentation/web/stats/widgets/charts/bar_chart_widget.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DASHBOARD',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          30.verticalSpace,
          StreamBuilder(
              stream: TaskService.instance.getAllTasks(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error ?? 'Error occurred'}"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LinearProgressIndicator();
                }
                final data = snapshot.data;
                if (data != null || data!.isNotEmpty) {
                  return Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          title: 'Total order',
                          value: _getFilteredTaskCount(data, null).toString(),
                          color: Colors.green,
                          chartBuilder: (period) => LineChartWidget(
                            tasks: data,
                            period: period,
                          ),
                        ),
                      ),
                      20.horizontalSpace,
                      Expanded(
                        child: StatCard(
                          title: 'Total completed',
                          value: _getFilteredTaskCount(data, 'completed').toString(),
                          color: const Color(0xFF26A69A),
                          chartBuilder: (period) => BarChartWidget(
                            tasks: data,
                            period: period,
                          ),
                        ),
                      ),
                      20.horizontalSpace,
                      Expanded(
                        child: StatCard(
                          title: 'In progress',
                          value: _getFilteredTaskCount(data, 'in_progress').toString(),
                          color: const Color(0xFFBA68C8),
                          chartBuilder: (period) => BarChartWidget(
                            tasks: data,
                            period: period,
                            isProgress: true,
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              }),
          30.verticalSpace,
          const Expanded(child: OrdersScreen()),
        ],
      ),
    );
  }

  int _getFilteredTaskCount(List<dynamic> tasks, String? status) {
    if (status == null) return tasks.length;

    if (status == 'completed') {
      return tasks.where((task) => task.status == 'completed').length;
    }

    if (status == 'in_progress') {
      return tasks.where((task) => task.status == 'pending' || task.status == 'active').length;
    }

    return 0;
  }
}
