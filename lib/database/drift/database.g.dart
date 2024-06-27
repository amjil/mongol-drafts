// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DraftTagsTable extends DraftTags
    with TableInfo<$DraftTagsTable, DraftTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DraftTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _electricUserIdMeta =
      const VerificationMeta('electricUserId');
  @override
  late final GeneratedColumn<String> electricUserId = GeneratedColumn<String>(
      'electric_user_id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
      'tag_id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _draftIdMeta =
      const VerificationMeta('draftId');
  @override
  late final GeneratedColumn<String> draftId = GeneratedColumn<String>(
      'draft_id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, electricUserId, tagId, draftId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'draft_tags';
  @override
  VerificationContext validateIntegrity(Insertable<DraftTag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('electric_user_id')) {
      context.handle(
          _electricUserIdMeta,
          electricUserId.isAcceptableOrUnknown(
              data['electric_user_id']!, _electricUserIdMeta));
    } else if (isInserting) {
      context.missing(_electricUserIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('draft_id')) {
      context.handle(_draftIdMeta,
          draftId.isAcceptableOrUnknown(data['draft_id']!, _draftIdMeta));
    } else if (isInserting) {
      context.missing(_draftIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DraftTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DraftTag(
      id: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}id'])!,
      electricUserId: attachedDatabase.typeMapping.read(
          ElectricTypes.uuid, data['${effectivePrefix}electric_user_id'])!,
      tagId: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}tag_id'])!,
      draftId: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}draft_id'])!,
    );
  }

  @override
  $DraftTagsTable createAlias(String alias) {
    return $DraftTagsTable(attachedDatabase, alias);
  }
}

class DraftTag extends DataClass implements Insertable<DraftTag> {
  final String id;
  final String electricUserId;
  final String tagId;
  final String draftId;
  const DraftTag(
      {required this.id,
      required this.electricUserId,
      required this.tagId,
      required this.draftId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id, ElectricTypes.uuid);
    map['electric_user_id'] =
        Variable<String>(electricUserId, ElectricTypes.uuid);
    map['tag_id'] = Variable<String>(tagId, ElectricTypes.uuid);
    map['draft_id'] = Variable<String>(draftId, ElectricTypes.uuid);
    return map;
  }

  DraftTagsCompanion toCompanion(bool nullToAbsent) {
    return DraftTagsCompanion(
      id: Value(id),
      electricUserId: Value(electricUserId),
      tagId: Value(tagId),
      draftId: Value(draftId),
    );
  }

