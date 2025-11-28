import 'dart:io';

/// Use icon from assets as app icon
/// This script checks if the icon file exists, then runs flutter_launcher_icons to generate app icons
/// 
/// Usage: dart run tool/setup_app_icon.dart
Future<void> main() async {
  print('Setting up app icon...\n');

  // Check if icon file exists
  final iconFile = File('assets/icon/app_icon.png');
  if (!await iconFile.exists()) {
    print('Error: assets/icon/app_icon.png file not found');
    print('Please ensure the icon file is located at assets/icon/app_icon.png');
    exit(1);
  }

  print('✓ Found icon file: assets/icon/app_icon.png');

  // Check if flutter_launcher_icons is configured in pubspec.yaml
  final pubspecFile = File('pubspec.yaml');
  if (!await pubspecFile.exists()) {
    print('Error: pubspec.yaml file not found');
    exit(1);
  }

  final pubspecContent = await pubspecFile.readAsString();
  if (!pubspecContent.contains('flutter_launcher_icons:')) {
    print('Warning: flutter_launcher_icons configuration not found in pubspec.yaml');
    print('Please ensure flutter_launcher_icons package is installed and configured');
  } else {
    print('✓ flutter_launcher_icons is configured in pubspec.yaml');
  }

  print('\nRunning flutter pub get...');
  final pubGetResult = await Process.run(
    'flutter',
    ['pub', 'get'],
    workingDirectory: Directory.current.path,
  );

  if (pubGetResult.exitCode != 0) {
    print('Error: flutter pub get failed');
    print(pubGetResult.stderr);
    exit(1);
  }

  print('✓ flutter pub get completed\n');

  print('Generating app icons...');
  print('Running: flutter pub run flutter_launcher_icons\n');

  final iconResult = await Process.run(
    'flutter',
    ['pub', 'run', 'flutter_launcher_icons'],
    workingDirectory: Directory.current.path,
  );

  if (iconResult.exitCode != 0) {
    print('Error: Failed to generate app icons');
    print(iconResult.stderr);
    exit(1);
  }

  print(iconResult.stdout);
  print('\n✓ App icons generation completed!');
  print('\nIcons have been applied to the following platforms:');
  print('  - Android');
  print('  - iOS');
  print('  - Web');
  print('\nPlease rebuild the app to see the new icons.');
}

