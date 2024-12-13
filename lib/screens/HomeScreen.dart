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



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'LoginScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Method to handle logout
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
          "Home",
          style: TextStyle(color: Colors.white, fontSize: 25),
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
      body: Container(
        color: Colors.white, // Background color
        child: const Center(
          child: Text(
            'Welcome to HomeScreen',
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
