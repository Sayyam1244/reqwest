import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Domain/Models/task_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/asset_image_widget.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/gen/assets.gen.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
    required this.taskModel,
  });
  final TaskModel taskModel;
  @override
  Widget build(BuildContext context) {
    log(taskModel.toJson().toString());
    final theme = Theme.of(context);
    return Container(
      width: 260,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onSurface.withOpacity(0.05),
              blurRadius: 15.0,
              spreadRadius: 0.0,
              offset: const Offset(1.0, 1.0),
            ),
          ]),
      child: Column(
        children: [
          // AssetImageWidget(
          //   height: 120,
          //   width: double.infinity,
          //   fit: BoxFit.cover,
          //   url: ,
          // ),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
            ),
            child: const Center(
              child: Icon(
                Icons.miscellaneous_services_rounded,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          12.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  taskModel.categoryModel?.name ?? '',
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                  ),
                ),
                CommonButton(
                  height: 28,
                  width: 80,
                  text: (taskModel.status ?? '')
                          .characters
                          .first
                          .toUpperCase() +
                      (taskModel.status ?? '').substring(1).replaceAll("_", ""),
                  textSize: 10,
                  backgroundColor: theme.colorScheme.secondary,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
