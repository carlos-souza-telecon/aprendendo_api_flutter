class Pokemon {
  int? id;
  String? nome;
  double? peso;
  double? altura;
  String? imagem;

  Pokemon({
    this.id,
    this.nome,
    this.peso,
    this.altura,
    this.imagem =
        'https://toppng.com/public/uploads/preview/pokeball-11530983148cdujwkohwx.png',
  });

  static Pokemon fromJSON(Map<dynamic, dynamic> json) {
    return Pokemon(
      nome: json['name'].toString().toUpperCase(),
      id: json['id'],
      peso: (json['weight'] as int) / 10,
      altura: (json['height'] as int) / 10,
      imagem: json['sprites']['other']['official-artwork']['front_default'],
    );
  }
}
