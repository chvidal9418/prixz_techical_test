import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircleWaveRoute extends StatefulWidget {
  @override
  _CircleWaveRouteState createState() => _CircleWaveRouteState();
}

class _CircleWaveRouteState extends State<CircleWaveRoute>
    with SingleTickerProviderStateMixin {

  double waveRadius = 0.0;
  double waveGap = 10.0;
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    configAnimationController();
  }

  @override
  Widget build(BuildContext context) {

    animation = Tween(begin: 0.0, end: waveGap).animate(controller)
      ..addListener(() {
        setState(() {
          waveRadius = animation.value;
        });
      });

    return CustomPaint(
      size: Size(
        double.infinity,
        double.infinity,
      ),
      painter: CircleWavePainter(waveRadius),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void configAnimationController() {
    controller = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);

    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
  }
}

class CircleWavePainter extends CustomPainter {
  final double waveRadius;
  var wavePaint;

  CircleWavePainter(this.waveRadius) {
    wavePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.3
      ..isAntiAlias = true;
  }

  @override
  void paint(Canvas canvas, Size size) {

    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double maxRadius = hypot(centerX, centerY);

    var currentRadius = waveRadius;
    while (currentRadius < maxRadius) {
      canvas.drawCircle(Offset(centerX, centerY), currentRadius, wavePaint);
      currentRadius += 10.0;
    }
  }

  @override
  bool shouldRepaint(CircleWavePainter oldDelegate) {
    return oldDelegate.waveRadius != waveRadius;
  }

  double hypot(double x, double y) {
    return math.sqrt(x * x + y * y);
  }
}
