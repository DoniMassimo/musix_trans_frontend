import 'package:flutter/material.dart';

class ExpandableTextWidget extends StatelessWidget {
  final String title;
  final String transl;
  final String comment;
  final bool isExpanded;

  const ExpandableTextWidget({
    super.key,
    required this.title,
    required this.transl,
    required this.comment,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ExpansionTile(
        initiallyExpanded: isExpanded,
        title: Text(title, style: const TextStyle(fontSize: 16)),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        children: [
          Text(transl),
          Divider(thickness: 1, color: Colors.grey),
          Text(comment),
        ],
      ),
    );
  }
}
