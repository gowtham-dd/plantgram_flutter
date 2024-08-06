import 'dart:ui';

import 'package:instagram_clone_flutter/agriplant/data/services.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone_flutter/agriplant/pages/connect.dart';
import 'package:instagram_clone_flutter/agriplant/pages/machinary.dart';

// Import the pages you want to navigate to
import 'package:instagram_clone_flutter/agriplant/pages/post_page.dart';
import 'package:instagram_clone_flutter/main.dart';
import 'package:instagram_clone_flutter/petchay/pages/Calculate.dart';
import 'package:instagram_clone_flutter/petchay/petchaymain.dart';
import 'package:instagram_clone_flutter/screens/feed_screen.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        itemCount: services.length,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.85,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Define navigation logic based on the index or other criteria
              Widget nextPage;
              switch (index) {
                case 0:
                  nextPage = PostPage();
                  break;
                case 1:
                  nextPage = MyApp();
                  break;
                case 2:
                  nextPage = MachinaryPage();
                  break;
                case 3:
                  nextPage = ConnectIOT();
                  break;
                case 4:
                  nextPage = Calculate();
                  break;
                case 5:
                  nextPage = petchaymain();
                  break;
                case 6:
                  nextPage = PostPage();
                  break;
                default:
                  nextPage = PostPage(); // Fallback to a default page
              }
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => nextPage),
              );
            },
            child: Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(services[index].image),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Text(
                      services[index].name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
