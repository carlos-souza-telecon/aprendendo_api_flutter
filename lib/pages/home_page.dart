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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pesquisar Pokémon')),
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              _pokemonBloc.fetchByName('charmander');
            },
            child: const Text('PESQUISAR'),
          ),
          StreamBuilder(
            stream: _pokemonBloc.stream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Erro: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return const Text('Pesquisa um pokémon.');
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
          )
        ],
      ),
    );
  }
}
