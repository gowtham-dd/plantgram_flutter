import 'package:instagram_clone_flutter/petchay/pages/AboutUs.dart';
import 'package:instagram_clone_flutter/petchay/pages/Calculate.dart';
import 'package:instagram_clone_flutter/petchay/pages/FAQ.dart';
import 'package:instagram_clone_flutter/petchay/pages/Scanner.dart';
import 'package:instagram_clone_flutter/petchay/pages/SettingsPage.dart';
import 'package:instagram_clone_flutter/petchay/pages/HomeScreen.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Navigation> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 244, 245, 245),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/plantbg.gif'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'PlantGram Doctor',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                setState(() {
                  _page = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.medical_information),
              title: const Text('PlantGram Doctor'),
              onTap: () {
                setState(() {
                  _page = 1;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: getPage(_page),
    );
  }

  Widget getPage(int page) {
    switch (page) {
      case 0:
        return const HomeWidget();
      case 1:
        return const ScannerPage();
      case 2:
        return const Calculate();
      case 3:
        return const AboutUs();
      case 4:
        return const FAQ();
      case 5:
        return const SettingsPage();
      default:
        return Container(); // Default page, you can replace it with another widget.
    }
  }
}
