import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/asset_image_widget.dart';
import 'package:reqwest/SRC/Presentation/Common/common_button.dart';
import 'package:reqwest/gen/assets.gen.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 160.h,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          24.horizontalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                10.verticalSpace,
                Row(
                  children: [
                    AppText(
                      '20% ',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: theme.colorScheme.background,
                      ),
                    ),
                    AppText(
                      'off',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.background,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                CommonButton(
                  height: 40.h,
                  width: 100.w,
                  text: 'Book now',
                  textColor: theme.colorScheme.primary,
                  backgroundColor: theme.colorScheme.background,
                ),
                10.verticalSpace,
              ],
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: AssetImageWidget(
              url: Assets.images.plumber.path,
              height: 140.h,
              // width: 160.w,
            ),
          ),
        ],
      ),
    );
  }
}
