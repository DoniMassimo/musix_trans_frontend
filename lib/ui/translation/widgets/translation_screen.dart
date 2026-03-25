import 'dart:async';
import 'package:musix_trans/widgets/side_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:musix_trans/ui/translation/widgets/expandable_line.dart';
import 'package:musix_trans/ui/translation/translation_viewmodel.dart';

class TranslationScreen extends StatelessWidget {
  TranslationScreen({super.key, required trackId, required this.viewModel}) {
    unawaited(viewModel.loadTranslation.execute(trackId));
  }

  final TranslationViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel.loadTranslation,
      builder: (context, child) {
        if (viewModel.loadTranslation.running) {
          return Center(child: CircularProgressIndicator());
        }
        return child!;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(""),
          actions: [
            IconButton(
              icon: Icon(Icons.unfold_more),
              onPressed: () => viewModel.toggleAll(true),
            ),
            IconButton(
              icon: Icon(Icons.unfold_less),
              onPressed: () => viewModel.toggleAll(false),
            ),
          ],
        ),
        drawer: SideBar(),
        body: ChangeNotifierProvider.value(
          value: viewModel,
          child: Column(
            children: [
              Expanded(
                child: Consumer<TranslationViewModel>(
                  builder: (_, value, _) {
                    return ListView.builder(
                      itemCount: value.translation?.lines.length ?? 0,
                      itemBuilder: (_, index) {
                        return ExpandableTextWidget(
                          key: ValueKey(value.expansionStates[index]),
                          title: value.translation?.lines[index].words ?? "",
                          transl: value.translation?.lines[index].trans ?? "",
                          comment:
                              value.translation?.lines[index].comment ?? "",
                          isExpanded: value.expansionStates[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
