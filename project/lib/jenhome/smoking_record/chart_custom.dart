// 折线绘制
//  import 'dart:html';
// import 'universal_html/html.dart' as html;
import 'custom_point.dart';

import 'package:flutter/cupertino.dart';

class LineChartPainter extends CustomPainter {
  final List<MyPoint<double>> points;
  LineChartPainter({Key? key, required this.points}) : super();
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = const Color(0xFF2080E5); //2080E5
    paint.strokeWidth = 2.0;
    paint.style = PaintingStyle.stroke;

    var pointPaint = Paint()..color = const Color(0xFF20FF65); //2080E5
    pointPaint.strokeWidth = 1.0;
    pointPaint.style = PaintingStyle.stroke;

    Path path = Path();
    path.moveTo(points[0].x, points[0].y);
    for (var point in points) {
      path.lineTo(point.x, point.y);
      canvas.drawCircle(Offset(point.x, point.y), 4.0, pointPaint);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// 坐标轴绘制
class AxisPainter extends CustomPainter {
  final MyPoint<double> horizontalStartPoint, horizontalEndPoint;
  final MyPoint<double> verticalStartPoint, verticalEndPoint;
  AxisPainter({
    Key? key,
    required this.horizontalStartPoint,
    required this.horizontalEndPoint,
    required this.verticalStartPoint,
    required this.verticalEndPoint,
  }) : super();
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..color = const Color(0xFF909090);
    paint.strokeWidth = 2.0;
    paint.style = PaintingStyle.stroke;

    Path horizontalPath = Path();
    horizontalPath.moveTo(horizontalStartPoint.x, horizontalStartPoint.y);
    horizontalPath.lineTo(horizontalEndPoint.x - 1, horizontalEndPoint.y);
    canvas.drawPath(horizontalPath, paint);

    Path verticalPath = Path();
    verticalPath.moveTo(verticalStartPoint.x, verticalStartPoint.y);
    verticalPath.lineTo(verticalEndPoint.x, verticalEndPoint.y + 1);
    canvas.drawPath(verticalPath, paint);

    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2.0;
    const double arrowLength = 12.0;
    // 画箭头
    Path horizontalArrow = Path();
    horizontalArrow.moveTo(horizontalEndPoint.x, horizontalEndPoint.y);
    horizontalArrow.lineTo(horizontalEndPoint.x - arrowLength,
        horizontalEndPoint.y - arrowLength / 2);
    horizontalArrow.lineTo(horizontalEndPoint.x - arrowLength,
        horizontalEndPoint.y + arrowLength / 2);
    horizontalArrow.close();
    canvas.drawPath(horizontalArrow, paint);

    // 画箭头
    Path verticalArrow = Path();
    verticalArrow.moveTo(verticalEndPoint.x, verticalEndPoint.y);
    verticalArrow.lineTo(
        verticalEndPoint.x - arrowLength / 2, verticalEndPoint.y + arrowLength);
    verticalArrow.lineTo(
        verticalEndPoint.x + arrowLength / 2, verticalEndPoint.y + arrowLength);
    verticalArrow.close();
    canvas.drawPath(verticalArrow, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}