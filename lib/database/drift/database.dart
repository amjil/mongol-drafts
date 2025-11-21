import 'package:drift/drift.dart';
import 'connection/connection.dart' as impl;

part 'database.g.dart';

class DraftTags extends Table {
  TextColumn get id => text().named('id')();

  TextColumn get tagId => text().named('tag_id')();

  TextColumn get draftId => text().named('draft_id')();

  @override
  String? get tableName => 'draft_tags';

  @override
  Set<Column<Object>>? get primaryKey => {id};

}

class Drafts extends Table {
  TextColumn get id => text().named('id')();

  TextColumn get workspaceId => text().named('workspace_id')();

  TextColumn get content => text().named('content').nullable()();

  BoolColumn get flag => boolean().named('flag')();

  IntColumn get status => integer().named('status')();

  DateTimeColumn get createdAt => dateTime().named('created_at').nullable()();

  DateTimeColumn get updatedAt => dateTime().named('updated_at').nullable()();

  @override
  String? get tableName => 'drafts';

  @override
  Set<Column<Object>>? get primaryKey => {id};

}

class SchemaMigrations extends Table {
  TextColumn get version => text().named('version')();

  @override
  String? get tableName => 'schema_migrations';

  @override
  Set<Column<Object>>? get primaryKey => {version};
}

class Tags extends Table {
  TextColumn get id => text().named('id')();

  TextColumn get workspaceId => text().named('workspace_id')();

  TextColumn get name => text().named('name').nullable()();

  IntColumn get relatedNum => integer().named('related_num').nullable()();

  @override
  String? get tableName => 'tags';

  @override
  Set<Column<Object>>? get primaryKey => {id};

}

class Workspaces extends Table {
  TextColumn get id => text().named('id')();

  TextColumn get name => text().named('name').nullable()();

  @override
  String? get tableName => 'workspaces';

  @override
  Set<Column<Object>>? get primaryKey => {id};

}

@DriftDatabase(tables: [DraftTags, Drafts, SchemaMigrations, Tags, Workspaces])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {
        await m.createAll();
      },
    );
  }
}

Future<AppDatabase> initDriftDatabase() async {
  final db = AppDatabase(impl.connect());

  await db.customSelect("SELECT 1").get();

  return db;
}
