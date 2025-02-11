import 'package:flutter/material.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';

import 'app_icon_handler.dart';

class CommonDialogs {
  static showCommonDialogue({
    required BuildContext context,
    IconData? icon,
    String? svgPath,
    double iconHeight = 96,
    double? iconWidth,
    EdgeInsetsGeometry iconMargins = EdgeInsets.zero,
    Color? iconColor,
    String? title,
    Color? titleTextColor,
    double titleTextSize = 20,
    FontWeight? titleFontWeight,
    String? description,
    Color? descriptionTextColor,
    double descriptionTextSize = 14,
    FontWeight? descriptionFontWeight,
    List<Widget>? actions,
    double radius = 26,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    EdgeInsetsGeometry? titlePadding,
    EdgeInsetsGeometry? descriptionPadding,
  }) async {
    return showDialog(
      context: context,
      barrierColor: Theme.of(context).colorScheme.tertiary.withOpacity(0),
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          insetPadding: const EdgeInsets.all(24),
          elevation: 20,
          shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          clipBehavior: Clip.hardEdge,
          backgroundColor: Colors.transparent,
          child: Container(
            padding: padding ?? const EdgeInsets.all(30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color:
                  backgroundColor ?? Theme.of(context).colorScheme.background,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: crossAxisAlignment,
              mainAxisAlignment: mainAxisAlignment,
              children: [
                DynamicAppIconHandler.buildIcon(
                  context: context,
                  icon: icon,
                  svg: svgPath,
                  iconHeight: iconHeight,
                  iconWidth: iconWidth,
                  margins: iconMargins,
                  iconColor: iconColor,
                ),
                if (title != null)
                  Padding(
                    padding: titlePadding ??
                        const EdgeInsets.only(top: 24, bottom: 14),
                    child: AppText(
                      title,
                      maxLine: 3,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: titleTextColor ??
                                Theme.of(context).colorScheme.primary,
                            fontWeight: titleFontWeight,
                            fontSize: titleTextSize,
                          ),
                    ),
                  ),
                if (description != null)
                  Padding(
                    padding: descriptionPadding ??
                        EdgeInsets.only(
                            bottom: (actions != null && actions.isNotEmpty)
                                ? 36
                                : 0),
                    child: AppText(
                      description,
                      maxLine: 10,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: descriptionTextColor,
                            fontWeight: descriptionFontWeight,
                            fontSize: descriptionTextSize,
                          ),
                    ),
                  ),
                if (actions != null && actions.isNotEmpty) ...actions
              ],
            ),
          ),
        );
      },
    );
  }

  static showCustomDialogue({
    required BuildContext context,
    double radius = 20,
    Color? backgroundColor,
    EdgeInsetsGeometry? padding,
    required Widget child,
    double elevation = 20,
    EdgeInsets? insetPadding,
  }) {
    showDialog(
      context: context,
      barrierColor: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
      builder: (ctx) {
        return Dialog(
          insetPadding: insetPadding ?? const EdgeInsets.all(24),
          elevation: elevation,
          shadowColor: Theme.of(context).colorScheme.tertiary,
          clipBehavior: Clip.hardEdge,
          backgroundColor: Colors.transparent,
          child: Container(
              padding: padding ?? const EdgeInsets.all(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color:
                    backgroundColor ?? Theme.of(context).colorScheme.background,
              ),
              child: child),
        );
      },
    );
  }

  static showLoadingDialogue({required BuildContext context}) {
    return showCustomDialogue(
      backgroundColor: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.zero,
      context: context,
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  static Future showSuccessDialogue({
    required BuildContext context,
    required String title,
    required String description,
    double titleFontSize = 22,
    double descriptionFontSize = 16,
    List<Widget>? actions,
  }) async {
    return await showCommonDialogue(
      context: context,
      icon: Icons.check_rounded,
      iconColor: Colors.green,

      // svgPath: Assets.icons.successIllustration,
      title: title,
      description: description,
      titleTextSize: titleFontSize,
      descriptionTextSize: descriptionFontSize,
      actions: actions,
    );
  }

  static showErrorDialogue({
    required BuildContext context,
    required String title,
    required String description,
    double titleFontSize = 22,
    double descriptionFontSize = 16,
    List<Widget>? actions,
  }) {
    return showCommonDialogue(
      context: context,
      icon: Icons.warning_rounded,
      iconColor: Theme.of(context).colorScheme.error,
      // svgPath: Assets.icons.warning,
      title: title,
      description: description,
      titleTextSize: titleFontSize,
      descriptionTextSize: descriptionFontSize,
      actions: actions,
    );
  }
}
