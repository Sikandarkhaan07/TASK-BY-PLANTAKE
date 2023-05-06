import 'dart:developer';

import 'package:flutter/material.dart';

class SleepScreen extends StatefulWidget {
  const SleepScreen({super.key});

  @override
  State<SleepScreen> createState() => _SleepScreenState();
}

class _SleepScreenState extends State<SleepScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  double line = 0.0;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 20));
    animation = Tween(begin: 0.0, end: 450.0).animate(controller)
      ..addListener(() {
        setState(() {
          line = animation.value;
          log("VALUE: $line");
          if (animation.isCompleted) {
            controller.repeat();
          }
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    print('Width: ${MediaQuery.of(context).size.width}');
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        reverse: true,
        child: CustomPaint(
          foregroundPainter: RPSCustomPainter(),
          // painter: ShapePainter(line),
          child: Container(
            height: 400,
            width: MediaQuery.of(context).size.width + animation.value,
            color: Colors.amberAccent,
          ),
        ),
      )),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    Paint paint1 = Paint()
      ..color = const Color.fromARGB(255, 8, 11, 13)
      ..style = PaintingStyle.fill
      ..strokeWidth = 4.0;

    Path path0 = Path();
    //moving path to the left center of screen
    path0.moveTo(0, size.height / 2);
    //drawing line of 150
    path0.lineTo(150, size.height / 2);
    //drawing the first  curve
    path0.quadraticBezierTo(180, size.height, 220, size.height / 2);
    //drawing the second line
    path0.lineTo(370, size.height / 2);
    //drawing the second  curve
    path0.quadraticBezierTo(410, size.height, 450, size.height / 2);
    canvas.drawPath(path0, paint0);
    //dot
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, 10, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
