import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommonShimmer extends StatelessWidget {
  CommonShimmer(
      {super.key, this.height, this.width, this.shape, this.radius = 2});
  double? height;
  double? width;
  BoxShape? shape;
  double radius;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Shimmer.fromColors(
        baseColor: Colors.black12,
        highlightColor: Colors.black45,
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: shape ?? BoxShape.rectangle,
            borderRadius: shape != null ? null : BorderRadius.circular(radius),
            color: Colors.black12,
          ),
        ),
      ),
    );
  }
}
