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

/// Get Android SDK version
Future<int?> _getAndroidSdkVersion() async {
  if (!Platform.isAndroid) return null;
  try {
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt;
  } catch (_) {
    return null;
  }
}

Future<void> saveScreenshot(
  BuildContext ctx,
  ScreenshotController screenshotController,
) async {
  try {
    final isSimulator = await _isIOSSimulator();
    
    // For iOS, try to save directly first (iOS 11+ may not require runtime permission)
    // Only need NSPhotoLibraryAddUsageDescription in Info.plist
    if (Platform.isIOS) {
      debugPrint('iOS device detected, isSimulator: $isSimulator');
      // Try to save directly first
      final success = await _captureAndSave(ctx, screenshotController);
      if (success) {
        debugPrint('Successfully saved screenshot on iOS');
        return;
      }
      
      // If direct save failed, try requesting permission
      debugPrint('Direct save failed, requesting permission...');
      final status = await _requestPhotoPermission();
      debugPrint('Permission status: $status');
      
      // Try again after requesting permission
      if (status.isGranted || status.isLimited || (isSimulator && status.isPermanentlyDenied)) {
        final retrySuccess = await _captureAndSave(ctx, screenshotController);
        if (retrySuccess) {
          debugPrint('Successfully saved after permission request');
          return;
        }
      }
      
      // Handle permission errors
      await _handlePermissionError(ctx, status, isSimulator);
      return;
    }
    
    // Android permission handling
    final status = await _requestPhotoPermission();
    final androidSdkVersion = await _getAndroidSdkVersion();
    final isAndroid10to12 = Platform.isAndroid &&
        androidSdkVersion != null &&
        androidSdkVersion >= 29 &&
        androidSdkVersion <= 32;

    final shouldTrySave = status.isGranted ||
        (isAndroid10to12 && !status.isPermanentlyDenied);

    if (shouldTrySave) {
      final success = await _captureAndSave(ctx, screenshotController);
      if (success) return;
    }

    // Handle permission errors
    await _handlePermissionError(ctx, status, isSimulator);
  } catch (error) {
    debugPrint('Error in saveScreenshot: $error');
    _showToast(ctx, 'ᠬᠠᠳᠠᠭᠠᠯᠠᠵᠤ ᠴᠢᠳᠠᠭᠰᠠᠨ ᠦᠭᠡᠢ : ${error.toString()}');
  }
}

/// Request photo permission based on platform and Android version
Future<PermissionStatus> _requestPhotoPermission() async {
  if (Platform.isIOS) {
    // iOS: Try photosAddOnly first (iOS 14+), then fallback to photos
    // Note: iOS 11+ may not require runtime permission for saving images
    // if NSPhotoLibraryAddUsageDescription is in Info.plist
    try {
      debugPrint('Checking photosAddOnly permission...');
      final addOnlyStatus = await Permission.photosAddOnly.status;
      debugPrint('photosAddOnly status: $addOnlyStatus');
      
      if (addOnlyStatus.isGranted || addOnlyStatus.isLimited) {
        return addOnlyStatus;
      }
      
      // Request photosAddOnly permission
      debugPrint('Requesting photosAddOnly permission...');
      final requestedStatus = await Permission.photosAddOnly.request();
      debugPrint('photosAddOnly request result: $requestedStatus');
      
      if (requestedStatus.isGranted || requestedStatus.isLimited) {
        return requestedStatus;
      }
      
      // Fallback to photos permission for older iOS versions
      debugPrint('Falling back to photos permission...');
      final photosStatus = await Permission.photos.status;
      debugPrint('photos status: $photosStatus');
      
      if (photosStatus.isGranted || photosStatus.isLimited) {
        return photosStatus;
      }
      
      final photosRequested = await Permission.photos.request();
      debugPrint('photos request result: $photosRequested');
      return photosRequested;
    } catch (e) {
      debugPrint('Error requesting iOS permission: $e');
      // Fallback to photos permission if photosAddOnly is not available
      try {
        final photosStatus = await Permission.photos.status;
        return photosStatus.isGranted ? photosStatus : await Permission.photos.request();
      } catch (_) {
        // If all fails, return denied status
        return PermissionStatus.denied;
      }
    }
  } else if (Platform.isAndroid) {
    final sdkVersion = await _getAndroidSdkVersion();

    // Android 13+ (SDK 33+) uses READ_MEDIA_IMAGES (Permission.photos)
    if (sdkVersion != null && sdkVersion >= 33) {
      final status = await Permission.photos.status;
      return status.isGranted ? status : await Permission.photos.request();
    }
    // Android 9 and below (SDK <= 28) uses storage permission
    else if (sdkVersion != null && sdkVersion <= 28) {
      final status = await Permission.storage.status;
      return status.isGranted ? status : await Permission.storage.request();
    }
    // Android 10-12 (SDK 29-32) may not need permission due to scoped storage
    // but we'll try storage permission as fallback
    else {
      // Try storage permission first
      final storageStatus = await Permission.storage.status;
      if (storageStatus.isGranted) {
        return storageStatus;
      }
      // If not granted, try requesting it
      final requestedStatus = await Permission.storage.request();
      if (requestedStatus.isGranted) {
        return requestedStatus;
      }
      // For Android 10-12, scoped storage might allow saving without permission
      // Return a status that allows trying to save
      return requestedStatus;
    }
  }

  // Fallback for other platforms
  final status = await Permission.photos.status;
  return status.isGranted ? status : await Permission.photos.request();
}

