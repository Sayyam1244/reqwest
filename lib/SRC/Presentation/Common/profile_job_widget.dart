import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Domain/Models/job_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/asset_image_widget.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';

class ProfileJobWidget extends StatelessWidget {
  const ProfileJobWidget({
    super.key,
    this.buttonColor = Colors.green,
    this.buttonText = 'Completed',
    required this.jobModel,
  });
  final String buttonText;
  final JobModel jobModel;
  final Color buttonColor;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 100,
      width: 260,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 76,
            width: 76,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: theme.colorScheme.onBackground.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: AssetImageWidget(
              url: jobModel.jobImage,
              fit: BoxFit.cover,
            ),
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  maxLine: 2,
                  jobModel.title ?? '',
                  style: theme.textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                CommonButton(
                  height: 30,
                  width: 90,
                  backgroundColor: buttonColor,
                  text: buttonText,
                  textSize: 10,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
