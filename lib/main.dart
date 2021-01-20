import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _FirebaseApp(),
    );
  }
}

class _FirebaseApp extends StatefulWidget {
  @override
  State<_FirebaseApp> createState() => _FirebaseState();
}

class _FirebaseState extends State<_FirebaseApp> {
  final _future = Firebase.initializeApp();

  @override
  Widget build(BuildContext _) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _future,
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return Text('${snapshot.data}');
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
