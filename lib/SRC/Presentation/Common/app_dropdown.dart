// ignore: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_text.dart';

class AppDropDownCustom extends StatefulWidget {
  final Widget? prefixIcon;
  final String hintText;
  dynamic value;
  final double vMargin;
  final FocusNode? focusNode;
  final double hMargin;
  final String? labelText;
  final double? dropDownHeight;
  final String validationText;
  final ValueChanged onChanged;
  final List<DropdownMenuItem<Object>> itemsMap;
  final bool isBorderRequired;
  final bool isShadowRequired;

  AppDropDownCustom({
    super.key,
    this.hMargin = 8,
    this.labelText,
    this.vMargin = 0,
    this.dropDownHeight,
    this.prefixIcon,
    required this.hintText,
    required this.value,
    required this.validationText,
    required this.onChanged,
    required this.itemsMap,
    this.isBorderRequired = true,
    this.isShadowRequired = false,
    this.focusNode,
    this.style,
    this.hintStyle,
  });

  final TextStyle? style;
  final TextStyle? hintStyle;

  @override
  State<AppDropDownCustom> createState() => _AppDropDownCustomState();
}

class _AppDropDownCustomState extends State<AppDropDownCustom> {
  final double borderRadius = 10;
  bool labelShow = false;

  @override
  void initState() {
    // TODO: implement initState
    widget.focusNode!.addListener(() {
      if (mounted) {
        if (widget.focusNode!.hasFocus) {
          labelShow = true;
          setState(() {});
        } else {
          //labelColor=AppColors.greyLightColor;
          labelShow = false;
          setState(() {});
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          //color: Colors.transparent,
          boxShadow: widget.isShadowRequired ? [] : []),
      padding: EdgeInsets.symmetric(
          vertical: widget.vMargin, horizontal: widget.hMargin),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField(
          // borderRadius: BorderRadius.circular(1),
          focusNode: widget.focusNode,
          //autovalidateMode: AutovalidateMode.onUserInteraction,
          menuMaxHeight: widget.dropDownHeight,
          validator: (value) {
            if (value == null) {
              return widget.validationText;
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: false,
            prefixIcon: widget.prefixIcon,
            errorMaxLines: 1,
            labelText: labelShow ? widget.labelText : "",
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 12,
            ),
            border: outlineInputBorder(),
            hintStyle: widget.hintStyle ??
                themeData.textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
          ),
          hint: Text(widget.hintText),

          dropdownColor: Colors.white,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: themeData.colorScheme.onBackground,
          ),
          iconSize: 28.r,
          isExpanded: true,
          style: widget.style ??
              themeData.textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.tertiary,
              ),
          value: widget.value,
          onChanged: widget.onChanged,
          items: widget.itemsMap,
        ),
      ),
    );
  }

  outlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius.r),
      borderSide: const BorderSide(color: Colors.transparent),
    );
  }
}

class AppDropDownSimple extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final String? validatorText;
  final ValueChanged<String> onChanged;
  final double width;
  final double height;
  final bool? isBorder;
  final EdgeInsets? padding;
  final bool? isFit;
  final TextStyle? style;
  final Widget? icon;
  final String? Function(String?)? validator;
  final String? hint;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Color? borderColor;
  final bool ignoring;

  const AppDropDownSimple(
      {this.borderColor,
      super.key,
      this.ignoring = false,
      this.prefixIcon,
      this.hintStyle,
      required this.items,
      required this.selectedValue,
      required this.onChanged,
      this.width = 20,
      this.height = 20,
      this.padding,
      this.isBorder,
      this.isFit,
      this.validatorText,
      this.validator,
      this.style,
      this.icon,
      this.hint});

//   @override
//   State<AppDropDownSimple> createState() => _AppDropDownSimpleState();
// }

// class _AppDropDownSimpleState extends State<AppDropDownSimple> {
//   String? _selectedValue;

//   @override
//   void initState() {
//     super.initState();
//     _selectedValue = widget.selectedValue;
//   }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return SizedBox(
      child: Column(
        children: [
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
            child: IgnorePointer(
              ignoring: ignoring,
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: borderColor != null
                      ? themeData.inputDecorationTheme.border!
                          .copyWith(borderSide: BorderSide(color: borderColor!))
                      : null,
                  enabledBorder: borderColor != null
                      ? themeData.inputDecorationTheme.border!
                          .copyWith(borderSide: BorderSide(color: borderColor!))
                      : null,
                  focusedBorder: borderColor != null
                      ? themeData.inputDecorationTheme.border!
                          .copyWith(borderSide: BorderSide(color: borderColor!))
                      : null,
                  disabledBorder: borderColor != null
                      ? themeData.inputDecorationTheme.border!
                          .copyWith(borderSide: BorderSide(color: borderColor!))
                      : null,
                  filled: true,
                  hintText: hint ?? "",
                  prefixIcon: prefixIcon,
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  hintStyle: hintStyle ??
                      themeData.textTheme.bodyMedium!.copyWith(
                        fontSize: 13,
                        color:
                            themeData.colorScheme.onBackground.withOpacity(0.5),
                      ),
                ),
                value: selectedValue,
                dropdownColor: themeData.colorScheme.surface,
                isExpanded: true,
                validator: validator,
                elevation: 0,
                icon: icon,
                // icon: ,
                autofocus: false,
                padding: padding,
                onChanged: (value) {
                  // setState(() {
                  // _selectedValue = value!;
                  onChanged(value!);
                  // });
                },

                items: items.map((item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: isFit != null
                        ? AppText(item,
                            style: style ?? themeData.textTheme.bodyMedium)
                        : FittedBox(
                            child: AppText(
                            item,
                            style: themeData.textTheme.bodyMedium,
                          )),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
