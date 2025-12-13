import 'dart:io';

/// Setup photo save permissions for iOS and Android
///
/// Usage:
///   dart tool/setup_photo_permissions.dart
///
/// Or specify a custom permission description:
///   dart tool/setup_photo_permissions.dart "Need access to photo library to save images"
void main(List<String> args) async {
  // Default permission description
  final defaultDescription = 'Need access to photo library to save images';
  final description = args.isNotEmpty ? args[0] : defaultDescription;

  print('Starting to setup photo save permissions...\n');
  print('Permission description: $description\n');

  // 1. Setup Android permissions
  await setupAndroidPermissions();

  // 2. Setup iOS permissions
  await setupIOSPermissions(description);

  print('\n✅ Permission setup completed!');
  print('Please rebuild your app for changes to take effect.');
}

/// Setup Android permissions
///
/// Android requires the following permissions:
/// - WRITE_EXTERNAL_STORAGE (Android 9 and below)
/// - READ_EXTERNAL_STORAGE (Android 9 and below)
/// - READ_MEDIA_IMAGES (Android 13+)
Future<void> setupAndroidPermissions() async {
  final file = File('android/app/src/main/AndroidManifest.xml');
  if (!await file.exists()) {
    print('❌ android/app/src/main/AndroidManifest.xml does not exist');
    return;
  }

  var content = await file.readAsString();
  var modified = false;

  // List of permissions to add
  final permissions = [
    '<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" android:maxSdkVersion="32" />',
    '<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />',
    '<uses-permission android:name="android.permission.READ_MEDIA_IMAGES" />',
  ];

  // Check and add permissions
  for (final permission in permissions) {
    // Extract permission name
    final permissionNameMatch =
        RegExp(r'android:name="([^"]+)"').firstMatch(permission);
    if (permissionNameMatch == null) continue;

    final permissionName = permissionNameMatch.group(1);
    if (permissionName == null) continue;

    // Check if permission already exists (supports multiple formats)
    final existingPermissionPattern = RegExp(
      r'<uses-permission\s+android:name="' +
          RegExp.escape(permissionName) +
          r'"[^>]*\s*/>',
      multiLine: true,
    );

    if (!existingPermissionPattern.hasMatch(content)) {
      // Find position after <manifest> tag to insert permission
      final manifestMatch = RegExp(r'<manifest[^>]*>').firstMatch(content);
      if (manifestMatch != null) {
        final insertPosition = manifestMatch.end;
        content = content.substring(0, insertPosition) +
            '\n    $permission' +
            content.substring(insertPosition);
        print('✓ Added Android permission: $permissionName');
        modified = true;
      }
    } else {
      print('✓ Android permission already exists: $permissionName');
    }
  }

  if (modified) {
    await file.writeAsString(content);
    print('✓ Android permission configuration updated');
  }
}

/// Setup iOS permissions
///
/// iOS requires the following permission descriptions:
/// - NSPhotoLibraryAddUsageDescription: For saving images to photo library
/// - NSPhotoLibraryUsageDescription: For reading photo library (if needed)
Future<void> setupIOSPermissions(String description) async {
  final file = File('ios/Runner/Info.plist');
  if (!await file.exists()) {
    print('❌ ios/Runner/Info.plist does not exist');
    return;
  }

  var content = await file.readAsString();
  var modified = false;

  // iOS permission keys and descriptions
  final permissions = {
    'NSPhotoLibraryAddUsageDescription': description,
    'NSPhotoLibraryUsageDescription': description,
  };

  // Check and add/update permissions
  for (final entry in permissions.entries) {
    final key = entry.key;
    final value = entry.value;

    // Check if key exists
    final keyPattern = RegExp(
      r'<key>' + RegExp.escape(key) + r'</key>',
      multiLine: true,
    );

    if (keyPattern.hasMatch(content)) {
      // If key exists, update the corresponding value
      final keyValuePattern = RegExp(
        r'(<key>' + RegExp.escape(key) + r'</key>\s*)<string>[^<]*</string>',
        multiLine: true,
      );
      if (keyValuePattern.hasMatch(content)) {
        content = content.replaceFirst(
          keyValuePattern,
          r'$1<string>$value</string>',
        );
        print('✓ Updated iOS permission: $key');
        modified = true;
      }
    } else {
      // If key doesn't exist, add new permission entry
      // Find position before </dict> to insert (before the last </dict>)
      final dictEndPattern = RegExp(r'</dict>\s*</plist>', multiLine: true);
      if (dictEndPattern.hasMatch(content)) {
        content = content.replaceFirst(
          dictEndPattern,
          '\t<key>$key</key>\n\t<string>$value</string>\n</dict>\n</plist>',
        );
        print('✓ Added iOS permission: $key');
        modified = true;
      } else {
        // If </dict> not found, try to add after <dict>
        final dictStartPattern = RegExp(r'<dict>', multiLine: true);
        if (dictStartPattern.hasMatch(content)) {
          final lastMatch = dictStartPattern.allMatches(content).last;
          final insertPosition = lastMatch.end;
          content = content.substring(0, insertPosition) +
              '\n\t<key>$key</key>\n\t<string>$value</string>' +
              content.substring(insertPosition);
          print('✓ Added iOS permission: $key');
          modified = true;
        }
      }
    }
  }

  if (modified) {
    await file.writeAsString(content);
    print('✓ iOS permission configuration updated');
  } else {
    print('✓ iOS permission configuration up to date');
  }
}
