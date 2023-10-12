import 'dart:math';

import 'package:arquitetura_mvc/app/controllers/api_controller.dart';
import 'package:arquitetura_mvc/app/modules/Biblia_model.dart';
import 'package:arquitetura_mvc/styles/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/versiculo.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  BibliaController bibliaController = BibliaController();
  late Future<VersiculosResponse> dados;
  Random random = Random();
  int imagemEscolhida = 1;
  int? capitulo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dados = bibliaController.pegarVersiculosDaApi();
    imagemEscolhida = random.nextInt(3) + 1;
  }

  @override
  Widget build(BuildContext context) {
    List versos = [];

    return Scaffold(
      backgroundColor: Color.fromARGB(207, 73, 72, 72),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Provérbio do dia 📖"),
        backgroundColor: const Color.fromARGB(255, 155, 200, 143),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img$imagemEscolhida.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.05,              
              child: FutureBuilder(
                future: dados,
                builder: (BuildContext context,
                    AsyncSnapshot<VersiculosResponse> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Enquanto os dados estão sendo carregados
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Se houve um erro ao carregar os dados
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else {
                    // Quando os dados são carregados com sucesso
                    VersiculosResponse dados = snapshot.data!;
                    int capitulo = dados.capituloEscolhido;
                    List<String> range = [];
                    String texto = "";
                    List<String> versiculosPermitidos = [];

                    var listaDeVersiculosPraMostrar =
                        dados.versiculosEscolhidos[0].split(",");

                    // print("Versiculos texto: $versiculosPermitidos");

                    if (listaDeVersiculosPraMostrar.length > 1) {
                      range.add(listaDeVersiculosPraMostrar[0]);
                      range.add(listaDeVersiculosPraMostrar[
                          listaDeVersiculosPraMostrar.length - 1]);
                      texto = "Provérbio $capitulo : ${range[0]}-${range[1]}";
                    } else {
                      texto =
                          "Provérbio $capitulo : ${dados.versiculosEscolhidos[0]}";
                    }

                    return Text(
                      "$texto",
                      style: AppStyles.estiloTitulo,
                      textAlign: TextAlign.center,
                    );
                  }
                },
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      dados = bibliaController.pegarVersiculosDaApi();
                      print("Os versos são: $versos");
                      setState(() {});
                    },
                    child: const Text('Buscar Versículo Aleatório'),
                  ),
                  Container(
                    child: FutureBuilder(
                      future: dados,
                      builder: (BuildContext context,
                          AsyncSnapshot<VersiculosResponse> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // Enquanto os dados estão sendo carregados
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          // Se houve um erro ao carregar os dados
                          return Center(child: Text('Erro: ${snapshot.error}'));
                        } else {
                          // Quando os dados são carregados com sucesso
                          VersiculosResponse dados = snapshot.data!;
                          List<String> versiculosEscolhidos =
                              dados.versiculosEscolhidos;

                          // debugPrint("versiculo view: $versiculosEscolhidos");

                          List<String> versiculosPermitidos = [];

                          for (String item in versiculosEscolhidos) {
                            List<String> numeros =
                                item.split(',').map((e) => e.trim()).toList();
                            versiculosPermitidos.addAll(numeros);
                          }

                          String capitalizeFirstLetter(String text) {
                            if (text == null || text.isEmpty) {
                              return text;
                            }
                            return text[0].toUpperCase() + text.substring(1);
                          }

                          return Container(
                            // padding: EdgeInsets.all(20.0),
                            margin: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            height: 300,
                            child: ListView.builder(
                              itemCount: dados.biblia.verses.length,
                              itemBuilder: (BuildContext context, int index) {
                                Verses dado2 = dados.biblia.verses[index];

                                // Verifica se o número do versículo está na lista de versículos permitidos
                                if (versiculosPermitidos
                                    .contains(dado2.number.toString())) {
                                  return ListTile(
                                    title: Text(
                                      "${dado2.number} - ${capitalizeFirstLetter(dado2.text)}",
                                      style: AppStyles.estiloLeitor,
                                    ),
                                  );
                                } else {
                                  // Se não estiver na lista de versículos permitidos, retorna um widget vazio
                                  return const SizedBox.shrink();
                                }
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
