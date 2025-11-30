import 'dart:io';
import 'dart:convert';

void main(List<String> args) async {
  print('Starting to increment version...\n');

  // Read and update pubspec.yaml
  final newVersion = await incrementPubspecVersion();

  // Update version.json
  await incrementVersionJson(newVersion);

  print('\n✅ Version incremented successfully!');
  print('Please run flutter pub get to update dependencies.');
}

Future<String> incrementPubspecVersion() async {
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

  return newVersion;
}

Future<void> incrementVersionJson(String newVersion) async {
  final file = File('version.json');
  if (!await file.exists()) {
    print('⚠️  version.json file does not exist, skipping...');
    return;
  }

  var content = await file.readAsString();

  try {
    final json = jsonDecode(content) as Map<String, dynamic>;

    // Extract version without build number (e.g., "2.0.2+5" -> "2.0.2")
    final versionWithoutBuild = newVersion.split('+')[0];

    // Update versionCode
    json['versionCode'] = versionWithoutBuild;

    // Update downloadUrl if it exists
    if (json.containsKey('downloadUrl')) {
      final downloadUrl = json['downloadUrl'] as String;
      // Replace version in URL (e.g., /2.0.2/ -> /2.0.3/)
      final urlRegex = RegExp(r'/(\d+\.\d+\.\d+)/');
      if (urlRegex.hasMatch(downloadUrl)) {
        json['downloadUrl'] = downloadUrl.replaceFirst(
          urlRegex,
          '/$versionWithoutBuild/',
        );
      }
    }

    // Write back to file with proper formatting
    final encoder = JsonEncoder.withIndent('  ');
    await file.writeAsString(encoder.convert(json));
    print('✓ Updated version in version.json');
  } catch (e) {
    print('❌ Error updating version.json: $e');
    exit(1);
  }
}
