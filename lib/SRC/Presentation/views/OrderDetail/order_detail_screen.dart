import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Presentation/Common/app_icon_handler.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/asset_image_widget.dart';
import 'package:reqwest/SRC/Presentation/Common/custom_appbar.dart';
import 'package:reqwest/gen/assets.gen.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, this.isFirstTime = true});
  final bool isFirstTime;
  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppbar(
        title: 'Order Details',
        context: context,
        isTitleCentered: true,
        showUnderline: false,
      ),
      body: Column(
        children: [
          const Divider(thickness: 10),
          12.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Column(
                  children: [
                    AppText(
                      'Order ID',
                      style: theme.textTheme.titleSmall!.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    8.verticalSpace,
                    AppText(
                      '# 54ez67b39',
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.onBackground.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                DynamicAppIconHandler.buildIcon(
                  context: context,
                  icon: Icons.copy,
                ),
              ],
            ),
          ),
          if (!widget.isFirstTime)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  40.verticalSpace,
                  AppText(
                    'Task Description',
                    style: theme.textTheme.titleSmall!.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  8.verticalSpace,
                  AppText(
                    maxLine: 100,
                    'The toilet is not flushing properly. The toilet is not flushing properly. It has been clogged for two days',
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          32.verticalSpace,
          if (widget.isFirstTime) const Divider(thickness: 30),
          if (widget.isFirstTime)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  100.verticalSpace,
                  DynamicAppIconHandler.buildIcon(
                    context: context,
                    icon: Icons.task_alt,
                    iconColor: theme.colorScheme.primary,
                    iconHeight: 54,
                  ),
                  12.verticalSpace,
                  AppText(
                    'Thanks for book a service',
                    style: theme.textTheme.bodyLarge,
                  ),
                  4.verticalSpace,
                  AppText(
                    maxLine: 2,
                    'Your service request has been submitted successfully.',
                    style: theme.textTheme.bodyMedium,
                  ),
                  100.verticalSpace,
                ],
              ),
            ),
          Divider(thickness: widget.isFirstTime ? 30 : 20),
          32.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: AssetImageWidget(
                    height: 44,
                    width: 44,
                    fit: BoxFit.cover,
                    url: Assets.images.chef.path,
                  ),
                ),
                8.horizontalSpace,
                Column(
                  children: [
                    AppText(
                      'Adam ',
                      style: theme.textTheme.titleSmall!.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    4.verticalSpace,
                    AppText(
                      'Plumber',
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.onBackground.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                DynamicAppIconHandler.buildIcon(
                  context: context,
                  icon: Icons.phone,
                  iconColor: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
