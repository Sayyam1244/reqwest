import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reqwest/SRC/Domain/Models/task_model.dart';
import 'package:reqwest/SRC/Presentation/web/stats/widgets/stat_card.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({
    super.key,
    required this.tasks,
    required this.period,
  });

  final List<TaskModel> tasks;
  final TimePeriod period;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
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
        lineBarsData: [
          LineChartBarData(
            spots: spots(),
            isCurved: true,
            color: Colors.green,
            barWidth: 2,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.green.withOpacity(0.1),
            ),
          ),
        ],
      ),
    );
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

  List<FlSpot> spots() {
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
        numberOfPoints = ((now.difference(DateTime(now.year, 1, 1)).inDays) + 1);
        break;
    }

    // Initialize counts for all days
    for (int i = 0; i < numberOfPoints; i++) {
      final date = startDate.add(Duration(days: i));
      taskCountByDate[DateTime(date.year, date.month, date.day)] = 0;
    }

    // Count tasks for each date
    for (final task in tasks) {
      if (task.createdDate != null) {
        final taskDate = DateTime(
          task.createdDate!.year,
          task.createdDate!.month,
          task.createdDate!.day,
        );

        if (taskDate.isAfter(startDate.subtract(const Duration(days: 1))) &&
            taskDate.isBefore(now.add(const Duration(days: 1)))) {
          taskCountByDate[taskDate] = (taskCountByDate[taskDate] ?? 0) + 1;
        }
      }
    }

    // Convert to list of spots
    final spots = taskCountByDate.entries.map((entry) {
      final daysFromStart = entry.key.difference(startDate).inDays;
      return FlSpot(daysFromStart.toDouble(), entry.value.toDouble());
    }).toList();

    // Sort spots by x value (days)
    spots.sort((a, b) => a.x.compareTo(b.x));

    return spots;
  }
}
