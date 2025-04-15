import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Domain/Models/task_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_icon_handler.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/asset_image_widget.dart';
import 'package:reqwest/SRC/Presentation/Common/custom_appbar.dart';
import 'package:reqwest/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({
    super.key,
    required this.taskModel,
    this.isFirstTime = false,
  });
  final TaskModel taskModel;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(thickness: 10),
          12.verticalSpace,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      'Order ID',
                      style: theme.textTheme.titleSmall!.copyWith(
                        fontSize: 16,
                      ),
                    ),
                    8.verticalSpace,
                    AppText(
                      '# ${widget.taskModel.docId}',
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
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
                  widget.taskModel.description ?? '',
                  style: theme.textTheme.bodySmall!.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          32.verticalSpace,
          const Divider(thickness: 30),
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
          if (widget.taskModel.assignTo != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: theme.colorScheme.primary.withOpacity(0.1),
                      ),
                      child: DynamicAppIconHandler.buildIcon(
                        context: context,
                        svg: Assets.icons.profile,
                        iconColor: theme.colorScheme.primary,
                        iconHeight: 40,
                        iconWidth: 40,
                      )),
                  8.horizontalSpace,
                  Column(
                    children: [
                      AppText(
                        '${widget.taskModel.assignToUser?.firstName} ${widget.taskModel.assignToUser?.lastName}',
                        style: theme.textTheme.titleSmall!.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      4.verticalSpace,
                      AppText(
                        '${widget.taskModel.assignToUser?.categoryModel?.name}',
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  DynamicAppIconHandler.buildIcon(
                    onTap: () async {
                      await launchUrl(Uri.parse(
                          'tel:${widget.taskModel.assignToUser?.phoneNumber}'));
                    },
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
