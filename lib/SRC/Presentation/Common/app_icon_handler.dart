import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DynamicAppIconHandler {
  static Widget buildIcon({
    required BuildContext context,
    IconData? icon,
    String? svg,
    double? iconHeight,
    double? iconWidth,
    EdgeInsetsGeometry margins = EdgeInsets.zero,
    Color? iconColor,
    BoxFit fit = BoxFit.scaleDown,
    void Function()? onTap,
  }) {
    if (svg != null) {
      return Padding(
        padding: margins,
        child: InkWell(
          onTap: onTap,
          child: SvgPicture.asset(
            svg,
            height: iconHeight,
            width: iconWidth,
            fit: fit,
            color: iconColor,
          ),
        ),
      );
    } else if (icon != null) {
      return Padding(
        padding: margins,
        child: InkWell(
          onTap: onTap,
          child: Icon(
            icon,
            color: iconColor ?? Theme.of(context).colorScheme.secondary,
            size: iconHeight,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
