const String tableName = 'Personne';
const String colonneId = 'id';
const String colonneNom = 'nom';
const String colonnePrenom = 'prenom';
const String colonneAge = 'age';

class Personne {
  String? id;
  String nom;
  String prenom;
  int age;
  Personne(
      {this.id, required this.nom, required this.prenom, required this.age});
  factory Personne.fromMap(Map<String, dynamic> map) {
    return Personne(
        id: map[colonneId].toString(),
        nom: map[colonneNom],
        prenom: map[colonnePrenom],
        age: map[colonneAge]);
  }

  Map<String, dynamic> toMap() {
    return {
      colonneId: id,
      colonneAge: age,
      colonneNom: nom,
      colonnePrenom: prenom,
    };
  }
}
