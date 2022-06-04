import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'authentication.dart';
import 'google_sign_in_button.dart';

class AuthMenu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _AuthMenu();


}

class _AuthMenu extends State<AuthMenu>{

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white30,
     body: SafeArea(
       child: Padding(
         padding: const EdgeInsets.only(
           left: 16.0,
           right: 16.0,
           bottom: 20.0,
         ),
         child: Column(
           mainAxisSize: MainAxisSize.max,
           children: [
             Row(),
             Expanded(
               child: Column(
                 mainAxisSize: MainAxisSize.min,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Flexible(
                     flex: 1,
                     child: Image.asset(
                       'assets/logo.png',
                       height: 160,
                     ),
                   ),
                   SizedBox(height: 20),
                   Text(
                     'rent a bike',
                     style: TextStyle(
                       fontSize: 40,
                     ),
                   ),

                 ],
               ),
             ),
             FutureBuilder(
               future: Authentication.initializeFirebase(context: context),
               builder: (context, snapshot) {
                 if (snapshot.hasError) {
                   return Text('Error initializing Firebase');
                 } else if (snapshot.connectionState == ConnectionState.done) {
                   return GoogleSignInButton();
                 }
                 return CircularProgressIndicator(
                   valueColor: AlwaysStoppedAnimation<Color>(
                     Colors.lightGreenAccent,
                   ),
                 );
               },
             ),
           ],
         ),
       ),
     ),
   );

  }

}