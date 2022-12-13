import 'package:aprendendo_api_flutter/bloc/pokemon_bloc.dart';
import 'package:aprendendo_api_flutter/models/pokemon.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PokemonBloc _pokemonBloc = PokemonBloc();
  final TextEditingController _textNome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesquisar Pokémon')),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textNome,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nome do Pokémon',
              ),
              onSubmitted: (value) {
                _pokemonBloc.fetchByName(value.toLowerCase());
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () {
                _pokemonBloc.fetchByName(_textNome.text.toLowerCase());
              },
              child: const Text('PESQUISAR'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: StreamBuilder(
              stream: _pokemonBloc.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: Text('Pesquisa um pokémon.'));
                } else {
                  var response = snapshot.data!;
                  if (response.loading) {
                    return const Center(
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  var pokemon = response.response as Pokemon;
                  return ListTile(
                    leading: Chip(label: Text('${pokemon.id}')),
                    title: Text('${pokemon.nome}'),
                    subtitle: Text('${pokemon.altura}m - ${pokemon.peso}kg'),
                    trailing: Image.network('${pokemon.imagem}'),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
