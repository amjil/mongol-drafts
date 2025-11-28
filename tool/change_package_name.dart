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

  // 3. Move Kotlin files to new package directory
  await moveKotlinFiles(newPackageName);

  // 4. Modify iOS project.pbxproj
  await modifyIOSProject(newPackageName);

  // 5. Modify macOS project.pbxproj (if exists)
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

Future<void> moveKotlinFiles(String newPackageName) async {
  final kotlinDir = Directory('android/app/src/main/kotlin');
  if (!await kotlinDir.exists()) {
    print('⚠️  Kotlin directory does not exist, skipping file move');
    return;
  }

  // Find all .kt files in the kotlin directory
  final kotlinFiles = await kotlinDir
      .list(recursive: true)
      .where((entity) => entity is File && entity.path.endsWith('.kt'))
      .cast<File>()
      .toList();

  if (kotlinFiles.isEmpty) {
    print('⚠️  No Kotlin files found, skipping file move');
    return;
  }

  // Convert package name to directory path
  final newPackagePath = newPackageName.replaceAll('.', '/');
  final newPackageDir = Directory('${kotlinDir.path}/$newPackagePath');

  // Create new directory structure
  await newPackageDir.create(recursive: true);
  print('✓ Created new package directory: $newPackagePath');

  // Process each Kotlin file
  for (final file in kotlinFiles) {
    final content = await file.readAsString();
    
    // Extract old package name from file content
    final packageRegex = RegExp(r'^package\s+([^\s;]+)', multiLine: true);
    final match = packageRegex.firstMatch(content);
    
    if (match == null) {
      print('⚠️  No package declaration found in ${file.path}, skipping');
      continue;
    }

    final oldPackageName = match.group(1)!;
    
    // Skip if package name is already correct
    if (oldPackageName == newPackageName) {
      print('✓ Package name already correct in ${file.path}');
      continue;
    }

    // Update package declaration
    final newContent = content.replaceFirst(
      packageRegex,
      'package $newPackageName',
    );

    // Create new file path
    final fileName = file.path.split('/').last;
    final newFile = File('${newPackageDir.path}/$fileName');

    // Write updated content to new location
    await newFile.writeAsString(newContent);
    print('✓ Moved and updated ${file.path} -> ${newFile.path}');

    // Delete old file
    await file.delete();

    // Try to remove old directory if empty
    final oldDir = file.parent;
    try {
      if (await oldDir.list().isEmpty) {
        await oldDir.delete(recursive: true);
        print('✓ Removed empty directory: ${oldDir.path}');
      }
    } catch (e) {
      // Ignore errors when trying to delete directories
    }
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
