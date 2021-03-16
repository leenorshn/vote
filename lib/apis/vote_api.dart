import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vote/models/vote.dart';

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

  Future<bool> hasVotesCP() async {
    var etudiantId = _firebaseAuth.currentUser.uid;
    var ttt = await _firestore.collection("votes_CP").doc(etudiantId).get();
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
    await _firestore
        .collection("candidats")
        .doc(matriculeCandidat)
        .collection("votes")
        .doc(etudiantId)
        .set({"uid": etudiantId});
  }

  Future voterVicePresident(matriculeCandidat) async {
    var etudiantId = _firebaseAuth.currentUser.uid;
    await _firestore
        .collection("votes_vice_president")
        .doc(etudiantId)
        .set({"uid": etudiantId, "candidat": matriculeCandidat});
    await _firestore
        .collection("candidats")
        .doc(matriculeCandidat)
        .collection("votes")
        .doc(etudiantId)
        .set({"uid": etudiantId});
  }

  Future voterCP(matriculeCandidat) async {
    var etudiantId = _firebaseAuth.currentUser.uid;
    await _firestore
        .collection("votes_CP")
        .doc(etudiantId)
        .set({"uid": etudiantId, "candidat": matriculeCandidat});
    await _firestore
        .collection("candidats")
        .doc(matriculeCandidat)
        .collection("votes")
        .doc(etudiantId)
        .set({"uid": etudiantId});
  }

  Future voterCPA(matriculeCandidat) async {
    var etudiantId = _firebaseAuth.currentUser.uid;
    await _firestore
        .collection("votes_CPA")
        .doc(etudiantId)
        .set({"uid": etudiantId, "candidat": matriculeCandidat});
    await _firestore
        .collection("candidats")
        .doc(matriculeCandidat)
        .collection("votes")
        .doc(etudiantId)
        .set({"uid": etudiantId});
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

  Stream<int> getAllVotesCP() {
    return _firestore
        .collection("votes_CP")
        .snapshots()
        .map((event) => event.docs.length);
  }

  Stream<int> getAllVotesCPA() {
    return _firestore
        .collection("votes_CPA")
        .snapshots()
        .map((event) => event.docs.length);
  }

  Future<int> getCandidatVotes(matriculeCandidat) async {
    var t = await _firestore
        .collection("candidats")
        .doc(matriculeCandidat)
        .collection("votes")
        .get();
    return t.docs.length;
  }
}
