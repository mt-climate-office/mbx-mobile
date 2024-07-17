import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'requests/get_station_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 82, 99, 222)),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Egg Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int navIndex = 0;
  List<dynamic> _data = [];
  String? _selectedItem;

  @override
  void initState() {
      super.initState();
      fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('https://mesonet.climate.umt.edu/api/stations?type=json')
    );

    if (response.statusCode == 200) {
        setState(() {
            _data = json.decode(response.body);
        });
        print('Fetched data: $_data');
    } else {
        throw Exception('Failed to load data');
    }
}

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Montana Mesonet'),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: const Color.fromARGB(255, 26, 29, 212),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.location_on),
                  label: "Station",
                ),
                BottomNavigationBarItem(
                  label: "Graph",
                  icon: Icon(Icons.show_chart)
                ),
                BottomNavigationBarItem(
                  label: "Settings",
                  icon: Icon(Icons.settings)
                )
              ],
              currentIndex: navIndex,
              onTap: (int idx){setState(() {
                navIndex = idx;
              });
              },
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        const Text(
                            'You have selected:',
                        ),
                        Text(
                            '$_selectedItem',
                            style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 20), // Adds space between the counter and the dropdown
                        _data.isEmpty
                            ? const CircularProgressIndicator()
                            : DropdownButton<String>(
                                hint: const Text('Select Station'),
                                value: _selectedItem,
                                items: _data.map<DropdownMenuItem<String>>((item) {
                                    return DropdownMenuItem<String>(
                                        value: '${item['station']}: ${item['name']}',
                                        child: Text('${item['station']}: ${item['name']}'),
                                    );
                                }).toList(),
                                onChanged: (String? newValue) {
                                    setState(() {
                                        _selectedItem = newValue;
                                    });
                                },
                            ),
                    ],
                ),
            ),
        );
  }
}
