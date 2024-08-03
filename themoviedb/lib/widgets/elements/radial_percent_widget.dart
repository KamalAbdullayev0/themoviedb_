import 'package:flutter/material.dart';
import 'dart:math';

class RadialPercentWidget extends StatefulWidget {
  const RadialPercentWidget({super.key});

  @override
  State<RadialPercentWidget> createState() => _ExampleState();
}

class _ExampleState extends State<RadialPercentWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(50, 50),
              painter: MyPainter(),
            ),
            Center(
              child: Text(
                '68%',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double percent = 0.68;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawOval(Offset.zero & size, backgroundPaint);

    final filedPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawArc(
      Offset(5.5, 5.5) & Size(size.width - 11, size.height - 11),
      pi * 2 * percent - (pi / 2),
      pi * 2 * (1.0 - percent),
      false,
      filedPaint,
    );

    final feelPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Offset(5.5, 5.5) & Size(size.width - 11, size.height - 11),
      -pi / 2,
      pi * 2 * percent,
      false,
      feelPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
