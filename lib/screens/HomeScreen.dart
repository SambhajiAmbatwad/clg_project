// // import 'package:flutter/material.dart';
// //
// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.orange,
// //         automaticallyImplyLeading: false,
// //         centerTitle: true,
// //         title: Text("Home",style: TextStyle(color: Colors.white,fontSize: 25),),
// //
// //       ),
// //       body: Container(
// //         color: Colors.white, // Background color
// //         child: const Center(
// //           child: Text(
// //             'Welcome to HomeScreen',
// //             style: TextStyle(color: Colors.white, fontSize: 24),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
//
// import 'LoginScreen.dart';
//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false, // Removes the back arrow
//         backgroundColor: Colors.orange,
//         title: Text(
//           "Home",
//           style: TextStyle(color: Colors.white, fontSize: 25),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             color: Colors.white,
//             onPressed: () {
//               // Perform logout action here
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: const Text("Logout"),
//                   content: const Text("Are you sure you want to logout?"),
//                   actions: [
//                     TextButton(
//                       onPressed: () {
//                         Navigator.pop(context); // Close dialog
//                       },
//                       child: const Text("Cancel"),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         // Navigate back to login or perform logout logic
//                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Homepage()));// Go back to login
//                       },
//                       child: const Text("Logout"),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//       body: Container(
//         color: Colors.white, // Background color
//         child: const Center(
//           child: Text(
//             'Welcome to HomeScreen',
//             style: TextStyle(color: Colors.black, fontSize: 24),
//           ),
//         ),
//       ),
//     );
//   }
// }
//

import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:clg_project/screens/nityaseva.dart';
import 'package:clg_project/screens/products.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clg_project/Widgets/navigation_drawer.dart';

