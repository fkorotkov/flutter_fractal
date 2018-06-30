import 'package:flutter/material.dart';
import 'dart:math';

class Fractal extends StatefulWidget {
  Fractal(this.depth);

  final double depth;

  @override
  State<StatefulWidget> createState() => FractalState(depth);
}

class FractalState extends State<Fractal> with TickerProviderStateMixin {
  double _desiredDepth;
  double _currentDepth;
  Animation<double> animation;
  AnimationController controller;

  FractalState(_desiredDepth) {
    this._desiredDepth = _desiredDepth;
    this._currentDepth = _desiredDepth - 1.0;
  }

  @override
  void didUpdateWidget(Fractal oldWidget) {
    super.didUpdateWidget(oldWidget);
    this._desiredDepth = this.widget.depth;

    if (animation != null && !animation.isCompleted) {
      controller.stop();
      controller.dispose();
    }

    controller = AnimationController(
        duration: Duration(milliseconds: 500), vsync: this);

    animation = Tween(begin: _currentDepth, end: _desiredDepth).animate(controller)
      ..addListener(() {
        setState(() {
          _currentDepth = animation.value;
        });
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: FractalPainter(this._currentDepth));
  }
}

class FractalPainter extends CustomPainter {
  double _depth;
  final double edgeLength = 10.0;

  FractalPainter(this._depth);

  void paint(Canvas canvas, Size size) {
    drawPart(
        canvas,
        size.bottomCenter(Offset(0.0, 0.0)),
        -pi/2,
        _depth
    );
  }

  void drawPart(Canvas canvas, Offset start, double angle, double depth) {
    if (depth <= 0.0) {
      return;
    }
    var end = start.translate(
        cos(angle) * depth * edgeLength,
        sin(angle) * depth * edgeLength
    );


    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = depth
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(start, end, paint);

    var angleStep = pi / 5;
    drawPart(canvas, end, angle - angleStep, depth - 1.0);
    drawPart(canvas, end, angle + angleStep, depth - 1.0);
  }

  @override
  bool shouldRepaint(FractalPainter oldDelegate) {
    return oldDelegate._depth != _depth;
  }
}