import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VoteApi {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  VoteApi()
      : _firestore = FirebaseFirestore.instance,
        _firebaseAuth = FirebaseAuth.instance;

  Future<bool> hasVotesPresident() async {
    var etudiantId = _firebaseAuth.currentUser.uid;
    var ttt =
        await _firestore.collection("votes_president").doc(etudiantId).get();
    if (ttt.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hasVotesVicePresident() async {
    var etudiantId = _firebaseAuth.currentUser.uid;
    var ttt = await _firestore
        .collection("votes_vice_president")
        .doc(etudiantId)
        .get();
    if (ttt.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future voter(matriculeCandidat) async {
    var etudiantId = _firebaseAuth.currentUser.uid;
    await _firestore
        .collection("votes_president")
        .doc(etudiantId)
        .set({"uid": etudiantId, "candidat": matriculeCandidat});
  }

  Future voterVicePresident(matriculeCandidat) async {
    var etudiantId = _firebaseAuth.currentUser.uid;
    await _firestore
        .collection("votes_vice_president")
        .doc(etudiantId)
        .set({"uid": etudiantId, "candidat": matriculeCandidat});
  }

  Stream<int> getAllVotesPresident() {
    return _firestore
        .collection("votes_president")
        .snapshots()
        .map((event) => event.docs.length);
  }

  Stream<int> getAllVotesVicePresident() {
    return _firestore
        .collection("votes_vice_president")
        .snapshots()
        .map((event) => event.docs.length);
  }

  Future<int> getCandidatVotes(matriculeCandidat) async {
    var t = await _firestore
        .collection("votes_president")
        .where("candidat", isEqualTo: matriculeCandidat)
        .get();
    return t.docs.length;
  }

  Future<int> getCandidatVotesVice(matriculeCandidat) async {
    var t = await _firestore
        .collection("votes_vice_president")
        .where("candidat", isEqualTo: matriculeCandidat)
        .get();
    return t.docs.length;
  }
}
