import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Presentation/Common/app_icon_handler.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/gen/assets.gen.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        DynamicAppIconHandler.buildIcon(
          context: context,
          svg: Assets.icons.sewage,
        ),
        6.verticalSpace,
        AppText(
          'Electrical',
          style: theme.textTheme.bodyMedium,
        )
      ],
    );
  }
}
