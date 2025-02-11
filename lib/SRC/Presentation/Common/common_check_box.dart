import 'package:flutter/material.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';

class CommonCheckBox extends StatelessWidget {
  const CommonCheckBox({
    super.key,
    required this.text,
    this.textColor,
    this.textFontWeight,
    this.textSize,
    this.checkColor,
    this.activeColor,
    required this.checkValue,
    this.side,
    required this.onChanged,
  });

  final String text;
  final Color? textColor;
  final Color? checkColor;
  final FontWeight? textFontWeight;
  final double? textSize;
  final Color? activeColor;
  final BorderSide? side;
  final bool checkValue;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox.adaptive(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            value: checkValue,
            side: side ??
                BorderSide(
                  width: 2,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
            activeColor: activeColor,
            onChanged: onChanged),
        AppText(
          text,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: textColor,
                fontWeight: textFontWeight,
                fontSize: textSize,
              ),
        ),
      ],
    );
  }
}
