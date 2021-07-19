import 'dart:math';

import 'package:flutter/material.dart';


class CustomPath extends CustomPainter{
  final Color color;
  final double radius;

  CustomPath({required this.color , required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds = Rect.fromLTWH(0, 0, size.width, size.height);
    final centerAvatar = Offset(shapeBounds.left+radius, shapeBounds.bottom);
    final avatarBounds = Rect.fromCircle(center: centerAvatar, radius: radius);
    _drawBackground(canvas, shapeBounds, avatarBounds);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _drawBackground(Canvas canvas, Rect shapeBounds, Rect avatarBounds) {
    final paint = Paint()..color = color;
    final backgroundPath = Path()
      ..moveTo(shapeBounds.left, shapeBounds.top)
      ..lineTo(shapeBounds.bottomLeft.dx, shapeBounds.bottomLeft.dy)
      ..arcTo(avatarBounds, -pi, (pi+0.6)/2, false)
      ..lineTo(shapeBounds.bottomRight.dx, shapeBounds.bottomRight.dy+radius)
      ..lineTo(shapeBounds.topRight.dx, shapeBounds.topRight.dy)
      ..close();
    canvas.drawPath(backgroundPath, paint);
  }
}