import 'dart:math' show max;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reqwest/SRC/Domain/Models/task_model.dart';
import 'package:reqwest/SRC/Presentation/web/stats/widgets/stat_card.dart';

class BarChartWidget extends StatelessWidget {
  final bool isProgress;
  final List<TaskModel> tasks;
  final TimePeriod period;

  const BarChartWidget({
    super.key,
    this.isProgress = false,
    required this.tasks,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    final color = isProgress ? const Color(0xFFBA68C8) : const Color(0xFF26A69A);

    return BarChart(
      BarChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) => _getBottomTitles(value),
              interval: _getInterval(),
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: _createBarGroups(color),
        alignment: BarChartAlignment.spaceAround,
        maxY: _getMaxY(),
      ),
    );
  }

  double _getMaxY() {
    final groups = _createBarGroups(Colors.transparent);
    if (groups.isEmpty) return 10;
    return groups.map((g) => g.barRods.first.toY).reduce(max) * 1.2;
  }

  double _getInterval() {
    switch (period) {
      case TimePeriod.last7Days:
        return 1;
      case TimePeriod.thisMonth:
        return 7; // Show weekly intervals
      case TimePeriod.thisYear:
        return 30; // Show monthly intervals
    }
  }

  Widget _getBottomTitles(double value) {
    final DateTime now = DateTime.now();
    DateTime date;
    String text;

    switch (period) {
      case TimePeriod.last7Days:
        date = now.subtract(const Duration(days: 7)).add(Duration(days: value.toInt()));
        text = DateFormat('dd').format(date);
        break;
      case TimePeriod.thisMonth:
        date = DateTime(now.year, now.month, value.toInt() + 1);
        // Show week numbers (W1, W2, etc.)
        text = 'W${((value + 1) / 7).ceil()}';
        break;
      case TimePeriod.thisYear:
        date = DateTime(now.year, value.toInt() + 1);
        text = DateFormat('MMM').format(date);
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }

  List<BarChartGroupData> _createBarGroups(Color color) {
    final Map<DateTime, int> taskCountByDate = {};
    final DateTime now = DateTime.now();
    DateTime startDate;
    int numberOfPoints;

    // Determine the start date and number of points based on period
    switch (period) {
      case TimePeriod.last7Days:
        startDate = now.subtract(const Duration(days: 7));
        numberOfPoints = 7;
        break;
      case TimePeriod.thisMonth:
        startDate = DateTime(now.year, now.month, 1);
        numberOfPoints = now.day;
        break;
      case TimePeriod.thisYear:
        startDate = DateTime(now.year, 1, 1);
        numberOfPoints = 12; // Use months instead of days for year view
        break;
    }

    // Initialize counts
    if (period == TimePeriod.thisYear) {
      // Initialize monthly counts for year view
      for (int month = 1; month <= 12; month++) {
        taskCountByDate[DateTime(now.year, month)] = 0;
      }
    } else {
      // Initialize daily counts for week and month views
      for (int i = 0; i < numberOfPoints; i++) {
        final date = startDate.add(Duration(days: i));
        taskCountByDate[DateTime(date.year, date.month, date.day)] = 0;
      }
    }

    // Count tasks
    for (final task in tasks) {
      if (task.createdDate != null) {
        final taskDate = period == TimePeriod.thisYear
            ? DateTime(task.createdDate!.year, task.createdDate!.month)
            : DateTime(
                task.createdDate!.year,
                task.createdDate!.month,
                task.createdDate!.day,
              );

        if (taskDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
            taskDate.isBefore(now.add(const Duration(days: 1)))) {
          if (isProgress) {
            if (task.status == 'pending' || task.status == 'active') {
              taskCountByDate[taskDate] = (taskCountByDate[taskDate] ?? 0) + 1;
            }
          } else {
            if (task.status == 'completed') {
              taskCountByDate[taskDate] = (taskCountByDate[taskDate] ?? 0) + 1;
            }
          }
        }
      }
    }

    // Convert to bar groups
    return taskCountByDate.entries.map((entry) {
      final x = period == TimePeriod.thisYear
          ? entry.key.month - 1 // Use month number (0-11) for year view
          : entry.key.difference(startDate).inDays.toDouble();

      return BarChartGroupData(
        x: x.toInt(),
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: color,
            width: period == TimePeriod.thisYear ? 15 : 20,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    }).toList()
      ..sort((a, b) => a.x.compareTo(b.x));
  }
}
