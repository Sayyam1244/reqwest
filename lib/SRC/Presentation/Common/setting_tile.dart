import 'package:flutter/material.dart';
import 'package:reqwest/SRC/Application/Utils/Extensions/extensions.dart';
import 'package:reqwest/SRC/Presentation/Common/app_icon_handler.dart';
import 'package:reqwest/SRC/Presentation/Common/app_textField.dart';

class SettingTile extends StatelessWidget {
  SettingTile({
    super.key,
    required this.text,
    this.ontap,
  });
  final String text;
  VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppTextField(
      controller: TextEditingController(
        text: text,
      ),
      suffixIcon: DynamicAppIconHandler.buildIcon(
        context: context,
        icon: Icons.keyboard_arrow_right_rounded,
        iconColor: theme.colorScheme.onBackground.withOpacity(0.7),
      ),
      textInputType: TextInputType.text,
      enabled: false,
    ).padHorizontal(24).onTapped(onTap: ontap ?? () {});
  }
}
