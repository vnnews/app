import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:vnnews/src/services/firebase.dart';
import 'package:vnnews/src/ui/article_list/article_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: FirebaseApp(
          child: ArticleListPage(),
        ),
      ),
    );
  }
}
