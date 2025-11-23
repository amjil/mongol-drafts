import 'dart:io';

void main() async {
  const newPackageName = 'net.amjil.draft';
  const newDartPackageName =
      'net_amjil_draft'; // Dart package name cannot contain dots, use underscores

  print('Starting to change package name to: $newPackageName');
  print('Dart package name: $newDartPackageName\n');

  // 1. Modify pubspec.yaml
  // await modifyPubspecYaml(newDartPackageName);

  // 2. Modify Android build.gradle.kts
  await modifyAndroidBuildGradle(newPackageName);

  // 3. Modify iOS project.pbxproj
  await modifyIOSProject(newPackageName);

  // 4. Modify macOS project.pbxproj (if exists)
  await modifyMacOSProject(newPackageName);

  print('\n✅ Package name change completed!');
  print('Please run the following command to update dependencies:');
  print('  flutter pub get');
}

Future<void> modifyPubspecYaml(String newName) async {
  final file = File('pubspec.yaml');
  if (!await file.exists()) {
    print('❌ pubspec.yaml does not exist');
    return;
  }

  var content = await file.readAsString();
  final lines = content.split('\n');

  for (int i = 0; i < lines.length; i++) {
    if (lines[i].startsWith('name:')) {
      lines[i] = 'name: $newName';
      print('✓ Modified pubspec.yaml: name -> $newName');
      break;
    }
  }

  await file.writeAsString(lines.join('\n'));
}

Future<void> modifyAndroidBuildGradle(String newPackageName) async {
  final file = File('android/app/build.gradle.kts');
  if (!await file.exists()) {
    print('❌ android/app/build.gradle.kts does not exist');
    return;
  }

  var content = await file.readAsString();
  var modified = false;

  // Modify namespace
  if (content.contains('namespace = ')) {
    final regex = RegExp(r'namespace\s*=\s*"[^"]+"');
    if (regex.hasMatch(content)) {
      content = content.replaceAll(regex, 'namespace = "$newPackageName"');
      print('✓ Modified Android namespace -> $newPackageName');
      modified = true;
    }
  }

  // Modify applicationId
  if (content.contains('applicationId = ')) {
    final regex = RegExp(r'applicationId\s*=\s*"[^"]+"');
    if (regex.hasMatch(content)) {
      content = content.replaceAll(regex, 'applicationId = "$newPackageName"');
      print('✓ Modified Android applicationId -> $newPackageName');
      modified = true;
    }
  }

  if (modified) {
    await file.writeAsString(content);
  }
}

Future<void> modifyIOSProject(String newPackageName) async {
  final file = File('ios/Runner.xcodeproj/project.pbxproj');
  if (!await file.exists()) {
    print('❌ ios/Runner.xcodeproj/project.pbxproj does not exist');
    return;
  }

  var content = await file.readAsString();
  var modified = false;

  // Modify PRODUCT_BUNDLE_IDENTIFIER (excluding RunnerTests)
  final regex = RegExp(
    r'PRODUCT_BUNDLE_IDENTIFIER = (net\.amjil\.\w+);',
    multiLine: true,
  );

  if (regex.hasMatch(content)) {
    // Only replace the main app package name, keep RunnerTests
    content = content.replaceAllMapped(regex, (match) {
      final current = match.group(1)!;
      // If it's RunnerTests, keep it or update it as well
      if (current.contains('RunnerTests')) {
        return 'PRODUCT_BUNDLE_IDENTIFIER = $newPackageName.RunnerTests;';
      } else {
        return 'PRODUCT_BUNDLE_IDENTIFIER = $newPackageName;';
      }
    });
    print('✓ Modified iOS PRODUCT_BUNDLE_IDENTIFIER -> $newPackageName');
    modified = true;
  }

  if (modified) {
    await file.writeAsString(content);
  }
}

Future<void> modifyMacOSProject(String newPackageName) async {
  final file = File('macos/Runner.xcodeproj/project.pbxproj');
  if (!await file.exists()) {
    // macOS project may not exist, this is normal
    return;
  }

  var content = await file.readAsString();
  var modified = false;

  // Modify PRODUCT_BUNDLE_IDENTIFIER
  final regex = RegExp(
    r'PRODUCT_BUNDLE_IDENTIFIER = (net\.amjil\.\w+);',
    multiLine: true,
  );

  if (regex.hasMatch(content)) {
    content = content.replaceAllMapped(regex, (match) {
      final current = match.group(1)!;
      if (current.contains('RunnerTests')) {
        return 'PRODUCT_BUNDLE_IDENTIFIER = $newPackageName.RunnerTests;';
      } else {
        return 'PRODUCT_BUNDLE_IDENTIFIER = $newPackageName;';
      }
    });
    print('✓ Modified macOS PRODUCT_BUNDLE_IDENTIFIER -> $newPackageName');
    modified = true;
  }

  if (modified) {
    await file.writeAsString(content);
  }
}
