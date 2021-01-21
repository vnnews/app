import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseApp extends StatefulWidget {
  final Widget child;

  const FirebaseApp({Key key, @required this.child}) : super(key: key);

  @override
  State<FirebaseApp> createState() => _FirebaseState();
}

class _FirebaseState extends State<FirebaseApp> {
  final _future = Firebase.initializeApp();

  @override
  Widget build(BuildContext _) {
    return FutureBuilder(
      future: _future,
      builder: (_, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text('${snapshot.error}')));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return widget.child;
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
