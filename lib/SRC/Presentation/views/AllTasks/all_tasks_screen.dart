import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_quick_router/Routers/quick_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:reqwest/SRC/Application/Services/FirestoreServices/task_service.dart';
import 'package:reqwest/SRC/Domain/Models/task_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/custom_appbar.dart';
import 'package:reqwest/SRC/Presentation/views/AllTasks/Components/task_status_toggle.dart';
import 'package:reqwest/SRC/Presentation/views/OrderDetail/order_detail_screen.dart';
import 'package:reqwest/SRC/Presentation/views/TaskDetail/task_detail_screen.dart';
import 'package:reqwest/main.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  bool isCompletedTasks = false;
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
      body: StreamBuilder(
        stream: TaskService.instance.getTasksForCurrentUserStaff(
            FirebaseAuth.instance.currentUser!.uid),
        builder:
            (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error Fetching Tasks'));
          }
          final tasks = snapshot.data as List<TaskModel>;
          if (tasks.isEmpty) {
            return const Center(child: Text('No Tasks Found'));
          }
          final rawList = snapshot.data ?? [];
          List<TaskModel> completedList = [];
          List<TaskModel> allExecptCompleted = [];
          for (var i = 0; i < rawList.length; i++) {
            if (rawList[i].status == 'completed') {
              completedList.add(rawList[i]);
            } else {
              allExecptCompleted.add(rawList[i]);
            }
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              TaskStatusToggleButton(
                onStatusChanged: (bool isCompleted) {
                  setState(() {
                    isCompletedTasks = !isCompletedTasks;
                  });
                },
                value: isCompletedTasks,
              ),

              12.verticalSpace,
              ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = isCompletedTasks
                        ? completedList[index]
                        : allExecptCompleted[index];
                    return ListTile(
                      onTap: () {
                        context.to(isStaffFlow
                            ? TaskDetailScreen(
                                taskModel: item,
                              )
                            : OrderDetailScreen(
                                isFirstTime: false,
                                taskModel: item,
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
                            item.docId?.characters.firstOrNull ?? '',
                            style: theme.textTheme.titleSmall!.copyWith(
                              color: theme.colorScheme.surface,
                            ),
                          ),
                        ),
                      ),
                      title: AppText(
                        '${item.docId}',
                        style:
                            theme.textTheme.titleSmall!.copyWith(fontSize: 14),
                      ),
                      subtitle: AppText(
                        maxLine: 2,
                        item.description ?? '',
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      trailing: AppText(
                        DateFormat('MMMM dd').format(item.createdDate!),
                        style: theme.textTheme.bodySmall,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: isCompletedTasks
                      ? completedList.length
                      : allExecptCompleted.length),

              //
            ],
          );
        },
      ),
    );
  }
}
