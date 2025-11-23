import 'dart:io';
import 'dart:convert';

void main(List<String> args) async {
  if (args.isEmpty) {
    print('Usage: dart tool/change_app_name.dart <new_app_name>');
    print('Example: dart tool/change_app_name.dart "My New App"');
    exit(1);
  }

  final newAppName = args[0];
  print('Starting to change app name to: $newAppName\n');

  // 1. Modify Android AndroidManifest.xml
  await modifyAndroidManifest(newAppName);

  // 2. Modify iOS Info.plist
  await modifyIOSInfoPlist(newAppName);

  // 3. Modify macOS Info.plist
  await modifyMacOSInfoPlist(newAppName);

  // 4. Modify Web index.html
  await modifyWebIndexHtml(newAppName);

  // 5. Modify Web manifest.json
  await modifyWebManifest(newAppName);

  print('\n✅ App name change completed!');
  print('Please rebuild your app for changes to take effect.');
}

Future<void> modifyAndroidManifest(String newAppName) async {
  final file = File('android/app/src/main/AndroidManifest.xml');
  if (!await file.exists()) {
    print('❌ android/app/src/main/AndroidManifest.xml does not exist');
    return;
  }

  var content = await file.readAsString();
  var modified = false;

  // Modify android:label
  final labelRegex = RegExp(r'android:label="[^"]*"');
  if (labelRegex.hasMatch(content)) {
    content = content.replaceAll(labelRegex, 'android:label="$newAppName"');
    print('✓ Modified Android android:label -> $newAppName');
    modified = true;
  }

  if (modified) {
    await file.writeAsString(content);
  }
}

Future<void> modifyIOSInfoPlist(String newAppName) async {
  final file = File('ios/Runner/Info.plist');
  if (!await file.exists()) {
    print('❌ ios/Runner/Info.plist does not exist');
    return;
  }

  var content = await file.readAsString();
  var modified = false;

  // Modify CFBundleDisplayName
  final displayNameRegex = RegExp(
    r'<key>CFBundleDisplayName</key>\s*<string>[^<]*</string>',
    multiLine: true,
  );
  if (displayNameRegex.hasMatch(content)) {
    content = content.replaceAll(
      displayNameRegex,
      '<key>CFBundleDisplayName</key>\n\t<string>$newAppName</string>',
    );
    print('✓ Modified iOS CFBundleDisplayName -> $newAppName');
    modified = true;
  }

  // Modify CFBundleName (optional, usually kept as bundle identifier)
  // Uncomment if you want to change CFBundleName as well
  // final bundleNameRegex = RegExp(
  //   r'<key>CFBundleName</key>\s*<string>[^<]*</string>',
  //   multiLine: true,
  // );
  // if (bundleNameRegex.hasMatch(content)) {
  //   content = content.replaceAll(
  //     bundleNameRegex,
  //     '<key>CFBundleName</key>\n\t<string>$newAppName</string>',
  //   );
  //   print('✓ Modified iOS CFBundleName -> $newAppName');
  //   modified = true;
  // }

  if (modified) {
    await file.writeAsString(content);
  }
}

Future<void> modifyMacOSInfoPlist(String newAppName) async {
  final file = File('macos/Runner/Info.plist');
  if (!await file.exists()) {
    // macOS project may not exist, this is normal
    return;
  }

  var content = await file.readAsString();
  var modified = false;

  // macOS uses CFBundleName which is usually set via PRODUCT_NAME variable
  // But we can add CFBundleDisplayName if it doesn't exist
  if (!content.contains('<key>CFBundleDisplayName</key>')) {
    // Find CFBundleName and add CFBundleDisplayName after it
    final bundleNameRegex = RegExp(
      r'(<key>CFBundleName</key>\s*<string>[^<]*</string>)',
      multiLine: true,
    );
    if (bundleNameRegex.hasMatch(content)) {
      content = content.replaceFirst(
        bundleNameRegex,
        r'$1' +
            '\n\t<key>CFBundleDisplayName</key>\n\t<string>$newAppName</string>',
      );
      print('✓ Added macOS CFBundleDisplayName -> $newAppName');
      modified = true;
    }
  } else {
    // If CFBundleDisplayName exists, update it
    final displayNameRegex = RegExp(
      r'<key>CFBundleDisplayName</key>\s*<string>[^<]*</string>',
      multiLine: true,
    );
    if (displayNameRegex.hasMatch(content)) {
      content = content.replaceAll(
        displayNameRegex,
        '<key>CFBundleDisplayName</key>\n\t<string>$newAppName</string>',
      );
      print('✓ Modified macOS CFBundleDisplayName -> $newAppName');
      modified = true;
    }
  }

  if (modified) {
    await file.writeAsString(content);
  }
}

Future<void> modifyWebIndexHtml(String newAppName) async {
  final file = File('web/index.html');
  if (!await file.exists()) {
    print('❌ web/index.html does not exist');
    return;
  }

  var content = await file.readAsString();
  var modified = false;

  // Modify <title>
  final titleRegex = RegExp(r'<title>[^<]*</title>');
  if (titleRegex.hasMatch(content)) {
    content = content.replaceAll(titleRegex, '<title>$newAppName</title>');
    print('✓ Modified Web <title> -> $newAppName');
    modified = true;
  }

  // Modify apple-mobile-web-app-title
  final appleTitleRegex = RegExp(
    r'<meta name="apple-mobile-web-app-title" content="[^"]*">',
  );
  if (appleTitleRegex.hasMatch(content)) {
    content = content.replaceAll(
      appleTitleRegex,
      '<meta name="apple-mobile-web-app-title" content="$newAppName">',
    );
    print('✓ Modified Web apple-mobile-web-app-title -> $newAppName');
    modified = true;
  }

  if (modified) {
    await file.writeAsString(content);
  }
}

Future<void> modifyWebManifest(String newAppName) async {
  final file = File('web/manifest.json');
  if (!await file.exists()) {
    print('❌ web/manifest.json does not exist');
    return;
  }

  try {
    final content = await file.readAsString();
    final manifest = jsonDecode(content) as Map<String, dynamic>;
    var modified = false;

    // Modify name
    if (manifest.containsKey('name')) {
      manifest['name'] = newAppName;
      print('✓ Modified Web manifest.json name -> $newAppName');
      modified = true;
    }

    // Modify short_name
    if (manifest.containsKey('short_name')) {
      manifest['short_name'] = newAppName;
      print('✓ Modified Web manifest.json short_name -> $newAppName');
      modified = true;
    }

    if (modified) {
      const encoder = JsonEncoder.withIndent('    ');
      await file.writeAsString(encoder.convert(manifest));
    }
  } catch (e) {
    print('❌ Error modifying web/manifest.json: $e');
  }
}

