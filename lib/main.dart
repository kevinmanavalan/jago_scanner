import 'package:flutter/material.dart';
import 'package:jago_volunteer_scanner/screens/share_card.dart';
// import 'package:jago_volunteer_scanner/screens/home_screen.dart';
// import 'package:jago_volunteer_scanner/screens/qr_scanner_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Jago Volunteer Scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ShareCardScreen(name: "Kevin Manavalan"),
    );
  }
}
