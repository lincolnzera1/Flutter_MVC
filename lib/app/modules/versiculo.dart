import 'dart:convert';

import 'Biblia_model.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Versiculo {
  final String capitulo;
  final String versiculos;
  Versiculo({
    required this.capitulo,
    required this.versiculos,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'capitulo': capitulo,
      'versiculos': versiculos,
    };
  }

  factory Versiculo.fromMap(Map<String, dynamic> map) {
    return Versiculo(
      capitulo: map['capitulo'] as String,
      versiculos: map['versiculos'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Versiculo.fromJson(String source) =>
      Versiculo.fromMap(json.decode(source) as Map<String, dynamic>);
}

class VersiculosResponse {
  final Biblia biblia;
  final List<String> versiculosEscolhidos;
  final int capituloEscolhido;
  VersiculosResponse({
    required this.biblia,
    required this.versiculosEscolhidos,
    required this.capituloEscolhido,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'biblia': biblia.toMap(),
      'versiculosEscolhidos': versiculosEscolhidos,
      'capituloEscolhido': capituloEscolhido,
    };
  }

  factory VersiculosResponse.fromMap(Map<String, dynamic> map) {
    return VersiculosResponse(
        biblia: Biblia.fromMap(map['biblia'] as Map<String, dynamic>),
        capituloEscolhido: map['capituloEscolhido'] as int,
        versiculosEscolhidos: List<String>.from(
          (map['versiculosEscolhidos'] as List<String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory VersiculosResponse.fromJson(String source) =>
      VersiculosResponse.fromMap(json.decode(source) as Map<String, dynamic>);
}
