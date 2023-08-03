class Versiculo {
  final String? texto;
  final String livro;
  final int capitulo;
  final int numero;

  Versiculo({
    required this.texto,
    required this.livro,
    required this.capitulo,
    required this.numero,
  });

  factory Versiculo.fromJson(Map<String, dynamic> json) {
    return Versiculo(
      texto: json['text'] as String?,
      livro: json['book']['name'] as String, // Corrigimos o acesso à propriedade "name"
      capitulo: int.parse(json['chapter'] as String),
      numero: json['number'] as int,
    );
  }
}

