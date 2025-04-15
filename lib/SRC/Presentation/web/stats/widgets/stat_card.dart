import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum TimePeriod {
  last7Days('Last 7 days'),
  thisMonth('This month'),
  thisYear('This year');

  final String label;
  const TimePeriod(this.label);
}

class StatCard extends StatefulWidget {
  final String title;
  final String value;
  final Color color;
  final Widget Function(TimePeriod) chartBuilder;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.color,
    required this.chartBuilder,
  });

  @override
  State<StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<StatCard> {
  TimePeriod selectedPeriod = TimePeriod.last7Days;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
              const Spacer(),
              _buildDropdown(),
            ],
          ),
          10.verticalSpace,
          Text(
            widget.value,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: widget.color,
                  fontWeight: FontWeight.w500,
                ),
          ),
          20.verticalSpace,
          SizedBox(
            height: 150,
            child: widget.chartBuilder(selectedPeriod),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButton<TimePeriod>(
      value: selectedPeriod,
      underline: const SizedBox(),
      items: TimePeriod.values.map((period) {
        return DropdownMenuItem<TimePeriod>(
          value: period,
          child: Text(period.label, style: TextStyle(color: Colors.grey[600])),
        );
      }).toList(),
      onChanged: (TimePeriod? newValue) {
        if (newValue != null) {
          setState(() {
            selectedPeriod = newValue;
          });
        }
      },
    );
  }
}
