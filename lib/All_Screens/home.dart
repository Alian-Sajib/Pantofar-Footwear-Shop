import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:pantofar/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'MenCollection.dart';
import 'WomenCollection.dart';
import '../widgets/drawer.dart';

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
      backgroundColor: Colors.white,
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
          child: Center(
            //change
            //added this column
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(13, 0, 13, 31),
                  child: Text(
                    'Choose a genre:',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: 33,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        //change
                        width: MediaQuery.of(context).size.width * .41,
                        height: MediaQuery.of(context).size.width * .41,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 17.0,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(19)),
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
                        //change
                        width: MediaQuery.of(context).size.width * .41,
                        height: MediaQuery.of(context).size.width * .41,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(0.0, 1.0), //(x,y)
                              blurRadius: 17.0,
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(19)),
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
                ),
              ],
            ),
          )),
    );
  }
}
