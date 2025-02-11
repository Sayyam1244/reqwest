import 'package:flutter/material.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';
import 'app_icon_handler.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    this.onTap,
    this.text = '',
    this.backgroundColor,
    this.textColor,
    this.horizontalPadding = 8,
    this.verticalPadding = 8,
    this.horizontalMargin = 0,
    this.verticalMargin = 0,
    this.borderColor,
    this.textFontWeight = FontWeight.w400,
    this.textSize = 15,
    this.borderThickness = 1,
    this.width,
    this.height = 56,
    this.borderRadius = 6,
    this.boxShape = BoxShape.rectangle,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.leadingIcon,
    this.leadingSvg,
    this.leadingIconHeight,
    this.leadingIconWidth,
    this.leadingIconMargins = EdgeInsets.zero,
    this.trailingIcon,
    this.trailingSvg,
    this.trailingIconHeight,
    this.trailingIconWidth,
    this.trailingIconMargins = EdgeInsets.zero,
    this.leadingColor,
    this.trailingColor,
    this.centerIcon,
    this.centerIconColor,
    this.centerIconSize,
    this.centerSvg,
  });

  final VoidCallback? onTap;
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final double horizontalPadding;
  final double verticalPadding;
  final double horizontalMargin;
  final double verticalMargin;
  final Color? borderColor;
  final FontWeight textFontWeight;
  final double textSize;
  final double borderThickness;
  final double? width;
  final double height;
  final double borderRadius;
  final BoxShape boxShape;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final IconData? leadingIcon;
  final String? leadingSvg;
  final double? leadingIconHeight;
  final double? leadingIconWidth;
  final EdgeInsetsGeometry leadingIconMargins;
  final IconData? trailingIcon;
  final String? trailingSvg;
  final double? trailingIconHeight;
  final double? trailingIconWidth;
  final EdgeInsetsGeometry trailingIconMargins;
  final Color? leadingColor;
  final Color? trailingColor;
  final IconData? centerIcon;
  final String? centerSvg;
  final Color? centerIconColor;
  final double? centerIconSize;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Container(
      height: height,
      width: width,
      margin: EdgeInsets.symmetric(
        horizontal: horizontalMargin,
        vertical: verticalMargin,
      ),
      decoration: BoxDecoration(
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
                width: borderThickness,
              )
            : null,
        shape: boxShape,
        borderRadius: boxShape == BoxShape.circle
            ? null
            : BorderRadius.circular(borderRadius),
        color: backgroundColor ?? themeData.colorScheme.primary,
      ),
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        onPressed: onTap,
        padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
        child: Row(
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            DynamicAppIconHandler.buildIcon(
                context: context,
                icon: leadingIcon,
                svg: leadingSvg,
                iconHeight: leadingIconHeight,
                iconWidth: leadingIconWidth,
                margins: leadingIconMargins,
                iconColor: leadingColor
                // ??
                // (Theme.of(context).brightness == Brightness.light
                //     ? Theme.of(context).colorScheme.background
                //     : Theme.of(context).colorScheme.onBackground),
                ),
            (centerIcon != null || centerSvg != null)
                ? DynamicAppIconHandler.buildIcon(
                    context: context,
                    icon: centerIcon,
                    svg: centerSvg,
                    iconHeight: centerIconSize,
                    iconWidth: centerIconSize,
                    iconColor: centerIconColor ??
                        Theme.of(context).colorScheme.onBackground)
                : AppText(
                    text,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: (textColor == null &&
                                  Theme.of(context).brightness ==
                                      Brightness.dark)
                              ? Theme.of(context).colorScheme.onBackground
                              : textColor ??
                                  Theme.of(context).colorScheme.background,
                          fontWeight: textFontWeight,
                          fontSize: textSize,
                        ),
                  ),
            DynamicAppIconHandler.buildIcon(
                context: context,
                icon: trailingIcon,
                svg: trailingSvg,
                iconHeight: trailingIconHeight,
                iconWidth: trailingIconWidth,
                margins: trailingIconMargins,
                iconColor: trailingColor
                // ??
                // (Theme.of(context).brightness == Brightness.light
                //     ? Theme.of(context).colorScheme.background
                //     : Theme.of(context).colorScheme.onBackground),
                ),
          ],
        ),
      ),
    );
  }
}
