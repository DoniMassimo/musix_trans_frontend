import 'package:flutter/material.dart';
import 'package:musix_trans/data/repositories/catalog_repository.dart';
import 'package:musix_trans/data/repositories/translation_repository.dart';
import 'package:musix_trans/ui/catalog/widgets/catalog_screen.dart';
import 'package:musix_trans/ui/catalog/catalog_viewmodel.dart';
import 'package:musix_trans/ui/translation/widgets/translation_screen.dart';
import 'package:musix_trans/ui/translation/translation_viewmodel.dart';
import 'package:provider/provider.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
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
                  builder: (context) => CatalogScreen(
                    viewModel: CatalogViewModel(
                      catalogRepository: context.watch<CatalogRepository>(),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
