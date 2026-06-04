import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/about-us/ui/about_us_page.dart';
import 'package:flutter_application_1/features/category/ui/category_page.dart';
import 'package:google_fonts/google_fonts.dart';

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
