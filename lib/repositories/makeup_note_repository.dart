import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies/local/makeup_note_local_data_source.dart';
import 'package:movies/models/makeup_note.dart';

/// Centraliza consulta local, guardado y sincronizacion.
/// La UI usa esta clase y no coordina Drift/Firebase directamente.
class MakeupNoteRepository {
  final MakeupNoteLocalDataSource _local;
  final FirebaseFirestore Function() _firestore;

  MakeupNoteRepository(this._local, {FirebaseFirestore Function()? firestore})
    : _firestore = firestore ?? (() => FirebaseFirestore.instance);

  Future<MakeupNote?> getNote(int makeupId) => _local.getNoteForMakeup(makeupId);

  /// Offline-first: guarda en Drift con pendingSync = true y luego intenta
  /// enviar a Firestore. Devuelve true si quedo sincronizado.
  Future<bool> saveNote({
    required int makeupId,
    required String note,
    required int rating,
  }) async {
    final local = MakeupNote(
      makeupId: makeupId,
      note: note,
      rating: rating,
      updatedAt: DateTime.now(),
      pendingSync: true,
    );
    await _local.saveNote(local);
    return _push(local);
  }

  /// Envia solo los registros con pendingSync == true.
  /// Devuelve cuantos se sincronizaron.
  Future<int> syncPending() async {
    final pending = await _local.getPendingNotes();
    var synced = 0;
    for (final note in pending) {
      if (await _push(note)) synced++;
    }
    return synced;
  }

  Future<bool> _push(MakeupNote note) async {
    try {
      // productId como id del documento: reenviar no duplica.
      await _firestore()
          .collection('makeup_notes')
          .doc(note.makeupId.toString())
          .set({
            'productId': note.makeupId,
            'note': note.note,
            'priority': note.rating,
            'updatedAt': note.updatedAt.toIso8601String(),
          })
          .timeout(const Duration(seconds: 10));
      await _local.markSynced(note.makeupId);
      return true;
    } catch (_) {
      // El registro local se conserva como pendiente.
      return false;
    }
  }
}
