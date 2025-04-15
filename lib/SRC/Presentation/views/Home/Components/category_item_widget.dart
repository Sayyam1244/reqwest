import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Domain/Models/category_model.dart';
import 'package:reqwest/SRC/Presentation/Common/app_icon_handler.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/gen/assets.gen.dart';

class CategoryItemWidget extends StatelessWidget {
  CategoryItemWidget({
    required this.category,
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;
  CategoryModel category;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          DynamicAppIconHandler.buildIcon(
            context: context,
            svg: Assets.icons.sewage,
          ),
          6.verticalSpace,
          AppText(
            category.name,
            style: theme.textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
