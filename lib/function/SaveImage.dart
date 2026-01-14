import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class SaveImageService {
  Future<void> saveToGallery(BuildContext context, GlobalKey key) async {
    try {
      // 1️⃣ Permission
      final status = await Permission.photos.request();
      if (!status.isGranted) return;

      // 2️⃣ Capture widget
      RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;

      ui.Image image = await boundary.toImage(pixelRatio: 3);
      ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // 3️⃣ Save to gallery (THIS WORKS)
      await ImageGallerySaverPlus.saveImage(
        pngBytes,
        name: "IMG_${DateTime.now().millisecondsSinceEpoch}",
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Saved to Gallery')));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
