import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pantofar/providers/user_provider.dart';
import 'package:pantofar/review_cart.dart';
import '../home.dart';
import '../login_page.dart';
import '../my_profile.dart';


class DrawerSide extends StatefulWidget {

   UserProvider userProvider;
   DrawerSide({required this.userProvider});
  @override
  _DrawerSideState createState() => _DrawerSideState();
}

class _DrawerSideState extends State<DrawerSide> {
  Widget listTile({String? title, IconData? iconData,  final Function()? onTap}) {
    return Container(
      height: 50,
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          iconData,
          size: 28,
        ),
        title: Text(
          title!,
          style: TextStyle(color: Colors.black54),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
     var userData = widget.userProvider.currentUserData;
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 43,
                      backgroundColor: Colors.white54,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        /* backgroundImage: NetworkImage(
                       //   userData.userImage ??
                              "https://s3.envato.com/files/328957910/vegi_thumb.png",
                        ), */
                        radius: 40,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      /*  children: [
                        Text(userData.userName),
                        Text(
                          userData.userEmail,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],  */
                    )
                  ],
                ),
              ),
            ),
            listTile(
              iconData: Icons.home_outlined,
              title: "Home",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Home(),
                  ),
                );
              },
            ),
            listTile(
              iconData: Icons.shop_outlined,
              title: "Review Cart",
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                );
              },
            ),
            listTile(
              iconData: Icons.person_outlined,
              title: "My Profile",
                onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Profile(userProvider:widget.userProvider),
                  ),
                );
              },
            ),
            /*  listTile(
                iconData: Icons.notifications_outlined, title: "Notificatio"),
            listTile(iconData: Icons.star_outline, title: "Rating & Review"), */
            listTile(
              iconData: Icons.favorite_outline,
              title: "Wishlist",
            ),
            listTile(
              iconData: Icons.exit_to_app_outlined,
              title: "Sign Out",
              onTap: () async {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
                GoogleSignIn googleSignIn = GoogleSignIn();
                googleSignIn.signOut();
                FirebaseAuth.instance.signOut();
              },
            ),
            SizedBox(height: 50),
            /*   listTile(iconData: Icons.copy_outlined, title: "Raise a Complaint"),
            listTile(iconData: Icons.format_quote_outlined, title: "FAQs"), */
            Container(
              height: 350,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Contact Support"),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Call us:"),
                      SizedBox(
                        width: 10,
                      ),
                      Text("+8801729411139"),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Text("Mail us:"),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "teampantofar@gmail.com",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}