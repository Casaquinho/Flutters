import "package:flutter/material.dart";

class Doguinhos extends StatelessWidget {
  const Doguinhos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(padding: EdgeInsets.all(20)),
          child: Text(
            "Doguinhos",
            style: TextStyle(
              fontSize: 30, TextAlign: TextAlign.center,
            ),
            Row()
            MainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Padding
              {
                Padding(padding: padding.all(10)),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                  ),
                  onPressed: () {
                  
                  },
                  child: Text(
                    "daphiny",
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    ),
                  ),
                )
              }
            ],
          ),
        ],
      ),
    );
  }
}