import 'package:flutter/material.dart';
import 'package:jago_volunteer_scanner/screens/profile_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final MobileScannerController _scannerController = MobileScannerController(
    // autoStart: false,
    // autoZoom: true
    detectionSpeed: DetectionSpeed.fromRawValue(1)
  );

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size layoutSize = constraints.biggest;

        final double scanWindowWidth = layoutSize.width / 3;
        final double scanWindowHeight = layoutSize.height / 2;
        return Scaffold(
          body: MobileScanner(
            scanWindow: Rect.fromCenter(center: layoutSize.center(Offset.zero), width: scanWindowWidth, height: scanWindowHeight),
            controller: _scannerController,
            onDetect: (capture) {
              final String? code = capture.barcodes.first.rawValue;
              if (code != null) {
                _scannerController.stop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(userId: code))).then((_) => _scannerController.start());
              }
            },
          ),
        );
      },
    );
  }
}
