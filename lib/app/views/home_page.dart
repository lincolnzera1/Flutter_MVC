import 'package:arquitetura_mvc/app/controllers/api_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Text("Home page"),            
          ],
        ),
      ),
    );
  }
}
