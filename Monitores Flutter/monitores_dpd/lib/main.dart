import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monitoria App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Poppins',
      ),
      home: MonitorListScreen(),
    );
  }
}

class Horario {
  final String dia;
  final String horario;

  Horario({required this.dia, required this.horario});

  factory Horario.fromJson(Map<String, dynamic> json) {
    return Horario(
      dia: json['dia'],
      horario: json['horario'],
    );
  }
}

class Monitor {
  final int id;
  final String nome;
  final String avatar;
  final List<Horario> horarios;

  Monitor({required this.id, required this.nome, required this.avatar, required this.horarios});

  factory Monitor.fromJson(Map<String, dynamic> json) {
    var horariosList = json['horarios'] as List;
    List<Horario> horarios = horariosList.map((e) => Horario.fromJson(e)).toList();

    return Monitor(
      id: json['id'],
      nome: json['nome'],
      avatar: json['avatar'],
      horarios: horarios,
    );
  }
}

class MonitorListScreen extends StatefulWidget {
  @override
  _MonitorListScreenState createState() => _MonitorListScreenState();
}

class _MonitorListScreenState extends State<MonitorListScreen> {
  late Future<List<Monitor>> monitors;

  Future<List<Monitor>> fetchMonitors() async {
    final response = await http.get(Uri.parse('http://localhost:3000/monitores'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((monitor) => Monitor.fromJson(monitor)).toList();
    } else {
      throw Exception('erro ao carregar monitores');
    }
  }

  @override
  void initState() {
    super.initState();
    monitors = fetchMonitors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              'Horários Monitores',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          // carrosel de monitores
          Expanded(
            child: FutureBuilder<List<Monitor>>(
              future: monitors,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum monitor encontrado'));
                }

                var monitorList = snapshot.data!;

                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: CarouselSlider.builder(
                      itemCount: monitorList.length,
                      itemBuilder: (context, index, realIndex) {
                        var monitor = monitorList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MonitorDetailScreen(monitor: monitor),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 5,
                            shadowColor: Colors.black45,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            color: Colors.grey[200],
                            child: Container(
                              width: 180,
                              height: 250,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipOval(
                                    child: Image.network(
                                      monitor.avatar,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    monitor.nome,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 300,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        autoPlay: false,
                        viewportFraction: 0.33,
                        scrollPhysics: BouncingScrollPhysics(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MonitorDetailScreen extends StatelessWidget {
  final Monitor monitor;

  MonitorDetailScreen({required this.monitor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(monitor.nome),
        backgroundColor: Colors.blue[100],
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: monitor.horarios.length,
                itemBuilder: (context, index) {
                  var horario = monitor.horarios[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), 
                    ),
                    color: Colors.grey[200],
                    child: ListTile(
                      leading: Icon(Icons.access_time, color: Colors.blue),
                      title: Text(
                        '${horario.dia} - ${horario.horario}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
