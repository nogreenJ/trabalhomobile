import 'package:flutter/material.dart';
import 'menu.dart';

void main() {
  runApp(
    MaterialApp(
      home: MenuOptions(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      )
    )
  );
}
