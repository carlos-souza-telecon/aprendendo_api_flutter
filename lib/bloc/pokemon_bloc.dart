import 'package:aprendendo_api_flutter/bloc/pokemon_api.dart';
import 'package:aprendendo_api_flutter/models/pokemon.dart';
import 'package:aprendendo_api_flutter/utils/bloc_response.dart';
import 'package:aprendendo_api_flutter/utils/simple_bloc.dart';

class PokemonBloc extends SimpleBloc<BlocResponse?> {
  fetchByName(String name) async {
    try {
      add(BlocResponse(loading: true));
      var result = await PokemonAPI.getPokemon(name);
      if (result == null) {
        addError('Pokémon não encontrado!');
      } else {
        var pokemon = Pokemon.fromJSON(result);
        add(BlocResponse(
          response: pokemon,
          loading: false,
        ));
      }
    } catch (e) {
      addError(e.toString());
    }
  }
}
