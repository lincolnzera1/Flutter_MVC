import 'dart:convert';
import 'dart:math';
import 'package:arquitetura_mvc/app/modules/dadosVersiculo.dart';
import 'package:arquitetura_mvc/app/modules/versiculo.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BibliaController extends GetxController {
  final List<String> versiculos = [
    "1:7",
    "1:8-9",
    "1:10",
    "1:20-22",
    "1:23",
    "1:33",
  ];

  var lista = [].obs;
  var objeto = <DadosVersiculos>[].obs;

  @override
  void onInit() {
    pegarVersiculos();
    super.onInit();
  }

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

  Future<RxList<dynamic>> pegarVersiculos() async {
    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlRodSBBdWcgMDMgMjAyMyAxNzo1NjozMyBHTVQrMDAwMC56enpsaW5jb2xuMUBnbWFpbC5jb20iLCJpYXQiOjE2OTEwODUzOTN9.rn3LfIBxoMdOs8ZmR9NlxHQVAnijXC-qVePfEglFSug";
    Random random = Random();
    int numeroAleatorio = random.nextInt(versiculos.length);
    String versiculoAleatorio = versiculos[numeroAleatorio];
    // List<String> capituloEscolhido = versiculoAleatorio[0].split(":");
    List<String> encontrarVersiculo = versiculoAleatorio.split(":");
    List<String> versiculosEscolhidos = encontrarVersiculo[1].split('-');
    print(versiculosEscolhidos);
    RxList<dynamic> export = [].obs;
    objeto = <DadosVersiculos>[].obs;

    final response = await http.get(
        Uri.parse('https://www.abibliadigital.com.br/api/verses/nvi/pv/1/'),
        headers: {"Authorization": 'Bearer $token'});

    final String versos = "";

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final capituloEscolhido = data['chapter']['number'];
      final verses = List<Map<String, dynamic>>.from(data['verses']);

      /* final numbers = verses.map<int>((verse) => verse['number']).forEach((elemento) {
        if(versiculosEscolhidos.contains(elemento.toString())){
          print("$elemento está na lista");
        }else {
          // print("nada na lista: $elemento");
        }
      }); */
      verses.forEach((verse) {
        int verseNumber = verse['number'];
        if (versiculosEscolhidos.contains(verseNumber.toString())) {
          print('capitulo $verseNumber - ${verse['capitulo']}');
          export.add("$verseNumber - ${verse['text']}");

          objeto.add(DadosVersiculos(capituloEscolhido, "$verseNumber - ${verse['text']}"));
        }
      });
      // print('object: ${objeto}');

      // Lê o capitulo e os versiculos do objeto
      List<dynamic> capitulos =
          objeto.map((versiculo) => versiculo.capitulo).toList();

      List<dynamic> vers =
          objeto.map((versiculo) => versiculo.versiculos).toList();
      print("Capítulos: $capitulos, versiculos: $vers");

      lista.value = export;
      return objeto;
    } else {
      print('Failed to load verses');

      throw Exception("else da api");
    }
  }
}
