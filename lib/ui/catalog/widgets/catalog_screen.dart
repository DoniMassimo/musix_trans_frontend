import 'dart:async';
import 'package:flutter/material.dart';
import 'package:musix_trans/data/repositories/translation_repository.dart';
import 'package:musix_trans/ui/translation/translation_viewmodel.dart';
import 'package:musix_trans/ui/translation/widgets/translation_screen.dart';
import 'package:musix_trans/widgets/side_bar.dart';
import 'package:provider/provider.dart';
import 'package:musix_trans/ui/catalog/catalog_viewmodel.dart';

class CatalogScreen extends StatelessWidget {
  final CatalogViewModel viewModel;

  CatalogScreen({super.key, required this.viewModel}) {
    unawaited(viewModel.loadCatalog.execute());
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        viewModel.syncCatalog,
        viewModel.loadCatalog,
      ]),
      builder: (context, child) {
        if (viewModel.syncCatalog.running || viewModel.loadCatalog.running) {
          return Center(child: CircularProgressIndicator());
        }
        if (viewModel.syncCatalog.error) {
          print(viewModel.syncCatalog.result);
        }
        return child!;
      },
      child: ChangeNotifierProvider.value(
        value: viewModel,
        child: Scaffold(
          drawer: SideBar(),
          appBar: AppBar(
            title: TextField(
              onChanged: (value) => viewModel.search(value),
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Search for songs...",
                hintStyle: TextStyle(color: Colors.white70),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.white),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () => viewModel.syncCatalog.execute(),
              ),
            ],
          ),
          body: Consumer<CatalogViewModel>(
            builder: (_, value, _) {
              if (viewModel.loadCatalog.completed) {
                return ListView.builder(
                  itemCount: viewModel.catalog?.length ?? 0,
                  itemBuilder: (context, index) => ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TranslationScreen(
                          trackId: value.catalog?[index].trackId ?? "",
                          viewModel: TranslationViewModel(
                            translationRepository: context
                                .watch<TranslationRepository>(),
                          ),
                        ),
                      ),
                    ),
                    child: Text(viewModel.catalog?[index].song ?? ''),
                  ),
                );
              }
              return Placeholder();
            },
          ),
        ),
      ),
    );
  }
}