/// Capture and save screenshot
Future<bool> _captureAndSave(
  BuildContext ctx,
  ScreenshotController screenshotController,
) async {
  try {
    debugPrint('Starting to capture screenshot...');
    final imageBytes = await screenshotController.capture(pixelRatio: 3.0);
    if (imageBytes == null) {
      debugPrint('Failed to capture screenshot: imageBytes is null');
      _showToast(ctx,
          'ᠳᠡᠯᠭᠡᠴᠡ ᠎ᠶᠢᠨ ᠵᠢᠷᠤᠭ ᠠᠪᠤᠯᠲᠠ ᠠᠮᠵᠢᠯᠲᠠ ᠦᠭᠡᠢ ᠪᠣᠯᠤᠯ᠎ᠠ ᠂ᠲᠠ ᠳᠠᠬᠢᠨ ᠲᠤᠷᠰᠢᠨ᠎ᠠ᠎ᠤᠤ ');
      return false;
    }

    debugPrint('Screenshot captured, size: ${imageBytes.length} bytes');
    debugPrint('Attempting to save to gallery...');
    
    final result = await ImageGallerySaverPlus.saveImage(
      imageBytes,
      quality: 90,
      name: 'quote_${DateTime.now().millisecondsSinceEpoch}',
    );
    
    debugPrint('Save result: $result');
    
    // Check if save was successful
    // image_gallery_saver_plus returns a map with 'isSuccess' key
    if (result != null) {
      final isSuccess = result['isSuccess'] == true || result['isSuccess'] == 1;
      final filePath = result['filePath'];
      
      debugPrint('Save success: $isSuccess, filePath: $filePath');
      
      if (isSuccess) {
        _showToast(ctx, 'ᠵᠢᠷᠤᠭ ᠠᠮᠵᠢᠯᠲᠠ ᠎ᠲᠠᠢ ᠬᠠᠳᠠᠭᠠᠯᠠᠭᠳᠠᠯ᠎ᠠ ');
        return true;
      } else {
        final errorMsg = result['errorMessage'] ?? 'Unknown error';
        debugPrint('Save failed: $errorMsg');
        _showToast(ctx, 'ᠵᠢᠷᠤᠭ ᠠᠮᠵᠢᠯᠲᠠ ᠦᠭᠡᠢ ᠪᠣᠯᠤᠯ᠎ᠠ ᠂ᠲᠠ ᠳᠠᠬᠢᠨ ᠲᠤᠷᠰᠢᠨ᠎ᠠ᠎ᠤᠤ ');
        return false;
      }
    } else {
      debugPrint('Save result is null');
      _showToast(ctx, 'ᠵᠢᠷᠤᠭ ᠠᠮᠵᠢᠯᠲᠠ ᠦᠭᠡᠢ ᠪᠣᠯᠤᠯ᠎ᠠ ᠂ᠲᠠ ᠳᠠᠬᠢᠨ ᠲᠤᠷᠰᠢᠨ᠎ᠠ᠎ᠤᠤ ');
      return false;
    }
  } catch (e, stackTrace) {
    // Log error for debugging
    debugPrint('Error saving screenshot: $e');
    debugPrint('Stack trace: $stackTrace');
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
