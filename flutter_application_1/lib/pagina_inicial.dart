import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaginaInicial extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return const Scaffold(
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'digite seu nome',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: "nome",
                labelText: 'Nome',
              ),
            ),
          ],
        ),
      )
    );
  }
}