import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pantofar/All_Screens/MenCollection.dart';
import 'package:pantofar/providers/check_out_provider.dart';
import 'package:pantofar/providers/men_product_provider.dart';
import 'package:pantofar/providers/review_cart_provider.dart';
import 'package:pantofar/providers/user_provider.dart';
import 'package:pantofar/providers/women_product_provider.dart';
import 'package:provider/provider.dart';
import 'All_Screens/home.dart';
import 'package:pantofar/All_Screens/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),

        ChangeNotifierProvider<WomenProductProvider>(
          create: (context) => WomenProductProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ReviewCartProvider>(
          create: (context) => ReviewCartProvider(),
        ),
        ChangeNotifierProvider<CheckoutProvider>(
          create: (context) => CheckoutProvider(),
        ),

      ],
      
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        routes: {'home': (context) => LoginPage()},
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void startTimer() {
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('home');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Stack(children: [
        Container(
            decoration: BoxDecoration(
                image: DecorationImage(
          image: AssetImage('assets/images/logobg.jpg'),
          fit: BoxFit.contain,
        ))),
        Center(
          child: Image.asset(
            'assets/images/logoText.png',
            fit: BoxFit.none,
          ),
        )
      ]),

      /* body: Center(
        child:Image.asset('assets/images/logo.jpg', width: MediaQuery.of(context).size.width *1,)
      )*/
    );
  }
}
