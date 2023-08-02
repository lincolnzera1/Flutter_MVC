import 'package:arquitetura_mvc/app/controllers/api_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final APIController _bibleController = Get.put(APIController());
    final APIController contador = Get.put(APIController());

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Initial page"),
            ElevatedButton(
              onPressed: () async {
                try {
                  final randomVerse =
                      await _bibleController.fetchRandomVerse('nvi', 'pv');
                  print(_bibleController.verseText
                      .value); // Aqui você pode fazer o que desejar com a resposta da requisição
                } catch (e) {
                  print('Erro: $e');
                }
              },
              child: Text('Buscar Versículo Aleatório'),
            ),
            ElevatedButton(
                onPressed: () {
                  contador.incrementar();
                },
                child: Text("Incrementar")),
            ElevatedButton(
                onPressed: () {
                  contador.decrementar();
                },
                child: Text("Decrementar")),
            Obx(() => Text("${_bibleController.verseText.value}")),
            Obx(() => Text("${contador.contador}")),
          ],
        ),
      ),
    );
  }
}
