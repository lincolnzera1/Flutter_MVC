import 'package:arquitetura_mvc/app/controllers/api_controller.dart';
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
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Initial page"),
            ElevatedButton(
              onPressed: () async {
                versos = await bibleController.pegarVersiculos();
                print("Os versos são: $versos");
              },
              child: const Text('Buscar Versículo Aleatório'),
            ),
            Obx(() => Text("${versos}")),
          ],
        ), 
      ),
    );
  }
}