import 'LoginScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///* For Slide Animation of Images
  final List<String> images = [
    'Assets/Images/image1.jpg',
    'Assets/Images/image2.jpg',
    'Assets/Images/Samarth Math.jpg',
  ];
  int activeIndex = 0;

  ///? For slide Quote
  final quotes = [
    "संकटं येत असतात, ती तुम्हाला थांबवायला नाही, तर तुमच्या सामर्थ्याची जाणीव करून द्यायला.",
    "धीर आणि श्रद्धा हे जीवनातील कोणत्याही संकटावर विजय मिळवण्यासाठी सर्वात मोठे शस्त्र आहेत.",
    "जो स्वतःवर विश्वास ठेवतो, तोच खऱ्या अर्थाने जग जिंकतो.",
    "जीवनातील खरी शांतता आपल्या मनातली श्रद्धा आणि सेवा यामध्येच आहे."
  ];

  ///?For Bottom navigation bar
  int _currentIndex = 0;
  List<Widget> _pages = const [
    Nityaseva(),
    Products(),
  ];

  ///! Method to handle logout
  Future<void> _handleLogout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      // Navigate back to the login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()),
      );
    } catch (e) {
      // Show error message if logout fails
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        backgroundColor: Colors.orange,
        title: const Text(
          "श्री गुरुपीठ त्र्यंबकेश्वर",
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white), // White menu icon
              onPressed: () {
                // Open the drawer using the correct context from the Builder widget
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.white,
            onPressed: () {
              // Show confirmation dialog before logout
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Logout"),
                  content: const Text("Are you sure you want to logout?"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                      },
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context); // Close dialog
                        _handleLogout(context); // Perform logout
                      },
                      child: const Text("Logout"),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      drawer: Navigationdrawer(),
      body: ListView(
        children: [
          SizedBox(
            height: 10,
          ),
          CarouselSlider.builder(
            itemCount: images.length,
            itemBuilder: (context, index, realIndex) {
              final image = images[index];
              return buildImage(image, index);
            },
            options: CarouselOptions(
              autoPlay: true,
              height: 200,
              onPageChanged: (index, reason) =>
                  setState(() => activeIndex = index),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Center(
            child: buildIndicator(),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(15),
                // Optional: Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 5, // Spread radius
                    blurRadius: 7, // Blur radius
                    offset: Offset(0, 3), // Changes position of shadow (x, y)
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Text("पंचांग: ८ मार्च २०२३"),
                  ),
                  Positioned(
                    top: 40,
                    left: 20,
                    child: Text("तिथी: फाल्गुन कृ. १"),
                  ),
                  Positioned(
                    top: 60,
                    left: 20,
                    child: Text("वार: बुधवार"),
                  ),
                  Positioned(
                    top: 80,
                    left: 20,
                    child: Text("नक्षत्र: उत्तरा"),
                  ),
                  Positioned(
                    top: 30,
                    right: 50,
                    child: Text("राहुकाल: दु. १२:०० ते १:३०"),
                  ),
                  Positioned(
                    top: 60,
                    right: 80,
                    child: Text("शुभाशुभ: उत्तम दिवस"),
                  ),
                  Positioned(
                    top: 90,
                    right: 50,
                    child: Text("दिनविशेष: बळतोळसणारंभ जागतिक महिला दिन"),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            height: 150,
            child: CarouselSlider.builder(
              itemCount: quotes.length,
              itemBuilder: (context, index, realIndex) {
                final quote = quotes[index];
                return buildQoute(quote, index);
              },
              options: CarouselOptions(
                autoPlay: true,
                height: 200,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index),
              ),
            ),
          ),
          // SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Recent Seva",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Card(
            child: Stack(
              children: [
                Positioned(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Colors.orange, width: 2), // Orange outline
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          // Match the parent borderRadius
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                  child: Center(
                                      child: Text(
                                    "71",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ), // Top half white
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.orangeAccent,
                                  child: Center(
                                      child: Text(
                                    "माळ ",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      // Adjust text color for better contrast
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                                ), // Bottom half orange
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
                Positioned(
                  left: 130,
                  top: 20,
                  child: Text("श्री स्वामी समर्थ मंत्र"),
                ),
                Positioned(
                  left: 130,
                  top: 40,
                  child: Text("०६ मार्च २०२३ २२:३३:५८"),
                ),
                Positioned(
                  right: 20,
                  bottom: 20,
                  child: Container(
                    height: 50,
                    width: 80,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: Center(
                      child: Text(
                        "वैफळीक",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Explore Vibhag",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.orange, width: 2), // Orange outline
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      // Match the parent borderRadius
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2, // Top 1/3
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.globe,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1, // Bottom 2/3
                            child: Container(
                              color: Colors.orangeAccent,
                              child: Center(
                                child: Text(
                                  "देश विदेश",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.orange, width: 2), // Orange outline
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      // Match the parent borderRadius
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2, // Top 1/3
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.bookOpenReader,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1, // Bottom 2/3
                            child: Container(
                              color: Colors.orangeAccent,
                              child: Center(
                                child: Text(
                                  "स्वामीसेवा अंक",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.orange, width: 2), // Orange outline
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      // Match the parent borderRadius
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2, // Top 1/3
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.schoolFlag,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1, // Bottom 2/3
                            child: Container(
                              color: Colors.orangeAccent,
                              child: Center(
                                child: Text(
                                  "प्रशासनिक",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.orange, width: 2), // Orange outline
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      // Match the parent borderRadius
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2, // Top 1/3
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.bookOpenReader,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1, // Bottom 2/3
                            child: Container(
                              color: Colors.orangeAccent,
                              child: Center(
                                child: Text(
                                  "स्वामीसेवा अंक",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: Colors.orange, width: 2), // Orange outline
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      // Match the parent borderRadius
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2, // Top 1/3
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: FaIcon(
                                  FontAwesomeIcons.globe,
                                  size: 40,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1, // Bottom 2/3
                            child: Container(
                              color: Colors.orangeAccent,
                              child: Center(
                                child: Text(
                                  "देश विदेश",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Nityaseva()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Products()),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Nityaseva',
            icon: FaIcon(
              FontAwesomeIcons.handsPraying,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Products',
            icon: FaIcon(
              FontAwesomeIcons.bagShopping,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(String image, int index) => Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: Image.asset(
          image,
          fit: BoxFit.cover,
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: images.length,
        effect:
            ExpandingDotsEffect(dotWidth: 15, activeDotColor: Colors.orange),
      );

  Widget buildQoute(String quote, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      padding: EdgeInsets.all(16.0),
      // height: 100,
      decoration: BoxDecoration(
        color: Colors.orangeAccent.shade200,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            quote,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

