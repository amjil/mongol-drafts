import 'package:drift/drift.dart';
import 'package:electricsql_flutter/drivers/drift.dart';
import 'package:mongol_drafts/generated/electric/drift_schema.dart';
import 'connection/connection.dart' as impl;

part 'database.g.dart';

@DriftDatabase(tables: kElectrifiedTables)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        //
        print("Dummy onCreate");
      },
    );
  }
}

Future<AppDatabase> initDriftDatabase() async {
  final db = AppDatabase(impl.connect());

  await db.customSelect("SELECT 1").get();

  return db;
}