  factory DraftTag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DraftTag(
      id: serializer.fromJson<String>(json['id']),
      electricUserId: serializer.fromJson<String>(json['electricUserId']),
      tagId: serializer.fromJson<String>(json['tagId']),
      draftId: serializer.fromJson<String>(json['draftId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'electricUserId': serializer.toJson<String>(electricUserId),
      'tagId': serializer.toJson<String>(tagId),
      'draftId': serializer.toJson<String>(draftId),
    };
  }

  DraftTag copyWith(
          {String? id,
          String? electricUserId,
          String? tagId,
          String? draftId}) =>
      DraftTag(
        id: id ?? this.id,
        electricUserId: electricUserId ?? this.electricUserId,
        tagId: tagId ?? this.tagId,
        draftId: draftId ?? this.draftId,
      );
  @override
  String toString() {
    return (StringBuffer('DraftTag(')
          ..write('id: $id, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('tagId: $tagId, ')
          ..write('draftId: $draftId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, electricUserId, tagId, draftId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DraftTag &&
          other.id == this.id &&
          other.electricUserId == this.electricUserId &&
          other.tagId == this.tagId &&
          other.draftId == this.draftId);
}

class DraftTagsCompanion extends UpdateCompanion<DraftTag> {
  final Value<String> id;
  final Value<String> electricUserId;
  final Value<String> tagId;
  final Value<String> draftId;
  final Value<int> rowid;
  const DraftTagsCompanion({
    this.id = const Value.absent(),
    this.electricUserId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.draftId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DraftTagsCompanion.insert({
    required String id,
    required String electricUserId,
    required String tagId,
    required String draftId,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        electricUserId = Value(electricUserId),
        tagId = Value(tagId),
        draftId = Value(draftId);
  static Insertable<DraftTag> custom({
    Expression<String>? id,
    Expression<String>? electricUserId,
    Expression<String>? tagId,
    Expression<String>? draftId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (electricUserId != null) 'electric_user_id': electricUserId,
      if (tagId != null) 'tag_id': tagId,
      if (draftId != null) 'draft_id': draftId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DraftTagsCompanion copyWith(
      {Value<String>? id,
      Value<String>? electricUserId,
      Value<String>? tagId,
      Value<String>? draftId,
      Value<int>? rowid}) {
    return DraftTagsCompanion(
      id: id ?? this.id,
      electricUserId: electricUserId ?? this.electricUserId,
      tagId: tagId ?? this.tagId,
      draftId: draftId ?? this.draftId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value, ElectricTypes.uuid);
    }
    if (electricUserId.present) {
      map['electric_user_id'] =
          Variable<String>(electricUserId.value, ElectricTypes.uuid);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value, ElectricTypes.uuid);
    }
    if (draftId.present) {
      map['draft_id'] = Variable<String>(draftId.value, ElectricTypes.uuid);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DraftTagsCompanion(')
          ..write('id: $id, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('tagId: $tagId, ')
          ..write('draftId: $draftId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DraftsTable extends Drafts with TableInfo<$DraftsTable, Draft> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DraftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _workspaceIdMeta =
      const VerificationMeta('workspaceId');
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
      'workspace_id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _electricUserIdMeta =
      const VerificationMeta('electricUserId');
  @override
  late final GeneratedColumn<String> electricUserId = GeneratedColumn<String>(
      'electric_user_id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _contentMeta =
      const VerificationMeta('content');
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
      'content', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _flagMeta = const VerificationMeta('flag');
  @override
  late final GeneratedColumn<bool> flag = GeneratedColumn<bool>(
      'flag', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("flag" IN (0, 1))'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<int> status = GeneratedColumn<int>(
      'status', aliasedName, false,
      type: ElectricTypes.int2, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, true,
      type: ElectricTypes.timestamp, requiredDuringInsert: false);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: ElectricTypes.timestamp, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        workspaceId,
        electricUserId,
        content,
        flag,
        status,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drafts';
  @override
  VerificationContext validateIntegrity(Insertable<Draft> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
          _workspaceIdMeta,
          workspaceId.isAcceptableOrUnknown(
              data['workspace_id']!, _workspaceIdMeta));
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('electric_user_id')) {
      context.handle(
          _electricUserIdMeta,
          electricUserId.isAcceptableOrUnknown(
              data['electric_user_id']!, _electricUserIdMeta));
    } else if (isInserting) {
      context.missing(_electricUserIdMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('flag')) {
      context.handle(
          _flagMeta, flag.isAcceptableOrUnknown(data['flag']!, _flagMeta));
    } else if (isInserting) {
      context.missing(_flagMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Draft map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Draft(
      id: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}id'])!,
      workspaceId: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}workspace_id'])!,
      electricUserId: attachedDatabase.typeMapping.read(
          ElectricTypes.uuid, data['${effectivePrefix}electric_user_id'])!,
      content: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}content']),
      flag: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}flag'])!,
      status: attachedDatabase.typeMapping
          .read(ElectricTypes.int2, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(ElectricTypes.timestamp, data['${effectivePrefix}created_at']),
      updatedAt: attachedDatabase.typeMapping
          .read(ElectricTypes.timestamp, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $DraftsTable createAlias(String alias) {
    return $DraftsTable(attachedDatabase, alias);
  }
}

class Draft extends DataClass implements Insertable<Draft> {
  final String id;
  final String workspaceId;
  final String electricUserId;
  final String? content;
  final bool flag;
  final int status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  const Draft(
      {required this.id,
      required this.workspaceId,
      required this.electricUserId,
      this.content,
      required this.flag,
      required this.status,
      this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id, ElectricTypes.uuid);
    map['workspace_id'] = Variable<String>(workspaceId, ElectricTypes.uuid);
    map['electric_user_id'] =
        Variable<String>(electricUserId, ElectricTypes.uuid);
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String>(content);
    }
    map['flag'] = Variable<bool>(flag);
    map['status'] = Variable<int>(status, ElectricTypes.int2);
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] =
          Variable<DateTime>(createdAt, ElectricTypes.timestamp);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] =
          Variable<DateTime>(updatedAt, ElectricTypes.timestamp);
    }
    return map;
  }

  DraftsCompanion toCompanion(bool nullToAbsent) {
    return DraftsCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      electricUserId: Value(electricUserId),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      flag: Value(flag),
      status: Value(status),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Draft.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Draft(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      electricUserId: serializer.fromJson<String>(json['electricUserId']),
      content: serializer.fromJson<String?>(json['content']),
      flag: serializer.fromJson<bool>(json['flag']),
      status: serializer.fromJson<int>(json['status']),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'electricUserId': serializer.toJson<String>(electricUserId),
      'content': serializer.toJson<String?>(content),
      'flag': serializer.toJson<bool>(flag),
      'status': serializer.toJson<int>(status),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  Draft copyWith(
          {String? id,
          String? workspaceId,
          String? electricUserId,
          Value<String?> content = const Value.absent(),
          bool? flag,
          int? status,
          Value<DateTime?> createdAt = const Value.absent(),
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      Draft(
        id: id ?? this.id,
        workspaceId: workspaceId ?? this.workspaceId,
        electricUserId: electricUserId ?? this.electricUserId,
        content: content.present ? content.value : this.content,
        flag: flag ?? this.flag,
        status: status ?? this.status,
        createdAt: createdAt.present ? createdAt.value : this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Draft(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('content: $content, ')
          ..write('flag: $flag, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, workspaceId, electricUserId, content,
      flag, status, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Draft &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.electricUserId == this.electricUserId &&
          other.content == this.content &&
          other.flag == this.flag &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class DraftsCompanion extends UpdateCompanion<Draft> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> electricUserId;
  final Value<String?> content;
  final Value<bool> flag;
  final Value<int> status;
  final Value<DateTime?> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<int> rowid;
  const DraftsCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.electricUserId = const Value.absent(),
    this.content = const Value.absent(),
    this.flag = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DraftsCompanion.insert({
    required String id,
    required String workspaceId,
    required String electricUserId,
    this.content = const Value.absent(),
    required bool flag,
    required int status,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workspaceId = Value(workspaceId),
        electricUserId = Value(electricUserId),
        flag = Value(flag),
        status = Value(status);
  static Insertable<Draft> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? electricUserId,
    Expression<String>? content,
    Expression<bool>? flag,
    Expression<int>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (electricUserId != null) 'electric_user_id': electricUserId,
      if (content != null) 'content': content,
      if (flag != null) 'flag': flag,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DraftsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workspaceId,
      Value<String>? electricUserId,
      Value<String?>? content,
      Value<bool>? flag,
      Value<int>? status,
      Value<DateTime?>? createdAt,
      Value<DateTime?>? updatedAt,
      Value<int>? rowid}) {
    return DraftsCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      electricUserId: electricUserId ?? this.electricUserId,
      content: content ?? this.content,
      flag: flag ?? this.flag,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value, ElectricTypes.uuid);
    }
    if (workspaceId.present) {
      map['workspace_id'] =
          Variable<String>(workspaceId.value, ElectricTypes.uuid);
    }
    if (electricUserId.present) {
      map['electric_user_id'] =
          Variable<String>(electricUserId.value, ElectricTypes.uuid);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (flag.present) {
      map['flag'] = Variable<bool>(flag.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value, ElectricTypes.int2);
    }
    if (createdAt.present) {
      map['created_at'] =
          Variable<DateTime>(createdAt.value, ElectricTypes.timestamp);
    }
    if (updatedAt.present) {
      map['updated_at'] =
          Variable<DateTime>(updatedAt.value, ElectricTypes.timestamp);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DraftsCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('content: $content, ')
          ..write('flag: $flag, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SchemaMigrationsTable extends SchemaMigrations
    with TableInfo<$SchemaMigrationsTable, SchemaMigration> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SchemaMigrationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _versionMeta =
      const VerificationMeta('version');
  @override
  late final GeneratedColumn<String> version = GeneratedColumn<String>(
      'version', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [version];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'schema_migrations';
  @override
  VerificationContext validateIntegrity(Insertable<SchemaMigration> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('version')) {
      context.handle(_versionMeta,
          version.isAcceptableOrUnknown(data['version']!, _versionMeta));
    } else if (isInserting) {
      context.missing(_versionMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {version};
  @override
  SchemaMigration map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SchemaMigration(
      version: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}version'])!,
    );
  }

  @override
  $SchemaMigrationsTable createAlias(String alias) {
    return $SchemaMigrationsTable(attachedDatabase, alias);
  }
}

class SchemaMigration extends DataClass implements Insertable<SchemaMigration> {
  final String version;
  const SchemaMigration({required this.version});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['version'] = Variable<String>(version);
    return map;
  }

  SchemaMigrationsCompanion toCompanion(bool nullToAbsent) {
    return SchemaMigrationsCompanion(
      version: Value(version),
    );
  }

  factory SchemaMigration.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SchemaMigration(
      version: serializer.fromJson<String>(json['version']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'version': serializer.toJson<String>(version),
    };
  }

  SchemaMigration copyWith({String? version}) => SchemaMigration(
        version: version ?? this.version,
      );
  @override
  String toString() {
    return (StringBuffer('SchemaMigration(')
          ..write('version: $version')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => version.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SchemaMigration && other.version == this.version);
}

class SchemaMigrationsCompanion extends UpdateCompanion<SchemaMigration> {
  final Value<String> version;
  final Value<int> rowid;
  const SchemaMigrationsCompanion({
    this.version = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SchemaMigrationsCompanion.insert({
    required String version,
    this.rowid = const Value.absent(),
  }) : version = Value(version);
  static Insertable<SchemaMigration> custom({
    Expression<String>? version,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (version != null) 'version': version,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SchemaMigrationsCompanion copyWith(
      {Value<String>? version, Value<int>? rowid}) {
    return SchemaMigrationsCompanion(
      version: version ?? this.version,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (version.present) {
      map['version'] = Variable<String>(version.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SchemaMigrationsCompanion(')
          ..write('version: $version, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _workspaceIdMeta =
      const VerificationMeta('workspaceId');
  @override
  late final GeneratedColumn<String> workspaceId = GeneratedColumn<String>(
      'workspace_id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _electricUserIdMeta =
      const VerificationMeta('electricUserId');
  @override
  late final GeneratedColumn<String> electricUserId = GeneratedColumn<String>(
      'electric_user_id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _relatedNumMeta =
      const VerificationMeta('relatedNum');
  @override
  late final GeneratedColumn<int> relatedNum = GeneratedColumn<int>(
      'related_num', aliasedName, true,
      type: ElectricTypes.int4, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, workspaceId, electricUserId, name, relatedNum];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<Tag> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workspace_id')) {
      context.handle(
          _workspaceIdMeta,
          workspaceId.isAcceptableOrUnknown(
              data['workspace_id']!, _workspaceIdMeta));
    } else if (isInserting) {
      context.missing(_workspaceIdMeta);
    }
    if (data.containsKey('electric_user_id')) {
      context.handle(
          _electricUserIdMeta,
          electricUserId.isAcceptableOrUnknown(
              data['electric_user_id']!, _electricUserIdMeta));
    } else if (isInserting) {
      context.missing(_electricUserIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('related_num')) {
      context.handle(
          _relatedNumMeta,
          relatedNum.isAcceptableOrUnknown(
              data['related_num']!, _relatedNumMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}id'])!,
      workspaceId: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}workspace_id'])!,
      electricUserId: attachedDatabase.typeMapping.read(
          ElectricTypes.uuid, data['${effectivePrefix}electric_user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      relatedNum: attachedDatabase.typeMapping
          .read(ElectricTypes.int4, data['${effectivePrefix}related_num']),
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final String id;
  final String workspaceId;
  final String electricUserId;
  final String? name;
  final int? relatedNum;
  const Tag(
      {required this.id,
      required this.workspaceId,
      required this.electricUserId,
      this.name,
      this.relatedNum});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id, ElectricTypes.uuid);
    map['workspace_id'] = Variable<String>(workspaceId, ElectricTypes.uuid);
    map['electric_user_id'] =
        Variable<String>(electricUserId, ElectricTypes.uuid);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || relatedNum != null) {
      map['related_num'] = Variable<int>(relatedNum, ElectricTypes.int4);
    }
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      workspaceId: Value(workspaceId),
      electricUserId: Value(electricUserId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      relatedNum: relatedNum == null && nullToAbsent
          ? const Value.absent()
          : Value(relatedNum),
    );
  }

  factory Tag.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<String>(json['id']),
      workspaceId: serializer.fromJson<String>(json['workspaceId']),
      electricUserId: serializer.fromJson<String>(json['electricUserId']),
      name: serializer.fromJson<String?>(json['name']),
      relatedNum: serializer.fromJson<int?>(json['relatedNum']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workspaceId': serializer.toJson<String>(workspaceId),
      'electricUserId': serializer.toJson<String>(electricUserId),
      'name': serializer.toJson<String?>(name),
      'relatedNum': serializer.toJson<int?>(relatedNum),
    };
  }

  Tag copyWith(
          {String? id,
          String? workspaceId,
          String? electricUserId,
          Value<String?> name = const Value.absent(),
          Value<int?> relatedNum = const Value.absent()}) =>
      Tag(
        id: id ?? this.id,
        workspaceId: workspaceId ?? this.workspaceId,
        electricUserId: electricUserId ?? this.electricUserId,
        name: name.present ? name.value : this.name,
        relatedNum: relatedNum.present ? relatedNum.value : this.relatedNum,
      );
  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('name: $name, ')
          ..write('relatedNum: $relatedNum')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, workspaceId, electricUserId, name, relatedNum);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.workspaceId == this.workspaceId &&
          other.electricUserId == this.electricUserId &&
          other.name == this.name &&
          other.relatedNum == this.relatedNum);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> id;
  final Value<String> workspaceId;
  final Value<String> electricUserId;
  final Value<String?> name;
  final Value<int?> relatedNum;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.workspaceId = const Value.absent(),
    this.electricUserId = const Value.absent(),
    this.name = const Value.absent(),
    this.relatedNum = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String id,
    required String workspaceId,
    required String electricUserId,
    this.name = const Value.absent(),
    this.relatedNum = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        workspaceId = Value(workspaceId),
        electricUserId = Value(electricUserId);
  static Insertable<Tag> custom({
    Expression<String>? id,
    Expression<String>? workspaceId,
    Expression<String>? electricUserId,
    Expression<String>? name,
    Expression<int>? relatedNum,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workspaceId != null) 'workspace_id': workspaceId,
      if (electricUserId != null) 'electric_user_id': electricUserId,
      if (name != null) 'name': name,
      if (relatedNum != null) 'related_num': relatedNum,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith(
      {Value<String>? id,
      Value<String>? workspaceId,
      Value<String>? electricUserId,
      Value<String?>? name,
      Value<int?>? relatedNum,
      Value<int>? rowid}) {
    return TagsCompanion(
      id: id ?? this.id,
      workspaceId: workspaceId ?? this.workspaceId,
      electricUserId: electricUserId ?? this.electricUserId,
      name: name ?? this.name,
      relatedNum: relatedNum ?? this.relatedNum,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value, ElectricTypes.uuid);
    }
    if (workspaceId.present) {
      map['workspace_id'] =
          Variable<String>(workspaceId.value, ElectricTypes.uuid);
    }
    if (electricUserId.present) {
      map['electric_user_id'] =
          Variable<String>(electricUserId.value, ElectricTypes.uuid);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (relatedNum.present) {
      map['related_num'] = Variable<int>(relatedNum.value, ElectricTypes.int4);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('workspaceId: $workspaceId, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('name: $name, ')
          ..write('relatedNum: $relatedNum, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkspacesTable extends Workspaces
    with TableInfo<$WorkspacesTable, Workspace> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkspacesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _electricUserIdMeta =
      const VerificationMeta('electricUserId');
  @override
  late final GeneratedColumn<String> electricUserId = GeneratedColumn<String>(
      'electric_user_id', aliasedName, false,
      type: ElectricTypes.uuid, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, electricUserId, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workspaces';
  @override
  VerificationContext validateIntegrity(Insertable<Workspace> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('electric_user_id')) {
      context.handle(
          _electricUserIdMeta,
          electricUserId.isAcceptableOrUnknown(
              data['electric_user_id']!, _electricUserIdMeta));
    } else if (isInserting) {
      context.missing(_electricUserIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workspace map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workspace(
      id: attachedDatabase.typeMapping
          .read(ElectricTypes.uuid, data['${effectivePrefix}id'])!,
      electricUserId: attachedDatabase.typeMapping.read(
          ElectricTypes.uuid, data['${effectivePrefix}electric_user_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
    );
  }

  @override
  $WorkspacesTable createAlias(String alias) {
    return $WorkspacesTable(attachedDatabase, alias);
  }
}

class Workspace extends DataClass implements Insertable<Workspace> {
  final String id;
  final String electricUserId;
  final String? name;
  const Workspace({required this.id, required this.electricUserId, this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id, ElectricTypes.uuid);
    map['electric_user_id'] =
        Variable<String>(electricUserId, ElectricTypes.uuid);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    return map;
  }

  WorkspacesCompanion toCompanion(bool nullToAbsent) {
    return WorkspacesCompanion(
      id: Value(id),
      electricUserId: Value(electricUserId),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
    );
  }

  factory Workspace.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workspace(
      id: serializer.fromJson<String>(json['id']),
      electricUserId: serializer.fromJson<String>(json['electricUserId']),
      name: serializer.fromJson<String?>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'electricUserId': serializer.toJson<String>(electricUserId),
      'name': serializer.toJson<String?>(name),
    };
  }

  Workspace copyWith(
          {String? id,
          String? electricUserId,
          Value<String?> name = const Value.absent()}) =>
      Workspace(
        id: id ?? this.id,
        electricUserId: electricUserId ?? this.electricUserId,
        name: name.present ? name.value : this.name,
      );
  @override
  String toString() {
    return (StringBuffer('Workspace(')
          ..write('id: $id, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, electricUserId, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workspace &&
          other.id == this.id &&
          other.electricUserId == this.electricUserId &&
          other.name == this.name);
}

class WorkspacesCompanion extends UpdateCompanion<Workspace> {
  final Value<String> id;
  final Value<String> electricUserId;
  final Value<String?> name;
  final Value<int> rowid;
  const WorkspacesCompanion({
    this.id = const Value.absent(),
    this.electricUserId = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkspacesCompanion.insert({
    required String id,
    required String electricUserId,
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        electricUserId = Value(electricUserId);
  static Insertable<Workspace> custom({
    Expression<String>? id,
    Expression<String>? electricUserId,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (electricUserId != null) 'electric_user_id': electricUserId,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkspacesCompanion copyWith(
      {Value<String>? id,
      Value<String>? electricUserId,
      Value<String?>? name,
      Value<int>? rowid}) {
    return WorkspacesCompanion(
      id: id ?? this.id,
      electricUserId: electricUserId ?? this.electricUserId,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value, ElectricTypes.uuid);
    }
    if (electricUserId.present) {
      map['electric_user_id'] =
          Variable<String>(electricUserId.value, ElectricTypes.uuid);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkspacesCompanion(')
          ..write('id: $id, ')
          ..write('electricUserId: $electricUserId, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  _$AppDatabaseManager get managers => _$AppDatabaseManager(this);
  late final $DraftTagsTable draftTags = $DraftTagsTable(this);
  late final $DraftsTable drafts = $DraftsTable(this);
  late final $SchemaMigrationsTable schemaMigrations =
      $SchemaMigrationsTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $WorkspacesTable workspaces = $WorkspacesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [draftTags, drafts, schemaMigrations, tags, workspaces];
}

typedef $$DraftTagsTableInsertCompanionBuilder = DraftTagsCompanion Function({
  required String id,
  required String electricUserId,
  required String tagId,
  required String draftId,
  Value<int> rowid,
});
typedef $$DraftTagsTableUpdateCompanionBuilder = DraftTagsCompanion Function({
  Value<String> id,
  Value<String> electricUserId,
  Value<String> tagId,
  Value<String> draftId,
  Value<int> rowid,
});

class $$DraftTagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DraftTagsTable,
    DraftTag,
    $$DraftTagsTableFilterComposer,
    $$DraftTagsTableOrderingComposer,
    $$DraftTagsTableProcessedTableManager,
    $$DraftTagsTableInsertCompanionBuilder,
    $$DraftTagsTableUpdateCompanionBuilder> {
  $$DraftTagsTableTableManager(_$AppDatabase db, $DraftTagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DraftTagsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DraftTagsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$DraftTagsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> electricUserId = const Value.absent(),
            Value<String> tagId = const Value.absent(),
            Value<String> draftId = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DraftTagsCompanion(
            id: id,
            electricUserId: electricUserId,
            tagId: tagId,
            draftId: draftId,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String electricUserId,
            required String tagId,
            required String draftId,
            Value<int> rowid = const Value.absent(),
          }) =>
              DraftTagsCompanion.insert(
            id: id,
            electricUserId: electricUserId,
            tagId: tagId,
            draftId: draftId,
            rowid: rowid,
          ),
        ));
}

class $$DraftTagsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $DraftTagsTable,
    DraftTag,
    $$DraftTagsTableFilterComposer,
    $$DraftTagsTableOrderingComposer,
    $$DraftTagsTableProcessedTableManager,
    $$DraftTagsTableInsertCompanionBuilder,
    $$DraftTagsTableUpdateCompanionBuilder> {
  $$DraftTagsTableProcessedTableManager(super.$state);
}

class $$DraftTagsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DraftTagsTable> {
  $$DraftTagsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get tagId => $state.composableBuilder(
      column: $state.table.tagId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get draftId => $state.composableBuilder(
      column: $state.table.draftId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$DraftTagsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DraftTagsTable> {
  $$DraftTagsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get tagId => $state.composableBuilder(
      column: $state.table.tagId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get draftId => $state.composableBuilder(
      column: $state.table.draftId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$DraftsTableInsertCompanionBuilder = DraftsCompanion Function({
  required String id,
  required String workspaceId,
  required String electricUserId,
  Value<String?> content,
  required bool flag,
  required int status,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});
typedef $$DraftsTableUpdateCompanionBuilder = DraftsCompanion Function({
  Value<String> id,
  Value<String> workspaceId,
  Value<String> electricUserId,
  Value<String?> content,
  Value<bool> flag,
  Value<int> status,
  Value<DateTime?> createdAt,
  Value<DateTime?> updatedAt,
  Value<int> rowid,
});

class $$DraftsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DraftsTable,
    Draft,
    $$DraftsTableFilterComposer,
    $$DraftsTableOrderingComposer,
    $$DraftsTableProcessedTableManager,
    $$DraftsTableInsertCompanionBuilder,
    $$DraftsTableUpdateCompanionBuilder> {
  $$DraftsTableTableManager(_$AppDatabase db, $DraftsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$DraftsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$DraftsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$DraftsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> workspaceId = const Value.absent(),
            Value<String> electricUserId = const Value.absent(),
            Value<String?> content = const Value.absent(),
            Value<bool> flag = const Value.absent(),
            Value<int> status = const Value.absent(),
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DraftsCompanion(
            id: id,
            workspaceId: workspaceId,
            electricUserId: electricUserId,
            content: content,
            flag: flag,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String workspaceId,
            required String electricUserId,
            Value<String?> content = const Value.absent(),
            required bool flag,
            required int status,
            Value<DateTime?> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DraftsCompanion.insert(
            id: id,
            workspaceId: workspaceId,
            electricUserId: electricUserId,
            content: content,
            flag: flag,
            status: status,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
        ));
}

class $$DraftsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $DraftsTable,
    Draft,
    $$DraftsTableFilterComposer,
    $$DraftsTableOrderingComposer,
    $$DraftsTableProcessedTableManager,
    $$DraftsTableInsertCompanionBuilder,
    $$DraftsTableUpdateCompanionBuilder> {
  $$DraftsTableProcessedTableManager(super.$state);
}

class $$DraftsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $DraftsTable> {
  $$DraftsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get workspaceId => $state.composableBuilder(
      column: $state.table.workspaceId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get flag => $state.composableBuilder(
      column: $state.table.flag,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$DraftsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $DraftsTable> {
  $$DraftsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get workspaceId => $state.composableBuilder(
      column: $state.table.workspaceId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get content => $state.composableBuilder(
      column: $state.table.content,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get flag => $state.composableBuilder(
      column: $state.table.flag,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get status => $state.composableBuilder(
      column: $state.table.status,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get createdAt => $state.composableBuilder(
      column: $state.table.createdAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get updatedAt => $state.composableBuilder(
      column: $state.table.updatedAt,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$SchemaMigrationsTableInsertCompanionBuilder
    = SchemaMigrationsCompanion Function({
  required String version,
  Value<int> rowid,
});
typedef $$SchemaMigrationsTableUpdateCompanionBuilder
    = SchemaMigrationsCompanion Function({
  Value<String> version,
  Value<int> rowid,
});

class $$SchemaMigrationsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SchemaMigrationsTable,
    SchemaMigration,
    $$SchemaMigrationsTableFilterComposer,
    $$SchemaMigrationsTableOrderingComposer,
    $$SchemaMigrationsTableProcessedTableManager,
    $$SchemaMigrationsTableInsertCompanionBuilder,
    $$SchemaMigrationsTableUpdateCompanionBuilder> {
  $$SchemaMigrationsTableTableManager(
      _$AppDatabase db, $SchemaMigrationsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$SchemaMigrationsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$SchemaMigrationsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$SchemaMigrationsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> version = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SchemaMigrationsCompanion(
            version: version,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String version,
            Value<int> rowid = const Value.absent(),
          }) =>
              SchemaMigrationsCompanion.insert(
            version: version,
            rowid: rowid,
          ),
        ));
}

class $$SchemaMigrationsTableProcessedTableManager
    extends ProcessedTableManager<
        _$AppDatabase,
        $SchemaMigrationsTable,
        SchemaMigration,
        $$SchemaMigrationsTableFilterComposer,
        $$SchemaMigrationsTableOrderingComposer,
        $$SchemaMigrationsTableProcessedTableManager,
        $$SchemaMigrationsTableInsertCompanionBuilder,
        $$SchemaMigrationsTableUpdateCompanionBuilder> {
  $$SchemaMigrationsTableProcessedTableManager(super.$state);
}

class $$SchemaMigrationsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $SchemaMigrationsTable> {
  $$SchemaMigrationsTableFilterComposer(super.$state);
  ColumnFilters<String> get version => $state.composableBuilder(
      column: $state.table.version,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$SchemaMigrationsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $SchemaMigrationsTable> {
  $$SchemaMigrationsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get version => $state.composableBuilder(
      column: $state.table.version,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$TagsTableInsertCompanionBuilder = TagsCompanion Function({
  required String id,
  required String workspaceId,
  required String electricUserId,
  Value<String?> name,
  Value<int?> relatedNum,
  Value<int> rowid,
});
typedef $$TagsTableUpdateCompanionBuilder = TagsCompanion Function({
  Value<String> id,
  Value<String> workspaceId,
  Value<String> electricUserId,
  Value<String?> name,
  Value<int?> relatedNum,
  Value<int> rowid,
});

class $$TagsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableProcessedTableManager,
    $$TagsTableInsertCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder> {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$TagsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$TagsTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $$TagsTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> workspaceId = const Value.absent(),
            Value<String> electricUserId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int?> relatedNum = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TagsCompanion(
            id: id,
            workspaceId: workspaceId,
            electricUserId: electricUserId,
            name: name,
            relatedNum: relatedNum,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String workspaceId,
            required String electricUserId,
            Value<String?> name = const Value.absent(),
            Value<int?> relatedNum = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TagsCompanion.insert(
            id: id,
            workspaceId: workspaceId,
            electricUserId: electricUserId,
            name: name,
            relatedNum: relatedNum,
            rowid: rowid,
          ),
        ));
}

class $$TagsTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $TagsTable,
    Tag,
    $$TagsTableFilterComposer,
    $$TagsTableOrderingComposer,
    $$TagsTableProcessedTableManager,
    $$TagsTableInsertCompanionBuilder,
    $$TagsTableUpdateCompanionBuilder> {
  $$TagsTableProcessedTableManager(super.$state);
}

class $$TagsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get workspaceId => $state.composableBuilder(
      column: $state.table.workspaceId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get relatedNum => $state.composableBuilder(
      column: $state.table.relatedNum,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$TagsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get workspaceId => $state.composableBuilder(
      column: $state.table.workspaceId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get relatedNum => $state.composableBuilder(
      column: $state.table.relatedNum,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$WorkspacesTableInsertCompanionBuilder = WorkspacesCompanion Function({
  required String id,
  required String electricUserId,
  Value<String?> name,
  Value<int> rowid,
});
typedef $$WorkspacesTableUpdateCompanionBuilder = WorkspacesCompanion Function({
  Value<String> id,
  Value<String> electricUserId,
  Value<String?> name,
  Value<int> rowid,
});

class $$WorkspacesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WorkspacesTable,
    Workspace,
    $$WorkspacesTableFilterComposer,
    $$WorkspacesTableOrderingComposer,
    $$WorkspacesTableProcessedTableManager,
    $$WorkspacesTableInsertCompanionBuilder,
    $$WorkspacesTableUpdateCompanionBuilder> {
  $$WorkspacesTableTableManager(_$AppDatabase db, $WorkspacesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$WorkspacesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$WorkspacesTableOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) =>
              $$WorkspacesTableProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<String> id = const Value.absent(),
            Value<String> electricUserId = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkspacesCompanion(
            id: id,
            electricUserId: electricUserId,
            name: name,
            rowid: rowid,
          ),
          getInsertCompanionBuilder: ({
            required String id,
            required String electricUserId,
            Value<String?> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WorkspacesCompanion.insert(
            id: id,
            electricUserId: electricUserId,
            name: name,
            rowid: rowid,
          ),
        ));
}

class $$WorkspacesTableProcessedTableManager extends ProcessedTableManager<
    _$AppDatabase,
    $WorkspacesTable,
    Workspace,
    $$WorkspacesTableFilterComposer,
    $$WorkspacesTableOrderingComposer,
    $$WorkspacesTableProcessedTableManager,
    $$WorkspacesTableInsertCompanionBuilder,
    $$WorkspacesTableUpdateCompanionBuilder> {
  $$WorkspacesTableProcessedTableManager(super.$state);
}

class $$WorkspacesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableFilterComposer(super.$state);
  ColumnFilters<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $$WorkspacesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $WorkspacesTable> {
  $$WorkspacesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get electricUserId => $state.composableBuilder(
      column: $state.table.electricUserId,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$AppDatabaseManager {
  final _$AppDatabase _db;
  _$AppDatabaseManager(this._db);
  $$DraftTagsTableTableManager get draftTags =>
      $$DraftTagsTableTableManager(_db, _db.draftTags);
  $$DraftsTableTableManager get drafts =>
      $$DraftsTableTableManager(_db, _db.drafts);
  $$SchemaMigrationsTableTableManager get schemaMigrations =>
      $$SchemaMigrationsTableTableManager(_db, _db.schemaMigrations);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$WorkspacesTableTableManager get workspaces =>
      $$WorkspacesTableTableManager(_db, _db.workspaces);
}
