import 'package:drift/drift.dart';
import 'package:movies/local/app_database.dart';
import 'package:movies/models/makeup_note.dart';

class MakeupNoteLocalDataSource {
  final AppDatabase db;

  MakeupNoteLocalDataSource(this.db);

  MakeupNote _toDomain(MakeupNoteRow row) {
    return MakeupNote(
      makeupId: row.makeupId,
      note: row.note,
      rating: row.rating,
      updatedAt: row.updatedAt,
      pendingSync: row.pendingSync,
    );
  }

  // recuperar una nota
  Future<MakeupNote?> getNoteForMakeup(int makeupId) async {
    final query = db.select(db.makeupNotes)
      ..where((t) => t.makeupId.equals(makeupId));

    final row = await query.getSingleOrNull();
    return row == null ? null : _toDomain(row);
  }

  // insertar o actualizar: un unico registro por producto
  Future<void> saveNote(MakeupNote note) async {
    await db.into(db.makeupNotes).insertOnConflictUpdate(
          MakeupNotesCompanion.insert(
            makeupId: Value(note.makeupId),
            note: note.note,
            rating: note.rating,
            updatedAt: note.updatedAt,
            pendingSync: Value(note.pendingSync),
          ),
        );
  }

  // registros que aun no se han enviado a Firestore
  Future<List<MakeupNote>> getPendingNotes() async {
    final query = db.select(db.makeupNotes)
      ..where((t) => t.pendingSync.equals(true));
    final rows = await query.get();
    return rows.map(_toDomain).toList();
  }

  Future<void> markSynced(int makeupId) async {
    await (db.update(db.makeupNotes)
          ..where((t) => t.makeupId.equals(makeupId)))
        .write(const MakeupNotesCompanion(pendingSync: Value(false)));
  }
}
