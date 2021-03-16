class Candidat {
  String name;
  String matricule;
  String promotion;
  String avatar;
  String slogan;
  String numero;
  String faculte;
  String type;
  String id;

  Candidat({
    this.name,
    this.matricule,
    this.promotion,
    this.avatar,
    this.slogan,
    this.numero,
    this.faculte,
    this.type,
    this.id,
  });

  Candidat.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    matricule = json['matricule'];
    promotion = json['promotion'];
    type = json['type'];
    avatar = json['avatar'];
    slogan = json['slogan'];
    numero = json['numero'];
    faculte = json['faculte'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['type'] = this.type;
    data['matricule'] = this.matricule;
    data['promotion'] = this.promotion;
    data['avatar'] = this.avatar;
    data['slogan'] = this.slogan;
    data['numero'] = this.numero;
    data['faculte'] = this.faculte;
    data['id'] = this.id;
    return data;
  }
}
