import 'package:flutter/material.dart';

class ScannerOverlayPainter extends CustomPainter {
  ScannerOverlayPainter({required this.scanWindow});

  final Rect scanWindow;

  @override
  void paint(Canvas canvas, Size size) {
    // --- Draw the Dimmed Background ---
    final Path backgroundPath = Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    const double cutoutBorderRadius = 20.0; // Radius for the rounded corners of the cutout
    final RRect scanWindowRRect = RRect.fromRectAndRadius(scanWindow, const Radius.circular(cutoutBorderRadius));
    final Path scanWindowPath = Path()..addRRect(scanWindowRRect);

    final Path backgroundWithCutout = Path.combine(PathOperation.difference, backgroundPath, scanWindowPath);

    final Paint backgroundPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.95)
      ..style = PaintingStyle.fill;

    canvas.drawPath(backgroundWithCutout, backgroundPaint);

    // --- Draw the Corner Markers ---
    final Paint cornerPaint = Paint()
      ..color =
          const Color(0xFFFEC761) // Orange color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    const double cornerLength = 70.0; // How long each arm of the 'L' is
    const double offset = 16.0; // Small offset from the scan window edge

    const double elbowRadius = 12.0; // Radius for the rounded elbow of the 'L'

    // Top-Left corner
    canvas.drawPath(
      Path()
        ..moveTo(scanWindow.left - offset, scanWindow.top + cornerLength)
        ..lineTo(scanWindow.left - offset, scanWindow.top - offset + elbowRadius)
        ..arcToPoint(Offset(scanWindow.left - offset + elbowRadius, scanWindow.top - offset), radius: Radius.circular(elbowRadius), clockwise: true)
        ..lineTo(scanWindow.left + cornerLength, scanWindow.top - offset),
      cornerPaint,
    );

    // Top-Right corner
    canvas.drawPath(
      Path()
        ..moveTo(scanWindow.right + offset, scanWindow.top + cornerLength)
        ..lineTo(scanWindow.right + offset, scanWindow.top - offset + elbowRadius)
        ..arcToPoint(Offset(scanWindow.right + offset - elbowRadius, scanWindow.top - offset), radius: Radius.circular(elbowRadius), clockwise: false)
        ..lineTo(scanWindow.right - cornerLength, scanWindow.top - offset),
      cornerPaint,
    );

    // Bottom-Left corner
    canvas.drawPath(
      Path()
        ..moveTo(scanWindow.left - offset, scanWindow.bottom - cornerLength)
        ..lineTo(scanWindow.left - offset, scanWindow.bottom + offset - elbowRadius)
        ..arcToPoint(
          Offset(scanWindow.left - offset + elbowRadius, scanWindow.bottom + offset),
          radius: Radius.circular(elbowRadius),
          clockwise: false,
        )
        ..lineTo(scanWindow.left + cornerLength, scanWindow.bottom + offset),
      cornerPaint,
    );

    // Bottom-Right corner
    canvas.drawPath(
      Path()
        ..moveTo(scanWindow.right + offset, scanWindow.bottom - cornerLength)
        ..lineTo(scanWindow.right + offset, scanWindow.bottom + offset - elbowRadius)
        ..arcToPoint(
          Offset(scanWindow.right + offset - elbowRadius, scanWindow.bottom + offset),
          radius: Radius.circular(elbowRadius),
          clockwise: true,
        )
        ..lineTo(scanWindow.right - cornerLength, scanWindow.bottom + offset),
      cornerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant ScannerOverlayPainter oldDelegate) {
    return oldDelegate.scanWindow != scanWindow;
  }
}