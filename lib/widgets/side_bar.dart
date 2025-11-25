import 'package:flutter/material.dart';
import 'package:musix_trans/db.dart';

Drawer sideBar(BuildContext context) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Text(
            'Menu',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
        ListTile(
          leading: Icon(Icons.list),
          title: Text('Catalog'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Catalog(catalog: getCatalog()),
              ),
            );
          },
        ),
        ListTile(leading: Icon(Icons.add), title: Text('Add'), onTap: () {}),
      ],
    ),
  );
}

class Catalog extends StatelessWidget {
  final List<CatalogEntry> catalog;

  const Catalog({super.key, required this.catalog});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: catalog.length,
      itemBuilder: (context, index) {
        ExpansionTile(
          title: Text("Clicca qui"),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text("Contenuto espanso"),
            ),
          ],
        );
      },
    );
  }
}
