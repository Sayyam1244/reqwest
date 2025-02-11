import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';

AppBar customAppbar({
  required String title,
  required BuildContext context,
  List<Widget>? actions,
  Widget? leading,
  bool showUnderline = true,
  bool isTitleCentered = false,
}) {
  final theme = Theme.of(context);

  return AppBar(
    bottom: showUnderline == true
        ? const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(),
          )
        : null,
    leading: leading,
    centerTitle: isTitleCentered,
    titleSpacing: 0,
    title: AppText(
      title,
      style: theme.textTheme.bodyLarge!
          .copyWith(color: theme.colorScheme.onBackground),
    ),
    actions: actions,
  );
}
