import 'dart:io';

void main(List<String> args) async {
  print('Starting to increment version...\n');

  // Read and update pubspec.yaml
  await incrementPubspecVersion();

  print('\n✅ Version incremented successfully!');
  print('Please run flutter pub get to update dependencies.');
}

Future<void> incrementPubspecVersion() async {
  final file = File('pubspec.yaml');
  if (!await file.exists()) {
    print('❌ pubspec.yaml file does not exist');
    exit(1);
  }

  var content = await file.readAsString();

  // Match version line: version: x.y.z or version: x.y.z+build_number
  final versionRegex =
      RegExp(r'^version:\s*(\d+)\.(\d+)\.(\d+)(?:\+(\d+))?', multiLine: true);

  if (!versionRegex.hasMatch(content)) {
    print('❌ Cannot find version in pubspec.yaml');
    exit(1);
  }

  final match = versionRegex.firstMatch(content);
  if (match == null) {
    print('❌ Cannot parse version');
    exit(1);
  }

  final major = int.parse(match.group(1)!);
  final minor = int.parse(match.group(2)!);
  final patch = int.parse(match.group(3)!);
  final buildNumber =
      match.group(4) != null ? int.parse(match.group(4)!) : null;

  // If build number exists, increment build number; otherwise increment patch version
  String newVersion;
  if (buildNumber != null) {
    final newBuildNumber = buildNumber + 1;
    newVersion = '$major.$minor.$patch+$newBuildNumber';
    print('Current version: $major.$minor.$patch+$buildNumber');
    print(
        'New version: $newVersion (build number: $buildNumber -> $newBuildNumber)');
  } else {
    final newPatch = patch + 1;
    newVersion = '$major.$minor.$newPatch';
    print('Current version: $major.$minor.$patch');
    print('New version: $newVersion (patch: $patch -> $newPatch)');
  }

  // Replace version
  content = content.replaceFirst(
    versionRegex,
    'version: $newVersion',
  );

  await file.writeAsString(content);
  print('✓ Updated version in pubspec.yaml');
}
