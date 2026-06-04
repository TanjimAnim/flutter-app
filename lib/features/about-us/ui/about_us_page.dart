import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/appbar/ui/custom_appbar.dart';
import 'package:flutter_application_1/features/drawer/ui/custom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

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
