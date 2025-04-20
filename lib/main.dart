import 'package:flutter/material.dart';
import 'splashscreen.dart';

void main() {
  runApp(RandomUserApp());
}

class RandomUserApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random User Info Viewer',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
