import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // ** Get note collection **
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  // ** Create : Add note **
  Future<DocumentReference<Object?>> createNote(
      String name, String desc) async {
    try {
      return await notes.add({
        'note': name,
        'description': desc,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      rethrow;
    }
  }

  // ** Read : Get all notes **
  Stream<QuerySnapshot> getNotes() {
    final notesStream =
        notes.orderBy('timestamp', descending: true).snapshots();

    return notesStream;
  }

  // ** Update : Update note **
  Future<void> updateNote(String id, String name, String desc) async {
    return await notes.doc(id).update({
      'note': name,
      'description': desc,
      'timestamp': Timestamp.now(),
    });
  }

  // ** Delete : Delete note **
  Future<void> deleteNote(String id) async {
    await notes.doc(id).delete();
  }

  // ** Search : Search note **
}
