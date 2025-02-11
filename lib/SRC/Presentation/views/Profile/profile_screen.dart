import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Presentation/Common/app_icon_handler.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'package:reqwest/SRC/Presentation/Common/custom_appbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: customAppbar(
        title: 'Profile',
        context: context,
        isTitleCentered: true,
        showUnderline: false,
        actions: [
          TextButton(
            onPressed: () {},
            child: AppText(
              'Logout',
              style: theme.textTheme.bodyMedium!.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            20.verticalSpace,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: theme.colorScheme.outline,
                  width: 1,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Saif Uddin',
                          style: theme.textTheme.titleSmall,
                        ),
                        6.verticalSpace,
                        AppText(
                          'Banasree, USa',
                          style: theme.textTheme.bodySmall!.copyWith(
                            color:
                                theme.colorScheme.onBackground.withOpacity(0.6),
                          ),
                        )
                      ],
                    ),
                  ),
                  AppText('Edit', style: theme.textTheme.bodyMedium)
                ],
              ),
            ),
            32.verticalSpace,
            ProfileTile(
              title: 'Orders History',
              icon: Icons.bookmark_outline_outlined,
              onTap: () {},
            ),
            32.verticalSpace,
            ProfileTile(
              title: 'Privacy Policy',
              icon: Icons.privacy_tip_outlined,
              onTap: () {},
            )
          ],
        ),
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.outline,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: theme.colorScheme.outline,
              ),
              child: DynamicAppIconHandler.buildIcon(
                context: context,
                icon: icon,
                iconColor: theme.colorScheme.onBackground,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: AppText(
                title,
                style: theme.textTheme.titleSmall!.copyWith(fontSize: 16),
              ),
            ),
            6.verticalSpace,
            DynamicAppIconHandler.buildIcon(
              context: context,
              icon: Icons.arrow_forward_ios_rounded,
              iconHeight: 16,
            ),
          ],
        ),
      ),
    );
  }
}
