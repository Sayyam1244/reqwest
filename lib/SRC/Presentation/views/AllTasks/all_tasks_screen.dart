import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/custom_appbar.dart';
import 'package:reqwest/SRC/Presentation/views/AllTasks/Components/task_status_toggle.dart';
import 'package:reqwest/SRC/Presentation/views/OrderDetail/order_detail_screen.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppbar(
        title: 'All Tasks',
        context: context,
        isTitleCentered: true,
        showUnderline: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          TaskStatusToggleButton(
            onStatusChanged: (bool isCompleted) {
              print(isCompleted);
            },
          ),
          12.verticalSpace,
          ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 10),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => ListTile(
                    onTap: () {
                      context.to(const OrderDetailScreen(
                        isFirstTime: false,
                      ));
                    },
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      height: 40.w,
                      width: 40.w,
                      decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          shape: BoxShape.circle),
                      child: Center(
                        child: AppText(
                          'T',
                          style: theme.textTheme.titleSmall!.copyWith(
                            color: theme.colorScheme.background,
                          ),
                        ),
                      ),
                    ),
                    title: AppText(
                      'Order ID# 00215',
                      style: theme.textTheme.titleSmall!.copyWith(fontSize: 16),
                    ),
                    subtitle: AppText(
                      maxLine: 2,
                      'Hey, Anna, Thank you for reaching out to me...',
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.onBackground.withOpacity(0.6),
                      ),
                    ),
                    trailing: AppText(
                      'Jun 25',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 12)

          //
        ],
      ),
    );
  }
}
