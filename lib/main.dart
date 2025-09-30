
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mydog_app/firebase_options.dart';
import 'auth/login_page.dart';
import 'package:flutter/material.dart';
import 'search/search_page.dart';

class RaportPage extends StatelessWidget {
  const RaportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Raport')),
      body: const Center(child: Text('Raport', style: TextStyle(fontSize: 32))),
    );
  }
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mydog CRM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.black87),
          shadowColor: Colors.transparent,
        ),
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (!snapshot.hasData) {
            return const LoginPage();
          }
          return const MyHomePage(title: 'Mydog24 CRM');
        },
      ),
    );
  }
}



class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.search), text: 'Wyszukiwarka'),
              Tab(icon: Icon(Icons.insert_chart), text: 'Raport'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            SearchPage(),
            RaportPage(),
          ],
        ),
      ),
    );
  }
}
