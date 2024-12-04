import 'package:challenges/sqflite/models/personne.dart';
import 'package:challenges/sqflite/services/personne_provider.dart';
import 'package:flutter/material.dart';

const String title = 'Flutter Sqlite';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final personneProvider = PersonneProvider();
  Personne? personne;
  @override
  void initState() {
    setDatabase();
    super.initState();
  }

  @override
  void dispose() async {
    await personneProvider.close();
    super.dispose();
  }

  void setDatabase() async {
    personneProvider.db;
    retrievePersonne();
  }

  void savePersonne() async {
    final p = Personne(nom: 'Kana', prenom: 'Wilfried', age: 23);
    final result = await personneProvider.insert(p);
    retrievePersonne(result);
  }

  retrievePersonne([int? id]) async {
    if (id == null) {
      personne = await personneProvider.query2();
    } else {
      personne = await personneProvider.query(id);
    }

    setState(() {});
  }

  void deletePersonne() async {
    if (personne != null) {
      await personneProvider.delete(int.parse(personne!.id!));
    }
    setState(() {
      personne = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Personne Details',
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            width: size.width * 0.9,
            height: size.height * 0.4,
            color: Colors.deepPurple,
            child: Column(
              children: [
                CustomLine(
                  entry: 'id',
                  output: personne == null ? '' : personne!.id,
                ),
                CustomLine(
                  entry: 'nom',
                  output: personne == null ? '' : personne!.nom,
                ),
                CustomLine(
                  entry: 'prenom',
                  output: personne == null ? '' : personne!.prenom,
                ),
                CustomLine(
                  entry: 'age',
                  output: personne == null ? '' : personne!.age,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: savePersonne,
                child: const Icon(Icons.save),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: deletePersonne,
                child: const Icon(Icons.remove),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomLine extends StatelessWidget {
  const CustomLine({
    super.key,
    required this.entry,
    this.output,
  });

  final String entry;
  final dynamic output;
  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 14, color: Colors.white);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            entry,
            style: textStyle,
          ),
          Text(
            output.toString(),
            style: textStyle,
          ),
        ],
      ),
    );
  }
}
