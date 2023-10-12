import 'dart:convert';
import 'dart:math';
import 'package:arquitetura_mvc/app/modules/Biblia_model.dart';
import 'package:arquitetura_mvc/app/modules/versiculo.dart';
import 'package:http/http.dart' as http;

class BibliaController {
  final List<Map<String, dynamic>> versiculosEscolhidos = [
    {
      'capitulo': 1,
      'versiculos': ["7", "8-9", "10", "20-21-22", "23", "33"]
    },
    {
      'capitulo': 2,
      'versiculos': ["3", "15-16-17", "21"]
    },
    // Outros capítulos podem ser adicionados da mesma forma
  ];

  // var objeto = <DadosVersiculos>[].obs;

  Future<void> criarUsuario() async {
    final url = Uri.parse("https://www.abibliadigital.com.br/api/users");
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    final body = jsonEncode({
      "name": "Guilherme",
      "email": "zzzlincoln1@gmail.com",
      "password": "123456", // minimum size 6 digits
      "notifications":
          true // receive update emails from www.abibliadigital.com.br
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      print('Resposta da API: $responseData');
    } else {
      print('Erro na requisição POST. Status code: ${response.statusCode}');
    }
  }

  Future<VersiculosResponse> pegarVersiculosDaApi() async {
    Random random = Random();
    int capituloSorteado = random.nextInt(versiculosEscolhidos.length) + 1;
    var proverbio = versiculosEscolhidos[capituloSorteado - 1]['versiculos'];
    int sortearVersiculo = random.nextInt(proverbio.length) + 0;
    String versiculoSorteado = proverbio[sortearVersiculo];

    var listaDeVersiculosPraMostrar =
        versiculoSorteado.replaceAll("-", ",").split(", ");
    /* print('listaDeVersiculosPraMostrar: $listaDeVersiculosPraMostrar');

    print("Capitulo sorteado foi: $capituloSorteado");
    print("Versiculo sorteado foi: $versiculoSorteado");
    print("seus versiculos: $proverbio"); */

    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlRodSBBdWcgMDMgMjAyMyAxNzo1NjozMyBHTVQrMDAwMC56enpsaW5jb2xuMUBnbWFpbC5jb20iLCJpYXQiOjE2OTEwODUzOTN9.rn3LfIBxoMdOs8ZmR9NlxHQVAnijXC-qVePfEglFSug";

    final url =
        "https://www.abibliadigital.com.br/api/verses/nvi/pv/$capituloSorteado/";

    final response = await http
        .get(Uri.parse(url), headers: {"Authorization": 'Bearer $token'});

    try {
      var result = json.decode(response.body);
      Biblia biblia = Biblia.fromMap(result);

      return VersiculosResponse(
          biblia: biblia, 
          versiculosEscolhidos: listaDeVersiculosPraMostrar,
          capituloEscolhido: capituloSorteado
          );
    } catch (e) {
      throw Exception("Não foi possível pegar os dados: $e");
    }
  }
}
