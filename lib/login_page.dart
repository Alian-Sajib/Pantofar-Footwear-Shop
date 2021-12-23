import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pantofar/home.dart';
import 'package:pantofar/providers/user_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late UserProvider userProvider;

  _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      final User? user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);
      userProvider.addUserData(
        currentUser: user,
        userEmail: user!.email,
        userImage: user.photoURL,
        userName: user.displayName,
      );
      return user;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        height: double.infinity,
        width: double.infinity,
        // decoration: BoxDecoration(
        // image: DecorationImage(
        //     fit: BoxFit.cover,
        //     image: AssetImage('assets/images/logobg.jpg'))),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Column(
                  children: [
                    SizedBox(height: 100),

                    //  SizedBox(height: 20,),
                    Text(
                      'PANTOFAR',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 37,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '  The Fastest Footwear Delivery Service ',
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.w300,
                        fontSize: 15,
                      ),
                    ),

                    // Image.asset(
                    //   'assets/images/2.png',
                    //   height: 160,
                    //   width: 160,
                    //   fit: BoxFit.contain,
                    // ),
                  ],
                ),
              ),
              SizedBox(
                  width: 10, height: MediaQuery.of(context).size.height * .3),
              Padding(
                padding: const EdgeInsets.fromLTRB(11, 0, 11, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    //change...
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 21),
                      child: Text(
                        'Sign in / Sign up:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w900,
                            color: Colors.black),
                      ),
                    ),
                    SignInButton(
                      Buttons.Google,
                      //change...
                      elevation: 9,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(21)),
                      text: "SIGN IN WITH GOOGLE",
                      padding: EdgeInsets.all(3),
                      onPressed: () async {
                        await _googleSignUp().then(
                          (value) => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
