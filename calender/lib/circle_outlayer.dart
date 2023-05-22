// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class CircleOutlayer extends CustomPainter {
  final i;

  CircleOutlayer({required this.i});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.grey
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.miter;

    const Rect rect = Rect.fromLTWH(3, 5, 40, 40);

    if (i != 0) {
      canvas.drawArc(
        rect,
        4.72984, //271 degree
        1.74533, //100 degree
        false,
        paint,
      );

      canvas.drawArc(
        rect,
        0.541052, //31 degree
        1.74533, //100 degree
        false,
        paint,
      );

      canvas.drawArc(
        rect,
        2.63545,
        1.74533, //100 degree
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
