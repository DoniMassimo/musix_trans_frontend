import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'api.dart' as api;

Map<String, dynamic> getLyrics() {
  Box box = Hive.box('lyrics');
  return Map<String, dynamic>.from(box.get("71rgyPxQt2eaIvxvfsZ3B4"));
}

List<Widget> getLyiricsWidgets() {
  List<Map<String, dynamic>> rawLines = (getLyrics()['lines'] as List)
      .map((line) => Map<String, dynamic>.from(line))
      .toList();
  List<Map<String, String?>> lyrics = rawLines
      .map(
        (line) => {
          'original': line['words'] as String?,
          'translation': line['translation'] as String?,
          'comment': line['comment'] as String?,
        },
      )
      .toList();
  List<Widget> listWidgets = [];
  for (var line in lyrics) {
    listWidgets.add(
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue, width: 2),
          borderRadius: BorderRadius.circular(
            8,
          ), // opzionale: angoli arrotondati
        ),
        child: Column(
          children: <Widget>[
            Text(line['original'] ?? ''),
            Text(line['translation'] ?? ''),
          ],
        ),
      ),
    );
  }
  return listWidgets;
}

Future<void> testHive() async {
  Box box = Hive.box('lyrics');
  final String response = await rootBundle.loadString('assets/spoty_text.json');
  final data = jsonDecode(response);
  box.put("71rgyPxQt2eaIvxvfsZ3B4", data);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'secrets.env');
  await api.getTracksIds();
  await Hive.initFlutter();
  await Hive.openBox('lyrics');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: getLyiricsWidgets(),
          ),
        ),
      ),
    );
  }
}
