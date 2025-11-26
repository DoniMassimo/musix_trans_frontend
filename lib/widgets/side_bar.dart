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
        ListTile(
          leading: Icon(Icons.miscellaneous_services),
          title: Text('Misc'),
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MiscPage()),
            );
          },
        ),
      ],
    ),
  );
}

class Catalog extends StatefulWidget {
  final List<CatalogEntry> catalog;

  const Catalog({super.key, required this.catalog});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("app"),
      ),
      drawer: sideBar(context),
      body: ListView.builder(
        itemCount: widget.catalog.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      LyricPage(trackId: widget.catalog[index].trackId),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(widget.catalog[index].author),
                  Text(widget.catalog[index].songName),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class LyricPage extends StatefulWidget {
  final String trackId;
  const LyricPage({super.key, required this.trackId});

  @override
  State<LyricPage> createState() => _LyricPageState();
}

class _LyricPageState extends State<LyricPage> {
  late List<Line> lines;
  late List<bool> expanded;

  @override
  void initState() {
    super.initState();
    lines = getSongTrans(widget.trackId);
    expanded = List.filled(lines.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.unfold_more),
            onPressed: () {
              setState(() {
                for (var i = 0; i < expanded.length; i++) {
                  expanded[i] = true;
                }
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.unfold_less),
            onPressed: () {
              setState(() {
                for (var i = 0; i < expanded.length; i++) {
                  expanded[i] = false;
                }
              });
            },
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("app"),
      ),
      drawer: sideBar(context),
      body: SingleChildScrollView(
        child: ExpansionPanelList(
          expansionCallback: (panelIndex, isExpanded) {
            setState(() {
              var a = expanded[panelIndex];
              expanded[panelIndex] = isExpanded;
            });
          },
          children: [
            for (int i = 0; i < expanded.length; i++)
              ExpansionPanel(
                headerBuilder: (_, __) => ListTile(title: Text(lines[i].line)),
                body: Column(
                  children: [
                    Padding(
                      padding: EdgeInsetsGeometry.all(10),
                      child: Text(lines[i].trans),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.all(10),
                      child: Text(lines[i].comment),
                    ),
                  ],
                ),
                isExpanded: expanded[i],
              ),
          ],
        ),
      ),
    );
  }
}

class MiscPage extends StatefulWidget {
  String result = "";
  MiscPage({super.key});

  @override
  State<MiscPage> createState() => _MiscPageState();
}

class _MiscPageState extends State<MiscPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("app"),
      ),
      drawer: sideBar(context),
      body: Column(
        children: [
          Center(
            child: OutlinedButton(
              child: Text("ciao"),
              onPressed: () async {
                try {
                  await updateDB();
                  setState(() {
                    widget.result = "CORRECT";
                  });
                } catch (e) {
                  setState(() {
                    widget.result = "ERROR";
                  });
                }
              },
            ),
          ),
          Center(child: Text(widget.result)),
        ],
      ),
    );
  }
}
