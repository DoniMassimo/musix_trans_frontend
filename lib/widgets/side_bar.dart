import 'package:flutter/material.dart';

Drawer sideBar() {
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
          onTap: () {},
        ),
        ListTile(leading: Icon(Icons.add), title: Text('Add'), onTap: () {}),
      ],
    ),
  );
}
