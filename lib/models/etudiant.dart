class Etudiant {
  String name;
  String matricule;
  String promotion;
  String faculte;
  String uid;

  Etudiant({this.name, this.matricule, this.promotion, this.faculte, this.uid});

  Etudiant.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    matricule = json['matricule'];
    promotion = json['promotion'];
    faculte = json['faculte'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['matricule'] = this.matricule;
    data['promotion'] = this.promotion;
    data['faculte'] = this.faculte;
    data['uid'] = this.uid;
    return data;
  }
}
