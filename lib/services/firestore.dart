import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  // ** Get note collection **
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');

  // ** Get user id **
  User? get currentUser => FirebaseAuth.instance.currentUser;

  // ** Create : Add note **
  Future<DocumentReference<Object?>> createNote(
      String name, String desc) async {
    try {
      String? uid = currentUser?.uid;
      return await notes.add({
        'uid': uid,
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
  Future<void> updateNote(
      String id, String name, String desc) async {
    String? uid = currentUser?.uid;
    return await notes.doc(id).update({
      'uid': uid,
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
