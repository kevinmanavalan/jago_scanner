import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShareCardScreen extends StatefulWidget {
  final String name;
  const ShareCardScreen({super.key, required this.name});

  @override
  State<ShareCardScreen> createState() => _ShareCardScreenState();
}

class _ShareCardScreenState extends State<ShareCardScreen> {
final GlobalKey _cardKey = GlobalKey();
  Future<void> captureAndShare() async {
    try {
      // 4. Find the widget using the key
      RenderRepaintBoundary boundary = _cardKey.currentContext!.findRenderObject() as RenderRepaintBoundary;

      // 5. THIS IS THE HIGH-QUALITY PART
      // Capture at 3x the resolution
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);

      // 6. Convert to PNG bytes
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // 7. Save and share
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/card.png').create();
      await file.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(file.path)], text: 'Check out my card!');
    } catch (e) {
      print("Error capturing image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF455149),
        onPressed: captureAndShare, // Call your function
        child: const Icon(Icons.share, color: Colors.white),
      ),
      body: RepaintBoundary(
        key: _cardKey,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,

              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/assets/images/ticket_share.png'), // <-- CHANGE THIS
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 40, 0),
              child: Center(
                child: SizedBox(
                  width: 200,
                  child: FittedBox(
                    fit: BoxFit.scaleDown, // This shrinks the text to fit
                    child: Transform.rotate(
                      angle: 7.32 * math.pi / 180,
                      child: Text(
                        widget.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "MeowScript",
                          fontWeight: FontWeight.w400,
                          fontSize: 64, // FittedBox will shrink this as needed
                        ),
                        maxLines: 2, // Good to add
                        softWrap: false, // Good to add
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
