import 'package:flutter/material.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';

class TaskStatusToggleButton extends StatefulWidget {
  const TaskStatusToggleButton({super.key, required this.onStatusChanged});
  final Function(bool) onStatusChanged;
  @override
  State<TaskStatusToggleButton> createState() => _TaskStatusToggleButtonState();
}

class _TaskStatusToggleButtonState extends State<TaskStatusToggleButton> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 50,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.outline,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isCompleted ? theme.colorScheme.primary : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isCompleted = true;
                  });
                  widget.onStatusChanged(isCompleted);
                },
                child: Center(
                  child: AppText(
                    'Completed',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: isCompleted
                          ? theme.colorScheme.background
                          : theme.colorScheme.onBackground,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isCompleted ? null : theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isCompleted = false;
                  });
                  widget.onStatusChanged(isCompleted);
                },
                child: Center(
                  child: AppText(
                    'In-Progress',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: isCompleted
                          ? theme.colorScheme.onBackground
                          : theme.colorScheme.background,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
