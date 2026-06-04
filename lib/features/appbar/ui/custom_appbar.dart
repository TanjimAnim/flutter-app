import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
