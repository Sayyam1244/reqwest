import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';

class CommonPopupButton extends StatelessWidget {
  const CommonPopupButton({
    super.key,
    required this.popupList,
    required this.onSelected,
    this.iconColor,
  });

  final List<String> popupList;
  final void Function(String) onSelected;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopupMenuButton(
      iconColor: iconColor,
      elevation: 0,
      // onSelected: (v){},
      color: theme.colorScheme.background,
      surfaceTintColor: theme.colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
        side: BorderSide(
          color: theme.colorScheme.outline,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      itemBuilder: (context) {
        return popupList
            .mapIndexed(
              (index, element) => PopupMenuItem(
                onTap: () {
                  onSelected(element);
                },
                height: 21,
                padding: const EdgeInsets.only(top: 8, bottom: 8, left: 12),
                child: AppText(
                  element,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontSize: 12,
                    color: theme.colorScheme.onBackground,
                  ),
                ),
              ),
            )
            .toList();
      },
    );
  }
}
