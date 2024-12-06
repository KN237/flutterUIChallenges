import 'package:hive_ce_flutter/hive_flutter.dart';
part 'personne.g.dart';

const String tableName = 'Personne';
const String colonneId = 'id';
const String colonneNom = 'nom';
const String colonnePrenom = 'prenom';
const String colonneAge = 'age';

@HiveType(typeId: 0)
class Personne extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String nom;
  @HiveField(2)
  String prenom;
  @HiveField(3)
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
