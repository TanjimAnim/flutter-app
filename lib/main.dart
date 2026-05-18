import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
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
      appBar: AppBar(
        title: Text(
          "Home",
          style: GoogleFonts.poppins(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        iconTheme: IconThemeData(color: Color.fromARGB(24, 54, 23, 56)),
        backgroundColor: const Color(0xFF006CFF),
        shadowColor: Color.fromARGB(24, 54, 23, 56),
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text(
          "CategoryPage",
          style: GoogleFonts.poppins(fontSize: 50.0, color: Color(0xFF006CFF)),
        ),
      ),
    );
  }
}

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Text(
          "About Us",
          style: GoogleFonts.poppins(fontSize: 50.0, color: Color(0xFF006CFF)),
        ),
      ),
    );
  }
}
