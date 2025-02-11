import 'dart:math';

import 'package:flutter/material.dart';

class AppPopUp extends StatefulWidget {
  final List<PopupMenuEntry> items;
  final void Function(dynamic)? onSelected;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
final List<String>? menuVal;


   const AppPopUp({
    super.key,
    required this.items,
    this.onSelected,
    this.icon,
    this.iconSize,
    this.iconColor, this.menuVal,
  });

  @override
  _AppPopUpState createState() => _AppPopUpState();
}

class _AppPopUpState extends State<AppPopUp> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      iconSize: widget.iconSize ?? 18,
      icon: Icon(
        widget.icon ?? Icons.more_vert,
        color: widget.iconColor ?? Theme.of(context).colorScheme.onBackground,
      ),
      //padding: const EdgeInsets.all(4),
      //color: Colors.white,
      //elevation: 20,
      enabled: true,
      onSelected: widget.onSelected,
      itemBuilder: (context) => widget.items,
    );
  }
}
