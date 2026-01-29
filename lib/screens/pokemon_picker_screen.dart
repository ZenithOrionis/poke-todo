import 'package:flutter/material.dart';

class PokemonPicker extends StatefulWidget {
  const PokemonPicker({super.key});

  @override
  _PokemonPickerState createState() => _PokemonPickerState();
}

class _PokemonPickerState extends State<PokemonPicker> {
  final pokeService = PokeApiService();
  List<Pokemon> _list = [];

  @override
  void initState() {
    super.initState();
    pokeService.getPokemonList(limit: 100).then((value) {
      setState(() => _list = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pick a Pokemon')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3),
        itemCount: _list.length,
        itemBuilder: (context, i) {
          final p = _list[i];
          return GestureDetector(
            onTap: () => Navigator.pop(context, p.name),
            child: Column(
              children: [
                Image.network(p.spriteUrl),
                Text(p.name),
              ],
            ),
          );
        },
      ),
    );
  }
}
