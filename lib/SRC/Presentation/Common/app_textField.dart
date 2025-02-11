import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final Color? filledColor;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool isValid;
  final bool isBorderRequired;
  final String? titleText;
  final int? maxline;
  final TextStyle? hintStyle;
  final TextStyle? titleStyle;
  final String? validateText;
  final bool? isShadowRequired;
  final Color? titleTextColor;
  final double? suffixWidth;
  final double? suffixHeight;
  final ValueChanged? onChanged;
  final GestureTapCallback? onTap;
  final bool? readOnly;
  final FocusNode? focusNode;
  final Color? hintTextColor;
  final double? height;
  final bool? isState;
  final String? labelText;
  final double? prefixWidth;
  final EdgeInsets? contentPadding;
  final Color? borderColor;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    this.inputFormatters,
    this.borderColor,
    super.key,
    this.controller,
    this.hintText,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.suffixIcon,
    this.validator,
    this.prefixIcon,
    this.isValid = false,
    this.isBorderRequired = true,
    this.titleText = "",
    this.maxline = 1,
    this.labelText,
    this.validateText,
    this.isShadowRequired = false,
    this.titleTextColor,
    this.suffixWidth = 15,
    this.suffixHeight = 15,
    this.onChanged,
    this.contentPadding,
    this.onTap,
    this.readOnly,
    this.focusNode,
    this.hintTextColor,
    this.borderRadius,
    this.height,
    this.filledColor,
    this.hintStyle,
    this.isState,
    this.titleStyle,
    this.prefixWidth,
    this.enabled,
    this.style,
  });

  final double? borderRadius;
  final bool? enabled;
  final TextStyle? style;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

bool isHide = false;

class _AppTextFieldState extends State<AppTextField> {
  FocusNode? focusNode;
  // String? Function(String?)? validator;

  @override
  void initState() {
    focusNode = widget.focusNode ?? FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // if (widget.labelText != null)
          //   AppText(
          //     widget.labelText!,
          //     style: themeData.textTheme.bodyMedium!
          //         .copyWith(color: themeData.colorScheme.primary),
          //   ),
          // if (widget.labelText != null) 10.verticalSpace,
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: themeData.colorScheme.secondary.withOpacity(0.18),
                  offset: const Offset(0, 4),
                  blurRadius: 62,
                )
              ],
            ),
            child: TextFormField(
              inputFormatters: widget.inputFormatters,
              onTap: widget.onTap,
              readOnly: widget.readOnly ?? false,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              scribbleEnabled: true,
              focusNode: focusNode,
              enabled: widget.enabled,
              onTapOutside: (v) {
                // focusNode?.unfocus();
              },
              textInputAction: TextInputAction.done,
              validator: widget.validator,
              onChanged: widget.onChanged,
              keyboardType: widget.textInputType,
              obscureText:
                  widget.isState != null ? !isHide : widget.obscureText,
              controller: widget.controller,
              maxLines: widget.maxline,
              style: widget.style ?? themeData.textTheme.bodyMedium!,
              cursorColor: themeData.colorScheme.primary,
              decoration: InputDecoration(
                labelText: widget.labelText,

                hintText: widget.hintText,
                hintStyle: widget.hintStyle ??
                    themeData.textTheme.bodyMedium!.copyWith(
                      fontSize: 13,
                      color:
                          themeData.colorScheme.onBackground.withOpacity(0.5),
                    ),
                prefixIcon: widget.prefixIcon,

                suffixIcon: widget.suffixIcon,

                isDense: false,
                fillColor: widget.filledColor,
                // labelText: widget.labelText,
                labelStyle: themeData.textTheme.bodyLarge!.copyWith(
                  color: themeData.colorScheme.secondary,
                ),
                floatingLabelStyle: themeData.textTheme.bodyMedium!.copyWith(
                  color: themeData.colorScheme.primary,
                ),
                // labelStyle: themeData.textTheme.labelMedium,
                alignLabelWithHint: true,
                border: widget.borderColor != null
                    ? themeData.inputDecorationTheme.border!.copyWith(
                        borderSide: BorderSide(color: widget.borderColor!))
                    : null,
                enabledBorder: widget.borderColor != null
                    ? themeData.inputDecorationTheme.border!.copyWith(
                        borderSide: BorderSide(color: widget.borderColor!))
                    : null,
                focusedBorder: widget.borderColor != null
                    ? themeData.inputDecorationTheme.border!.copyWith(
                        borderSide: BorderSide(color: widget.borderColor!))
                    : null,
                disabledBorder: widget.borderColor != null
                    ? themeData.inputDecorationTheme.border!.copyWith(
                        borderSide: BorderSide(color: widget.borderColor!))
                    : null,

                ///changess
                contentPadding: widget.contentPadding ??
                    const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 12,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
