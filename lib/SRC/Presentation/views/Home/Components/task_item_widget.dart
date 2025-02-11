import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/asset_image_widget.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/gen/assets.gen.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 260,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.colorScheme.background,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.onBackground.withOpacity(0.05),
              blurRadius: 15.0,
              spreadRadius: 0.0,
              offset: const Offset(1.0, 1.0),
            ),
          ]),
      child: Column(
        children: [
          AssetImageWidget(
            height: 120,
            width: double.infinity,
            fit: BoxFit.cover,
            url: Assets.images.technician.path,
          ),
          12.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  'Electrical',
                  style: theme.textTheme.titleSmall!.copyWith(
                    fontSize: 16,
                  ),
                ),
                CommonButton(
                  height: 28,
                  width: 80,
                  text: 'In-Progess',
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
