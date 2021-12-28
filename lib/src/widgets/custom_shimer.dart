import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget {
  final double height;
  final double? width;
  final ShapeBorder shapeBorder;
  const CustomShimmer.rectangular(
      {required this.height, this.width = double.infinity})
      : this.shapeBorder = const RoundedRectangleBorder();

  const CustomShimmer.circular(
      {required this.height,
      this.width = double.infinity,
      this.shapeBorder = const CircleBorder()});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
           color: greyColor,
           shape: shapeBorder
        ),
       
      ),
    );
  }
}
