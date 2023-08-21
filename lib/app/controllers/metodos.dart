import 'dart:math';
import 'package:get/get.dart';
import 'api_controller.dart';

class Funcoes {
  static int numeroAleatorio() {
    Random random = Random();
    int numeroAleatorio = random.nextInt(3) + 1;
    // print("Número aleatório entre 1 e 3: $numeroAleatorio");

    return numeroAleatorio;
  }

  static Future<List<dynamic>> getVersiculos() async {
    final BibliaController bibleController = Get.put(BibliaController());
    return await bibleController.pegarVersiculos();
  }
}
