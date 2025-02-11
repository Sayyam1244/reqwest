import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:intl/intl.dart';

extension ImageTypeExtension on String {
  ImageType get imageType {
    if (startsWith('http') || startsWith('https')) {
      return ImageType.network;
    } else if (endsWith('.svg')) {
      return ImageType.svg;
    } else if (startsWith('file://')) {
      return ImageType.file;
    } else {
      return ImageType.png;
    }
  }
}

enum ImageType { svg, png, network, file, unknown }

extension OfficeTimingsExtension on String {
  List<String> getOfficeTimings(String season) {
    // "Office Timing: Summer  (10:00am  08:00pm), Winter  (10:00am  07:00pm)"
    final seasonSplit = season.split("Office Timing:");

    final seasonSplit2 = seasonSplit[1].split(",");

    final summer = seasonSplit2[0].split("Summer")[1];

    final winter = seasonSplit2[1].split("Winter")[1];

    return [summer, winter];
  }
}

extension PaddingExtension on Widget {
  Widget pad(EdgeInsets padding) => Padding(padding: padding, child: this);

  Widget padAll(double value) => pad(EdgeInsets.all(value));

  Widget padHorizontal(double value) =>
      pad(EdgeInsets.symmetric(horizontal: value));

  Widget padVertical(double value) =>
      pad(EdgeInsets.symmetric(vertical: value));
}

extension GestureExtension on Widget {
  Widget onTapped({required void Function() onTap}) => GestureDetector(
        onTap: onTap,
        child: this,
      );
}
