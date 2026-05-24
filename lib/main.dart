import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './core/network/connector_config.dart';

void main() {
  setupConnector();
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
      appBar: CustomAppBar(title: "Home"),
      drawer: CustomDrawer(),
    );
  }
}

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Color(0x00aaddcc)),
            child: Text(
              "Menu",
              style: GoogleFonts.poppins(
                color: Color(0xff006cff),
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Color(0xff006cff)),
            title: Text("Home", style: GoogleFonts.poppins(fontSize: 14.0)),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.category, color: Color(0xff006cff)),
            title: Text("Category", style: GoogleFonts.poppins(fontSize: 14.0)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CategoryPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Color(0xff006cff)),
            title: Text("About Us", style: GoogleFonts.poppins(fontSize: 14.0)),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AboutUsPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({required this.title, super.key});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: Color.fromARGB(255, 255, 255, 255),
          fontSize: 14.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      iconTheme: IconThemeData(color: Color.fromARGB(24, 54, 23, 56)),
      backgroundColor: const Color(0xFF006CFF),
      shadowColor: Color.fromARGB(24, 54, 23, 56),
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
          "Category Page",
          style: GoogleFonts.poppins(fontSize: 50.0, color: Color(0xFF006CFF)),
        ),
      ),
      appBar: CustomAppBar(title: "Category"),
      drawer: CustomDrawer(),
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
      appBar: CustomAppBar(title: "About Us"),
      drawer: CustomDrawer(),
    );
  }
}
