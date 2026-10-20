// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MakeupNotesTable extends MakeupNotes
    with TableInfo<$MakeupNotesTable, MakeupNoteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MakeupNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _makeupIdMeta = const VerificationMeta(
    'makeupId',
  );
  @override
  late final GeneratedColumn<int> makeupId = GeneratedColumn<int>(
    'makeup_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pendingSyncMeta = const VerificationMeta(
    'pendingSync',
  );
  @override
  late final GeneratedColumn<bool> pendingSync = GeneratedColumn<bool>(
    'pending_sync',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pending_sync" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    makeupId,
    note,
    rating,
    updatedAt,
    pendingSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'makeup_notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<MakeupNoteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('makeup_id')) {
      context.handle(
        _makeupIdMeta,
        makeupId.isAcceptableOrUnknown(data['makeup_id']!, _makeupIdMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    } else if (isInserting) {
      context.missing(_noteMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('pending_sync')) {
      context.handle(
        _pendingSyncMeta,
        pendingSync.isAcceptableOrUnknown(
          data['pending_sync']!,
          _pendingSyncMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {makeupId};
  @override
  MakeupNoteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MakeupNoteRow(
      makeupId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}makeup_id'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      pendingSync: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pending_sync'],
      )!,
    );
  }

  @override
  $MakeupNotesTable createAlias(String alias) {
    return $MakeupNotesTable(attachedDatabase, alias);
  }
}

class MakeupNoteRow extends DataClass implements Insertable<MakeupNoteRow> {
  final int makeupId;
  final String note;
  final int rating;
  final DateTime updatedAt;
  final bool pendingSync;
  const MakeupNoteRow({
    required this.makeupId,
    required this.note,
    required this.rating,
    required this.updatedAt,
    required this.pendingSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['makeup_id'] = Variable<int>(makeupId);
    map['note'] = Variable<String>(note);
    map['rating'] = Variable<int>(rating);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['pending_sync'] = Variable<bool>(pendingSync);
    return map;
  }

  MakeupNotesCompanion toCompanion(bool nullToAbsent) {
    return MakeupNotesCompanion(
      makeupId: Value(makeupId),
      note: Value(note),
      rating: Value(rating),
      updatedAt: Value(updatedAt),
      pendingSync: Value(pendingSync),
    );
  }

  factory MakeupNoteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MakeupNoteRow(
      makeupId: serializer.fromJson<int>(json['makeupId']),
      note: serializer.fromJson<String>(json['note']),
      rating: serializer.fromJson<int>(json['rating']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      pendingSync: serializer.fromJson<bool>(json['pendingSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'makeupId': serializer.toJson<int>(makeupId),
      'note': serializer.toJson<String>(note),
      'rating': serializer.toJson<int>(rating),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'pendingSync': serializer.toJson<bool>(pendingSync),
    };
  }

  MakeupNoteRow copyWith({
    int? makeupId,
    String? note,
    int? rating,
    DateTime? updatedAt,
    bool? pendingSync,
  }) => MakeupNoteRow(
    makeupId: makeupId ?? this.makeupId,
    note: note ?? this.note,
    rating: rating ?? this.rating,
    updatedAt: updatedAt ?? this.updatedAt,
    pendingSync: pendingSync ?? this.pendingSync,
  );
  MakeupNoteRow copyWithCompanion(MakeupNotesCompanion data) {
    return MakeupNoteRow(
      makeupId: data.makeupId.present ? data.makeupId.value : this.makeupId,
      note: data.note.present ? data.note.value : this.note,
      rating: data.rating.present ? data.rating.value : this.rating,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      pendingSync: data.pendingSync.present
          ? data.pendingSync.value
          : this.pendingSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MakeupNoteRow(')
          ..write('makeupId: $makeupId, ')
          ..write('note: $note, ')
          ..write('rating: $rating, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(makeupId, note, rating, updatedAt, pendingSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MakeupNoteRow &&
          other.makeupId == this.makeupId &&
          other.note == this.note &&
          other.rating == this.rating &&
          other.updatedAt == this.updatedAt &&
          other.pendingSync == this.pendingSync);
}

class MakeupNotesCompanion extends UpdateCompanion<MakeupNoteRow> {
  final Value<int> makeupId;
  final Value<String> note;
  final Value<int> rating;
  final Value<DateTime> updatedAt;
  final Value<bool> pendingSync;
  const MakeupNotesCompanion({
    this.makeupId = const Value.absent(),
    this.note = const Value.absent(),
    this.rating = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.pendingSync = const Value.absent(),
  });
  MakeupNotesCompanion.insert({
    this.makeupId = const Value.absent(),
    required String note,
    required int rating,
    required DateTime updatedAt,
    this.pendingSync = const Value.absent(),
  }) : note = Value(note),
       rating = Value(rating),
       updatedAt = Value(updatedAt);
  static Insertable<MakeupNoteRow> custom({
    Expression<int>? makeupId,
    Expression<String>? note,
    Expression<int>? rating,
    Expression<DateTime>? updatedAt,
    Expression<bool>? pendingSync,
  }) {
    return RawValuesInsertable({
      if (makeupId != null) 'makeup_id': makeupId,
      if (note != null) 'note': note,
      if (rating != null) 'rating': rating,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (pendingSync != null) 'pending_sync': pendingSync,
    });
  }

  MakeupNotesCompanion copyWith({
    Value<int>? makeupId,
    Value<String>? note,
    Value<int>? rating,
    Value<DateTime>? updatedAt,
    Value<bool>? pendingSync,
  }) {
    return MakeupNotesCompanion(
      makeupId: makeupId ?? this.makeupId,
      note: note ?? this.note,
      rating: rating ?? this.rating,
      updatedAt: updatedAt ?? this.updatedAt,
      pendingSync: pendingSync ?? this.pendingSync,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (makeupId.present) {
      map['makeup_id'] = Variable<int>(makeupId.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (pendingSync.present) {
      map['pending_sync'] = Variable<bool>(pendingSync.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MakeupNotesCompanion(')
          ..write('makeupId: $makeupId, ')
          ..write('note: $note, ')
          ..write('rating: $rating, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('pendingSync: $pendingSync')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MakeupNotesTable makeupNotes = $MakeupNotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [makeupNotes];
}

typedef $$MakeupNotesTableCreateCompanionBuilder =
    MakeupNotesCompanion Function({
      Value<int> makeupId,
      required String note,
      required int rating,
      required DateTime updatedAt,
      Value<bool> pendingSync,
    });
typedef $$MakeupNotesTableUpdateCompanionBuilder =
    MakeupNotesCompanion Function({
      Value<int> makeupId,
      Value<String> note,
      Value<int> rating,
      Value<DateTime> updatedAt,
      Value<bool> pendingSync,
    });

class $$MakeupNotesTableFilterComposer
    extends Composer<_$AppDatabase, $MakeupNotesTable> {
  $$MakeupNotesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get makeupId => $composableBuilder(
    column: $table.makeupId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MakeupNotesTableOrderingComposer
    extends Composer<_$AppDatabase, $MakeupNotesTable> {
  $$MakeupNotesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get makeupId => $composableBuilder(
    column: $table.makeupId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MakeupNotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MakeupNotesTable> {
  $$MakeupNotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get makeupId =>
      $composableBuilder(column: $table.makeupId, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get pendingSync => $composableBuilder(
    column: $table.pendingSync,
    builder: (column) => column,
  );
}

class $$MakeupNotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MakeupNotesTable,
          MakeupNoteRow,
          $$MakeupNotesTableFilterComposer,
          $$MakeupNotesTableOrderingComposer,
          $$MakeupNotesTableAnnotationComposer,
          $$MakeupNotesTableCreateCompanionBuilder,
          $$MakeupNotesTableUpdateCompanionBuilder,
          (
            MakeupNoteRow,
            BaseReferences<_$AppDatabase, $MakeupNotesTable, MakeupNoteRow>,
          ),
          MakeupNoteRow,
          PrefetchHooks Function()
        > {
  $$MakeupNotesTableTableManager(_$AppDatabase db, $MakeupNotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MakeupNotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MakeupNotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MakeupNotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> makeupId = const Value.absent(),
                Value<String> note = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> pendingSync = const Value.absent(),
              }) => MakeupNotesCompanion(
                makeupId: makeupId,
                note: note,
                rating: rating,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
              ),
          createCompanionCallback:
              ({
                Value<int> makeupId = const Value.absent(),
                required String note,
                required int rating,
                required DateTime updatedAt,
                Value<bool> pendingSync = const Value.absent(),
              }) => MakeupNotesCompanion.insert(
                makeupId: makeupId,
                note: note,
                rating: rating,
                updatedAt: updatedAt,
                pendingSync: pendingSync,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MakeupNotesTable, MakeupNoteRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $MakeupNotesTable,
                    MakeupNoteRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MakeupNotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MakeupNotesTable,
      MakeupNoteRow,
      $$MakeupNotesTableFilterComposer,
      $$MakeupNotesTableOrderingComposer,
      $$MakeupNotesTableAnnotationComposer,
      $$MakeupNotesTableCreateCompanionBuilder,
      $$MakeupNotesTableUpdateCompanionBuilder,
      (
        MakeupNoteRow,
        BaseReferences<_$AppDatabase, $MakeupNotesTable, MakeupNoteRow>,
      ),
      MakeupNoteRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MakeupNotesTableTableManager get makeupNotes =>
      $$MakeupNotesTableTableManager(_db, _db.makeupNotes);
}
