// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: always_use_package_imports, depend_on_referenced_packages
// ignore_for_file: prefer_double_quotes

import 'package:drift/drift.dart';
import 'package:electricsql/drivers/drift.dart';
import 'package:electricsql/electricsql.dart';

import './migrations.dart';
import './pg_migrations.dart';

const kElectricMigrations = ElectricMigrations(
  sqliteMigrations: kSqliteMigrations,
  pgMigrations: kPostgresMigrations,
);
const kElectrifiedTables = [
  DraftTags,
  Drafts,
  SchemaMigrations,
  Tags,
  Workspaces,
];

class DraftTags extends Table with ElectricTableMixin {
  TextColumn get id => customType(ElectricTypes.uuid).named('id')();

  TextColumn get electricUserId =>
      customType(ElectricTypes.uuid).named('electric_user_id')();

  TextColumn get tagId => customType(ElectricTypes.uuid).named('tag_id')();

  TextColumn get draftId => customType(ElectricTypes.uuid).named('draft_id')();

  @override
  String? get tableName => 'draft_tags';

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  $DraftTagsTableRelations get $relations => const $DraftTagsTableRelations();
}

class Drafts extends Table with ElectricTableMixin {
  TextColumn get id => customType(ElectricTypes.uuid).named('id')();

  TextColumn get workspaceId =>
      customType(ElectricTypes.uuid).named('workspace_id')();

  TextColumn get electricUserId =>
      customType(ElectricTypes.uuid).named('electric_user_id')();

  TextColumn get content => text().named('content').nullable()();

  BoolColumn get flag => boolean().named('flag')();

  IntColumn get status => customType(ElectricTypes.int2).named('status')();

  Column<DateTime> get createdAt =>
      customType(ElectricTypes.timestamp).named('created_at').nullable()();

  Column<DateTime> get updatedAt =>
      customType(ElectricTypes.timestamp).named('updated_at').nullable()();

  @override
  String? get tableName => 'drafts';

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  $DraftsTableRelations get $relations => const $DraftsTableRelations();
}

class SchemaMigrations extends Table {
  TextColumn get version => text().named('version')();

  @override
  String? get tableName => 'schema_migrations';

  @override
  Set<Column<Object>>? get primaryKey => {version};
}

class Tags extends Table with ElectricTableMixin {
  TextColumn get id => customType(ElectricTypes.uuid).named('id')();

  TextColumn get workspaceId =>
      customType(ElectricTypes.uuid).named('workspace_id')();

  TextColumn get electricUserId =>
      customType(ElectricTypes.uuid).named('electric_user_id')();

  TextColumn get name => text().named('name').nullable()();

  IntColumn get relatedNum =>
      customType(ElectricTypes.int4).named('related_num').nullable()();

  @override
  String? get tableName => 'tags';

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  $TagsTableRelations get $relations => const $TagsTableRelations();
}

class Workspaces extends Table with ElectricTableMixin {
  TextColumn get id => customType(ElectricTypes.uuid).named('id')();

  TextColumn get electricUserId =>
      customType(ElectricTypes.uuid).named('electric_user_id')();

  TextColumn get name => text().named('name').nullable()();

  @override
  String? get tableName => 'workspaces';

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  $WorkspacesTableRelations get $relations => const $WorkspacesTableRelations();
}

// ------------------------------ RELATIONS ------------------------------

class $DraftTagsTableRelations implements TableRelations {
  const $DraftTagsTableRelations();

  TableRelation<Drafts> get drafts => const TableRelation<Drafts>(
        fromField: 'draft_id',
        toField: 'id',
        relationName: 'DraftTagsToDrafts',
      );

  TableRelation<Tags> get tags => const TableRelation<Tags>(
        fromField: 'tag_id',
        toField: 'id',
        relationName: 'DraftTagsToTags',
      );

  @override
  List<TableRelation<Table>> get $relationsList => [
        drafts,
        tags,
      ];
}

class $DraftsTableRelations implements TableRelations {
  const $DraftsTableRelations();

  TableRelation<DraftTags> get draftTags => const TableRelation<DraftTags>(
        fromField: '',
        toField: '',
        relationName: 'DraftTagsToDrafts',
      );

  TableRelation<Workspaces> get workspaces => const TableRelation<Workspaces>(
        fromField: 'workspace_id',
        toField: 'id',
        relationName: 'DraftsToWorkspaces',
      );

  @override
  List<TableRelation<Table>> get $relationsList => [
        draftTags,
        workspaces,
      ];
}

class $TagsTableRelations implements TableRelations {
  const $TagsTableRelations();

  TableRelation<DraftTags> get draftTags => const TableRelation<DraftTags>(
        fromField: '',
        toField: '',
        relationName: 'DraftTagsToTags',
      );

  TableRelation<Workspaces> get workspaces => const TableRelation<Workspaces>(
        fromField: 'workspace_id',
        toField: 'id',
        relationName: 'TagsToWorkspaces',
      );

  @override
  List<TableRelation<Table>> get $relationsList => [
        draftTags,
        workspaces,
      ];
}

class $WorkspacesTableRelations implements TableRelations {
  const $WorkspacesTableRelations();

  TableRelation<Drafts> get drafts => const TableRelation<Drafts>(
        fromField: '',
        toField: '',
        relationName: 'DraftsToWorkspaces',
      );

  TableRelation<Tags> get tags => const TableRelation<Tags>(
        fromField: '',
        toField: '',
        relationName: 'TagsToWorkspaces',
      );

  @override
  List<TableRelation<Table>> get $relationsList => [
        drafts,
        tags,
      ];
}
