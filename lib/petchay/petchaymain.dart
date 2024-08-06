import 'package:instagram_clone_flutter/petchay/pages/Navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const petchaymain());
}

class petchaymain extends StatelessWidget {
  const petchaymain({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 6, 153, 84)),
        useMaterial3: true,
      ),
      home: const Navigation(),
    );
  }
}
