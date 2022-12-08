import 'package:aprendendo_api_flutter/bloc/pokemon_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Column colunaResultado = Column(
    children: [
      Text('Pesquise um pokémon'),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pesquisar Pokémon')),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () async {
              await pesquisarPokemon();
            },
            child: Text('PESQUISAR'),
          ),
          colunaResultado,
        ],
      ),
    );
  }

  Future<void> pesquisarPokemon() async {
    var pokemon = await PokemonAPI.getPokemon('charmander');
    print(pokemon);
    if (pokemon == null) {
      print('🐲 Não foi possível encontrar este Pokémon');
      setState(() {
        colunaResultado = Column(
          children: [
            Text('Não foi possível encontrar este Pokémon!'),
          ],
        );
      });
    } else {
      // name, id, height / 10, weight / 10
      print('🐲 Nome: ${pokemon['name']}');
      print('🐲 Id: ${pokemon['id']}');
      print('🐲 Altura: ${(pokemon['height'] as int) / 10}m');
      print('🐲 Peso: ${(pokemon['weight'] as int) / 10}kg');
      setState(() {
        var nome = pokemon['name'].toString().toUpperCase();
        var id = pokemon['id'];
        var peso = (pokemon['weight'] as int) / 10;
        var altura = (pokemon['height'] as int) / 10;
        colunaResultado = Column(
          children: [
            ListTile(
              leading: Chip(label: Text('$id')),
              title: Text('$nome'),
              subtitle: Text('${altura}m - ${peso}kg'),
            ),
          ],
        );
      });
    }
  }
}
