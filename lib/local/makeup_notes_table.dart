import 'package:drift/drift.dart';

@DataClassName('MakeupNoteRow')
class MakeupNotes extends Table {
  IntColumn get makeupId => integer()();
  TextColumn get note => text()();
  IntColumn get rating => integer()();
  DateTimeColumn get updatedAt => dateTime()();
  // pendiente de sincronizar
  BoolColumn get pendingSync =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {makeupId};
}
