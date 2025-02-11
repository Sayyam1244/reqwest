import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Presentation/Common/app_icon_handler.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';
import 'package:reqwest/gen/assets.gen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (mediaQuery.padding.top + 30).verticalSpace,
            AppText(
              'Search',
              style: theme.textTheme.titleMedium,
            ),
            16.verticalSpace,
            AppTextField(
              hintText: 'Search for a service',
              prefixIcon: DynamicAppIconHandler.buildIcon(
                context: context,
                svg: Assets.icons.search,
                iconColor: theme.colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
