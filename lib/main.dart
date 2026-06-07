import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/appbar/ui/custom_appbar.dart';
import 'package:flutter_application_1/features/drawer/ui/custom_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import './core/network/connector_config.dart';

void main() {
  setupConnector();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      title: "My First Flutter App",
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text(
          "Home Page",
          style: GoogleFonts.poppins(fontSize: 50.0, color: Color(0xFF006CFF)),
        ),
      ),
      appBar: CustomAppBar(title: "Home"),
      drawer: CustomDrawer(),
    );
  }
}
