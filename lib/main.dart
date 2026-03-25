import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_ce/hive.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:musix_trans/data/repositories/translation_repository.dart';
import 'package:musix_trans/ui/catalog/catalog_viewmodel.dart';
import 'package:musix_trans/ui/translation/translation_viewmodel.dart';
import 'widgets/side_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'data/services/local_data.dart';
import 'package:musix_trans/models/translation/translation.dart';
import 'package:musix_trans/data/repositories/catalog_repository.dart';
import 'data/services/api_client.dart';
import 'dart:convert';

extension PrettyPrint on Object {
  String pretty() {
    try {
      return const JsonEncoder.withIndent('  ').convert(this);
    } catch (e) {
      return toString();
    }
  }
}

Future<void> t() async {
  ApiClient api = ApiClient(
    host: '0.0.0.0',
    port: 5000,
    apiKey: dotenv.env['API_KEY'] ?? '',
  );
  // Box<Translation> box = await Hive.openBox<Translation>('translations');
  // Hive.deleteBoxFromDisk('translations');
  return;
  // LocalData local = LocalData(box: box);
  // CatalogRepository catalogRepository = CatalogRepository(
  //   localData: local,
  //   apiClient: api,
  // );
  // // var res = local.getTransl("7mcxFbFdnFFbWwPflgqqKE");
  // var res = catalogRepository.getCatalog();
  // print(res);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'secrets.env');
  var path = (await getApplicationSupportDirectory()).path;
  Hive.init(path);
  Hive.registerAdapter(TranslationAdapter());
  Hive.registerAdapter(SpotyApiDataAdapter());
  Hive.registerAdapter(ArtistAdapter());
  Hive.registerAdapter(AlbumAdapter());
  Hive.registerAdapter(LineAdapter());

  Box<Translation> box = await Hive.openBox<Translation>('translations');
  ApiClient api = ApiClient(
    host: 'musix-backend-y054.onrender.com',
    apiKey: dotenv.env['API_KEY'] ?? '',
  );
  final localData = LocalData(box: box);
  CatalogRepository catalogRepository = CatalogRepository(
    localData: localData,
    apiClient: api,
  );

  TranslationRepository translRepository = TranslationRepository(
    localData: localData,
  );
  runApp(
    MultiProvider(
      providers: [
        Provider<CatalogRepository>.value(value: catalogRepository),
        Provider<TranslationRepository>.value(value: translRepository),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [],
          ),
        ),
      ),
    );
  }
}
