import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/login/login_modal.dart';
import 'package:flutter_application_1/provider/auth_model.dart';
import 'package:flutter_application_1/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({required this.title, super.key});
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.poppins(
          color: const Color.fromARGB(255, 255, 255, 255),
          fontSize: 14.0,
          fontWeight: FontWeight.w800,
        ),
      ),
      iconTheme: const IconThemeData(color: Color.fromARGB(24, 54, 23, 56)),
      backgroundColor: const Color(0xFF006CFF),
      shadowColor: const Color.fromARGB(24, 54, 23, 56),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: authState.isLoggedIn
              ? _UserAvatar(
                  user: authState.user!,
                  onTap: () => _showUserMenu(context, ref),
                )
              : _LoginButton(onTap: () => showLoginModal(context)),
        ),
      ],
    );
  }

  void _showUserMenu(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Logged in as ${ref.read(authProvider).user?.student.name ?? ''}',
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(authProvider.notifier).logout();
                Navigator.pop(context);
              },
              icon: const Icon(Icons.logout_rounded, size: 16),
              label: Text('Logout', style: GoogleFonts.poppins()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade50,
                foregroundColor: Colors.red,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Login Button ---
class _LoginButton extends StatelessWidget {
  const _LoginButton({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        ),
        child: Text(
          'Login',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// --- User Avatar ---
class _UserAvatar extends StatelessWidget {
  const _UserAvatar({required this.user, required this.onTap});
  final AuthUser user;
  final VoidCallback onTap;

  String get _initials {
    final parts = user.student.name.trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    return user.student.name.isNotEmpty
        ? user.student.name[0].toUpperCase()
        : '?';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.white.withValues(alpha: 0.3),
        backgroundImage: user.student.image != null
            ? NetworkImage(user.student.image!)
            : null,
        child: user.student.image == null
            ? Text(
                _initials,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              )
            : null,
      ),
    );
  }
}
