import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  final Widget? child;

  ShimmerWidget.rectangular(
      {super.key,
      this.width = double.infinity,
      required this.height,
      this.child})
      : shapeBorder =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(6));

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[300]!,
          child: Container(
            width: width,
            height: height,
            decoration:
                ShapeDecoration(color: Colors.grey[400]!, shape: shapeBorder),
          ),
        ),
        Container(child: child)
      ],
    );
  }
}
