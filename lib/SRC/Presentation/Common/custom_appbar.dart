import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';

AppBar customAppbar({
  required String title,
  required BuildContext context,
  List<Widget>? actions,
  Widget? leading,
}) {
  final theme = Theme.of(context);

  return AppBar(
    bottom: const PreferredSize(
      preferredSize: Size.fromHeight(1),
      child: Divider(),
    ),
    leading: leading,
    centerTitle: false,
    titleSpacing: 0,
    title: AppText(
      title,
      style: theme.textTheme.bodyLarge!.copyWith(
        color: theme.colorScheme.onBackground.withOpacity(0.6),
      ),
    ),
    actions: actions,
  );
}
