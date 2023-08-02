
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class APIController extends GetxController{

  RxString verseText = "".obs;

  Future<void> fetchRandomVerse(String version, String abbrev) async {
    String url = 'https://www.abibliadigital.com.br/api/verses/$version/$abbrev/random';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        verseText.value = jsonData["text"];
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
