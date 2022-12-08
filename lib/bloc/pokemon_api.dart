import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class PokemonAPI {
  static Future<Map?> getPokemon(String name) async {
    // url da requisicao: https://pokeapi.co/api/v2/pokemon/charmander
    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };
    String urlBase = 'pokeapi.co';
    String urlComplementar = '/api/v2/pokemon/$name';
    Map<String, String> queryParams = {};

    Uri uri = Uri.https(urlBase, urlComplementar, queryParams);
    var response = await http.get(uri, headers: headers);

    if (response.statusCode >= 400) {
      return null;
    }

    Map mapResponse = convert.json.decode(response.body);
    return mapResponse;
  }
}
