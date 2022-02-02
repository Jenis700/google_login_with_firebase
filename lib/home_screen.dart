// Home page screen

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_practice/sing_in_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// creating firebase instance
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<SignInScreen> signOut(BuildContext context) async {
    final GoogleSignIn googleSignOut = GoogleSignIn();

    googleSignOut.signOut();
    auth.signOut();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
    );
    return SignInScreen();
  }

  getProfilePhoto() {
    if (auth.currentUser!.photoURL != null) {
      return Image.network("${auth.currentUser!.photoURL}");
    } else {
      Text("No Profile Picture");
    }
  }

  getName() {
    if (auth.currentUser!.displayName != null) {
      return Text(
        "${auth.currentUser!.displayName}",
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text("Google Sing In"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            ClipRRect(
              child: getProfilePhoto(),
              borderRadius: BorderRadius.circular(50),
            ),
            const SizedBox(height: 30),
            ShaderMask(
              shaderCallback: (bounds) => const RadialGradient(
                colors: [Colors.black, Colors.red],
                tileMode: TileMode.repeated,
              ).createShader(bounds),
              child: getName(),
            ),
            const SizedBox(height: 30),
            Text(
              "${auth.currentUser!.email}",
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                signOut(context);
              },
              child: Text("Log out"),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
