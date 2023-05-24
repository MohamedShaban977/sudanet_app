import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    this.width,
    this.height, required this.imagePath,

  });

  final double? width;
  final double? height;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Image.network(

        imagePath,
        fit: BoxFit.fill,
        height: height,
        width: width,
        gaplessPlayback: true,
      ),
    );
  }
}