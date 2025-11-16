import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jago_volunteer_scanner/screens/profile_screen.dart';
import 'package:jago_volunteer_scanner/widgets/scanner_overlay.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _MobileScannerAdvancedState();
}

class _MobileScannerAdvancedState extends State<QRScannerScreen> {
  MobileScannerController? controller;

  Size desiredCameraResolution = const Size(1920, 1080);

  /// Hides the MobileScanner widget while the MobileScannerController is
  /// rebuilding
  bool hideMobileScannerWidget = false;

  MobileScannerController initController() =>
      MobileScannerController(cameraResolution: desiredCameraResolution, detectionTimeoutMs: 1000, torchEnabled: false, autoZoom: true);

  @override
  void initState() {
    super.initState();
    controller = initController();
    unawaited(controller!.start());
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await controller?.dispose();
    controller = null;
  }

  @override
  Widget build(BuildContext context) {
    late final scanWindow = Rect.fromCenter(center: MediaQuery.sizeOf(context).center(const Offset(0, -100)), width: 240, height: 240);

    return Scaffold(
      backgroundColor: Colors.black,
      body: controller == null || hideMobileScannerWidget
          ? const Placeholder()
          : Stack(
              children: [
                MobileScanner(
                  scanWindow: scanWindow,
                  tapToFocus: true,
                  controller: controller,
                  onDetect: (capture) {
                    final String? code = capture.barcodes.first.rawValue;
                    if (code != null) {
                      controller?.stop();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(userId: code))).then((_) => controller?.start());
                    }
                  },
                ),
                IgnorePointer(
                  child: CustomPaint(
                    size: Size.infinite,
                    // This uses the painter class we built in our previous messages
                    painter: ScannerOverlayPainter(scanWindow: scanWindow),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(padding: const EdgeInsets.only(top: 90.0), child: Image.asset("lib/assets/images/converge_logo.png", scale: 1.7)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    height: 300,
                    color: const Color.fromRGBO(0, 0, 0, 0.6),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Text(
                            "OR",
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 60),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Enter your mobile no.",
                                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          TextField(
                            // controller: _phoneController,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixText: "+91 | ",
                              prefixStyle: const TextStyle(color: Colors.white, fontSize: 16),
                              hintText: "Type to enter",
                              hintStyle: TextStyle(color: Colors.grey.shade600),
                              filled: true,
                              fillColor: Colors.grey.shade900,
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0), borderSide: BorderSide.none),
                            ),
                          ),
                          const SizedBox(height: 15),

                          // --- PROCEED BUTTON ---
                          SizedBox(
                            width: double.infinity,
                            child: MaterialButton(
                              onPressed: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(userId: "")))},
                              color: const Color(0xFF4D725B), // Dark green-ish color
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
                              padding: const EdgeInsets.symmetric(vertical: 16.0),
                              child: const Text("Proceed", style: TextStyle(color: Colors.white, fontSize: 16)),
                            ),
                          ),
                          // Expanded(child: ScannedBarcodeLabel(barcodes: controller!.barcodes)),
                          // if (!kIsWeb) ZoomScaleSlider(controller: controller!),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          // ToggleFlashlightButton(controller: controller!),
                          // StartStopButton(controller: controller!),
                          // PauseButton(controller: controller!),
                          // SwitchCameraButton(controller: controller!),
                          // AnalyzeImageButton(controller: controller!),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}


