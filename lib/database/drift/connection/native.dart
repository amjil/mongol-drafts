import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Future<String> getDatabasePath() async {
  final appDocsDir = await getApplicationDocumentsDirectory();
  final appDir = Directory(join(appDocsDir.path, "mongol_drafts"));
  if (!await appDir.exists()) {
    await appDir.create(recursive: true);
  }

  final todosDbPath = join(appDir.path, "app.db");

  return todosDbPath;
}

/// Obtains a database connection for running drift in a Dart VM.
DatabaseConnection connect() {
  return DatabaseConnection.delayed(Future(() async {
    final dbPath = await getDatabasePath();
    print("Using todos database at path $dbPath");

    return NativeDatabase.createBackgroundConnection(File(dbPath));
  }));
}
