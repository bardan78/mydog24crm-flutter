import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'email_login_form.dart';
import 'email_register_form.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;
  String? _error;

  Future<void> _signInWithGoogle() async {
  setState(() { _loading = true; _error = null; });
  try {
    if (kIsWeb) {
      // Logowanie Google na webie
      final provider = GoogleAuthProvider();
      await FirebaseAuth.instance.signInWithPopup(provider);
      // Nie nawiguj ręcznie! StreamBuilder w main.dart przełączy widok.
    } else {
      // Logowanie Google na mobile
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() { _loading = false; });
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // Nie nawiguj ręcznie! StreamBuilder w main.dart przełączy widok.
    }
  } catch (e) {
    setState(() { _error = e.toString(); });
  } finally {
    setState(() { _loading = false; });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Logowanie', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text('Zaloguj przez Google'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(220, 48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _loading ? null : _signInWithGoogle,
                ),
                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 16),
                const Text('lub zaloguj przez email', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                const EmailLoginForm(),
                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 16),
                const Text('lub zarejestruj się przez email', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                const EmailRegisterForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
