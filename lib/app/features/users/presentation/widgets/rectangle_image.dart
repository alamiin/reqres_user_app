import 'package:flutter/material.dart';
import 'custom_image.dart';

class RectangleImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final Color borderColor;

  const RectangleImage({
    Key? key,
    required this.imageUrl,
    required this.height,
    required this.width,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const borderRadius = BorderRadius.all(Radius.circular(8));

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: borderColor),
        borderRadius: borderRadius,
      ),
      clipBehavior: Clip.hardEdge,
      alignment: Alignment.center,
      child: ClipRRect(
        borderRadius: borderRadius,
        child: CustomImage(
          image: imageUrl,
          height: height,
          width: width,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
