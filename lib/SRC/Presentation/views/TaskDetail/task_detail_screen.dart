import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Domain/Models/task_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/SRC/Presentation/Common/custom_appbar.dart';
import 'package:reqwest/SRC/Presentation/Common/snackbar.dart';

class TaskDetailScreen extends StatefulWidget {
  const TaskDetailScreen({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;
  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  String status = 'pending';
  final commentController = TextEditingController();
  @override
  void initState() {
    status = widget.taskModel.status ?? 'pending';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppbar(
        title: 'Task Details',
        context: context,
        isTitleCentered: true,
        showUnderline: false,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(thickness: 10),
          12.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: 'Task Name: ',
                      style: theme.textTheme.titleSmall!.copyWith(
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: widget.taskModel.categoryModel?.name ?? '',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ]),
                ),
                8.verticalSpace,
                RichText(
                  text: TextSpan(
                      text: 'Description :',
                      style: theme.textTheme.titleSmall!.copyWith(
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(
                          text: widget.taskModel.description ?? '',
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ]),
                ),
                8.verticalSpace,
                Row(
                  children: [
                    AppText(
                      'Status :',
                      style: theme.textTheme.titleSmall!.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                            activeColor: theme.colorScheme.primary,
                            value: status == 'pending',
                            onChanged: (v) {
                              setState(() {
                                status = 'pending';
                              });
                            }),
                        AppText(
                          'In Progress',
                          style: theme.textTheme.titleSmall!.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        Checkbox(
                            activeColor: theme.colorScheme.primary,
                            value: status == 'completed',
                            onChanged: (v) {
                              setState(() {
                                status = 'completed';
                              });
                            }),
                        AppText(
                          'Delievered',
                          style: theme.textTheme.titleSmall!.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                8.verticalSpace,
                AppTextField(
                  controller: commentController,
                  labelText: 'Comment',
                ),
              ],
            ),
          ),
          20.verticalSpace,
          const Divider(thickness: 10),
          const Spacer(),
          CommonButton(
            horizontalMargin: 24,
            verticalMargin: 16,
            text: 'Update',
            onTap: () async {
              showLoading();
              await FirebaseFirestore.instance
                  .collection('tasks')
                  .doc(widget.taskModel.docId)
                  .update({
                'status': status,
                'comment': commentController.text,
              });
              dismiss();
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
