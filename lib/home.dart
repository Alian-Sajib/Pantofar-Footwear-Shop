import 'package:flutter/material.dart';
import 'package:pantofar/providers/user_provider.dart';
import 'package:provider/provider.dart';

import 'MenCollection.dart';
import 'WomenCollection.dart';
import 'drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    return Scaffold(
      drawer: DrawerSide(
        userProvider: userProvider,
      ),
      backgroundColor: Colors.white12,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Home',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 400, //MediaQuery.of(context).size.width,
                  height: 315,//MediaQuery.of(context).size.height * .35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                    image: DecorationImage(
                      image: AssetImage('assets/images/gents.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Mens(),
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              GestureDetector(
                child: Container(
                  width: 400, //MediaQuery.of(context).size.width,
                  height: 315, //MediaQuery.of(context).size.height * .35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                    image: DecorationImage(
                      image: AssetImage('assets/images/girls.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Womens(),
                    ),
                  );
                },
              ),
            ],
          )),
    );
  }
}
