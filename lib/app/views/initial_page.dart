import 'package:arquitetura_mvc/app/controllers/api_controller.dart';
import 'package:arquitetura_mvc/app/controllers/metodos.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {


    final BibliaController bibleController = Get.put(BibliaController());
    var versos = [].obs;

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
            image: AssetImage("assets/img${Funcoes.numeroAleatorio()}.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  versos.value = await bibleController.pegarVersiculos();
                  print("Os versos são: $versos");
                },
                child: const Text('Buscar Versículo Aleatório'),
              ),
              Obx(() => Text("${bibleController.o}")),
            ],
          ), 
        ),
      ),
    );
  }
}
