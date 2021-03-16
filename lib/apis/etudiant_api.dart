import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/models/etudiant.dart';

class EtudiantApi {
  final FirebaseFirestore _firestore;

  EtudiantApi() : _firestore = FirebaseFirestore.instance;

  Future<Etudiant> getCurrentStudent(id) async {
    try {
      var doc = await _firestore.collection("electeurs").doc(id).get();
      return Etudiant.fromJson(doc.data());
    } catch (err) {
      throw Exception(err);
    }
  }
}
