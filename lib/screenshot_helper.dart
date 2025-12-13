import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:mongol/mongol.dart';

/// Check if it's an iOS simulator
Future<bool> _isIOSSimulator() async {
  if (!Platform.isIOS) return false;
  try {
    final iosInfo = await DeviceInfoPlugin().iosInfo;
    return !iosInfo.isPhysicalDevice;
  } catch (_) {
    return false;
  }
}

Future<void> saveScreenshot(
  BuildContext ctx,
  ScreenshotController screenshotController,
) async {
  try {
    final status = await _requestPhotoPermission();
    final isSimulator = await _isIOSSimulator();

    // On iOS simulator, even if permission shows as permanently denied, it may still be possible to save
    final shouldTrySave = status.isGranted ||
        (Platform.isIOS && isSimulator && status.isPermanentlyDenied);

    if (shouldTrySave) {
      final success = await _captureAndSave(ctx, screenshotController);
      if (success) return;
    }

    // Handle permission errors
    await _handlePermissionError(ctx, status, isSimulator);
  } catch (error) {
    _showToast(ctx, 'ᠬᠠᠳᠠᠭᠠᠯᠠᠵᠤ ᠴᠢᠳᠠᠭᠰᠠᠨ ᠦᠭᠡᠢ : ${error.toString()}');
  }
}

/// Request photo permission
Future<PermissionStatus> _requestPhotoPermission() async {
  final status = await Permission.photos.status;
  return status.isGranted ? status : await Permission.photos.request();
}

/// Capture and save screenshot
Future<bool> _captureAndSave(
  BuildContext ctx,
  ScreenshotController screenshotController,
) async {
  try {
    final imageBytes = await screenshotController.capture(pixelRatio: 3.0);
    if (imageBytes == null) {
      _showToast(ctx,
          'ᠳᠡᠯᠭᠡᠴᠡ ᠎ᠶᠢᠨ ᠵᠢᠷᠤᠭ ᠠᠪᠤᠯᠲᠠ ᠠᠮᠵᠢᠯᠲᠠ ᠦᠭᠡᠢ ᠪᠣᠯᠤᠯ᠎ᠠ ᠂ᠲᠠ ᠳᠠᠬᠢᠨ ᠲᠤᠷᠰᠢᠨ᠎ᠠ᠎ᠤᠤ ');
      return false;
    }

    await ImageGallerySaverPlus.saveImage(
      imageBytes,
      quality: 90,
      name: 'quote_${DateTime.now().millisecondsSinceEpoch}',
    );
    _showToast(ctx, 'ᠵᠢᠷᠤᠭ ᠠᠮᠵᠢᠯᠲᠠ ᠎ᠲᠠᠢ ᠬᠠᠳᠠᠭᠠᠯᠠᠭᠳᠠᠯ᠎ᠠ ');
    return true;
  } catch (_) {
    return false;
  }
}

/// Handle permission errors
Future<void> _handlePermissionError(
  BuildContext ctx,
  PermissionStatus status,
  bool isSimulator,
) async {
  if (status.isPermanentlyDenied) {
    if (Platform.isIOS && isSimulator) {
      _showToast(ctx,
          'Simulator permission error, please reset simulator or check settings');
    } else {
      _showToast(
          ctx,
          Platform.isIOS
              ? 'Please grant permission in Settings > Privacy & Security > Photos'
              : 'Permission permanently denied, please grant permission in Settings');
      await openAppSettings();
    }
  } else if (status.isDenied) {
    _showToast(ctx, 'Permission denied, unable to save image');
  } else {
    _showToast(ctx, 'Unknown permission status, unable to save image');
  }
}

void _showToast(BuildContext ctx, String msg) {
  showToastWidget(
    Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blueAccent,
      ),
      child: MongolText(msg),
    ),
    context: ctx,
    reverseAnimation: StyledToastAnimation.fade,
    animation: StyledToastAnimation.fade,
    position: StyledToastPosition.center,
  );
}
