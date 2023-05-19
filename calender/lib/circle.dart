// ignore_for_file: camel_case_types

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
      canvas.drawArc(
        const Rect.fromLTWH(6, 8, 33, 33),
        4.72984, //271 degree
        2.02458, //118 degree
        false,
        paint,
      );
    }
    if (i == 2) {
      canvas.drawArc(
        const Rect.fromLTWH(6, 8, 33, 33),
        4.72984, //271 degree
        2.02458, //118 degree
        false,
        paint,
      );

      canvas.drawArc(
        const Rect.fromLTWH(6, 8, 33, 33),
        0.541052, //31 degree
        2.02458, //118 degree
        false,
        paint,
      );
    }
    if (i == 3) {
      canvas.drawArc(
        const Rect.fromLTWH(6, 8, 33, 33),
        4.72984, //271 degree
        2.02458, //118 degree
        false,
        paint,
      );

      canvas.drawArc(
        const Rect.fromLTWH(6, 8, 33, 33),
        0.541052, //31 degree
        2.02458, //118 degree
        false,
        paint,
      );

      canvas.drawArc(
        const Rect.fromLTWH(6, 8, 33, 33),
        2.63545,
        2.02458,
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
