import 'package:challenges/hive/boxes.dart';
import 'package:challenges/sqflite/models/personne.dart';
import 'package:flutter/material.dart';

const String title = 'Flutter Hive';

class HiveHome extends StatefulWidget {
  const HiveHome({super.key});

  @override
  State<HiveHome> createState() => _HiveHomeState();
}

class _HiveHomeState extends State<HiveHome> {
  Personne? person;

  @override
  void initState() {
    setState(() {
      person = personBox.get('me', defaultValue: null);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
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
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                CustomLine(
                  entry: 'id',
                  output: person == null ? '' : person!.id,
                ),
                CustomLine(
                  entry: 'nom',
                  output: person == null ? '' : person!.nom,
                ),
                CustomLine(
                  entry: 'prenom',
                  output: person == null ? '' : person!.prenom,
                ),
                CustomLine(
                  entry: 'age',
                  output: person == null ? '' : person!.age,
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
                onPressed: () async {
                  if (person == null) {
                    await personBox.put(
                      'you',
                      Personne(
                          id: DateTime.now().millisecondsSinceEpoch.toString(),
                          nom: 'Kana',
                          prenom: 'Hariel',
                          age: 23),
                    );

                    setState(() {
                      person = personBox.get('you');
                    });
                  } else {
                    print('Result: ${personBox.length}');
                  }
                },
                child: const Icon(Icons.save),
              ),
              const SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  personBox.clear();
                  person = null;
                  setState(() {});
                },
                child: const Icon(Icons.remove),
              ),
            ],
          ),
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
