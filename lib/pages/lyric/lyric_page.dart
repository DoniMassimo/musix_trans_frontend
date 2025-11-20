import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
