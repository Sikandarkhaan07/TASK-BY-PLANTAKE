import 'dart:math';

import 'package:flutter/material.dart';

class arc extends CustomPainter {
  final i;

  arc({required this.i});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.black
      ..strokeWidth = 3;
    if (i == 1) {
      canvas.drawCircle(const Offset(23, 25), 20, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
