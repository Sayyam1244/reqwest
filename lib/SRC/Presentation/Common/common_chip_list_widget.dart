import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Application/Utils/Extensions/extensions.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';

class CommonChipListWidget extends StatelessWidget {
  CommonChipListWidget({
    super.key,
    required this.dataList,
    required this.onSelect,
    this.activeIndex,
    this.titleStyle,
    this.spaceBetween,
    this.margins,
  });

  final List<String> dataList;
  final Function(int i) onSelect;
  final int? activeIndex;
  final TextStyle? titleStyle;
  final int? spaceBetween;
  EdgeInsets? margins;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40,
          child: ListView.separated(
            padding: margins ?? const EdgeInsets.symmetric(horizontal: 24),
            itemCount: dataList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final element = dataList[index];
              return Chip(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: index == activeIndex
                        ? theme.colorScheme.primary
                        : theme.disabledColor,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                label: AppText(
                  element,
                  style: theme.textTheme.bodyMedium!.copyWith(
                    fontSize: 11,
                    color: index == activeIndex
                        ? theme.colorScheme.primary
                        : theme.disabledColor,
                  ),
                ),
              ).onTapped(onTap: () {
                onSelect(index);
              });
            },
            separatorBuilder: (BuildContext context, int index) =>
                10.horizontalSpace,
          ),
        )
      ],
    );
  }
}
