import 'package:arquitetura_mvc/app/controllers/api_controller.dart';
import 'package:arquitetura_mvc/app/modules/Biblia_model.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dados = bibliaController.pegarVersiculosDaApi();
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
            image: AssetImage("assets/img1.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
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
              FutureBuilder(
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
                    List<String> versiculosEscolhidos =
                        dados.versiculosEscolhidos;
                    List<Verses> todosOsVersos = dados.biblia.verses;

                    debugPrint("versiculo view: $versiculosEscolhidos");

                    List<String> versiculosPermitidos = [];

                    for (String item in versiculosEscolhidos) {
                      List<String> numeros =
                          item.split(',').map((e) => e.trim()).toList();
                      versiculosPermitidos.addAll(numeros);
                    }

                    /* for (int i = 0; i < versiculosEscolhidos.length; i++) {
                      // print("verso: ${todosOsVersos[i].text}");

                      if (versiculosEscolhidos
                          .contains(todosOsVersos[i].number.toString())) {
                        print(todosOsVersos[i].number.toString());
                        versiculosPermitidos
                            .add(todosOsVersos[i].number.toString());
                      }

                      print("versiculos permitidos ate agora:");
                    } */

                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: dados.biblia.verses.length,
                        itemBuilder: (BuildContext context, int index) {
                          Verses dado2 = dados.biblia.verses[index];

                          // Verifica se o número do versículo está na lista de versículos permitidos
                          if (versiculosPermitidos
                              .contains(dado2.number.toString())) {
                            return Card(
                              child: ListTile(
                                title: Text("${dado2.number} - ${dado2.text}"),
                              ),
                            );
                          } else {
                            // Se não estiver na lista de versículos permitidos, retorna um widget vazio
                            return SizedBox.shrink();
                          }
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
