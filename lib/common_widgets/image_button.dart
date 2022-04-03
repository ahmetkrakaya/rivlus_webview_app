import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final ImageProvider image;
  double imageHeight;
  final double radius;
  final Widget text;

  ImageButton({
    required this.onPressed,
    required this.image,
    this.imageHeight = 150,
    this.radius = 10,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    imageHeight = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 90
        : 135;
    return Card(
      elevation: 8,
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Ink.image(
              image: image,
              height: imageHeight,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              height: 8,
            ),
            text,
            const SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
