import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conversor de Temperatura',
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: TextTheme(
          headline6: TextStyle(fontFamily: 'Montserrat', fontSize: 24),
        ),
      ),
      home: CelsiusScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CelsiusScreen extends StatefulWidget {
  @override
  _CelsiusScreenState createState() => _CelsiusScreenState();
}

class _CelsiusScreenState extends State<CelsiusScreen> {
  final TextEditingController _controller = TextEditingController();
  double _celsius = 0;

  void _navigateToFahrenheit() {
    if (_isInputValid(_controller.text)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FahrenheitScreen(celsius: _celsius)),
      );
    } else {
      _showAlert('Tem letra no input -_-');
    }
  }

  void _navigateToKelvin() {
    if (_isInputValid(_controller.text)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => KelvinScreen(celsius: _celsius)),
      );
    } else {
      _showAlert('Tem letra no input -_-');
    }
  }

  bool _isInputValid(String input) {
    return double.tryParse(input) != null;
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(title: Text('Converter Celsius', style: Theme.of(context).textTheme.headline6)),
      body: Center( 
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Container(
                width: 350, 
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5,
                      spreadRadius: 2,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Temperatura em Celsius',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black), // Cor da borda ao focar
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black), // Cor da borda padrão
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _celsius = double.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: _navigateToFahrenheit,
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 174, 244, 95),
                          ),
                          child: Text('Fº'),
                        ),
                        SizedBox(height: 10), 
                        ElevatedButton(
                          onPressed: _navigateToKelvin,
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 182, 255, 99),
                          ),
                          child: Text('K'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Positioned(
                bottom: 16,
                left: 16,
                child: Text(
                  'Marcelo Manzo\nRA: 23326',
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FahrenheitScreen extends StatelessWidget {
  final double celsius;

  FahrenheitScreen({required this.celsius});

  @override
  Widget build(BuildContext context) {
    double fahrenheit = (celsius * 9 / 5) + 32;

    return Scaffold(
      appBar: AppBar(title: Text('Fahrenheit', style: Theme.of(context).textTheme.headline6)),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.green[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$celsius °C = $fahrenheit °F',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class KelvinScreen extends StatelessWidget {
  final double celsius;

  KelvinScreen({required this.celsius});

  @override
  Widget build(BuildContext context) {
    double kelvin = celsius + 273.15;

    return Scaffold(
      appBar: AppBar(title: Text('Kelvin', style: Theme.of(context).textTheme.headline6)),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32.0),
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$celsius °C = $kelvin K',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
