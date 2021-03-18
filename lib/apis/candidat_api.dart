import "dart:async";

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/models/candidat.dart';

class CandidatApi {
  final FirebaseFirestore _firestore;

  CandidatApi() : _firestore = FirebaseFirestore.instance;

  Stream<List<Candidat>> getCandidatPresident() {
    return _firestore
        .collection("candidats")
        .where("type", isEqualTo: "PRESIDENT")
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) {
        return Candidat.fromJson(doc.data());
      }).toList();
    });
  }

  Stream<List<Candidat>> getCandidatVicePresident() {
    return _firestore
        .collection("candidats")
        .where("type", isEqualTo: "VICE_PRESIDENT")
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) {
        return Candidat.fromJson(doc.data());
      }).toList();
    });
  }
}
