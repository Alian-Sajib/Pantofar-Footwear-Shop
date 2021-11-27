import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pantofar/providers/user_provider.dart';
import 'drawer.dart';
import 'login_page.dart';

class Profile extends StatefulWidget {
  //const Profile({Key? key}) : super(key: key);

  UserProvider userProvider;

  Profile({required this.userProvider});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Color primaryColor = Color(0xffd1ad17);
  Color scaffoldBackgroundColor = Color(0xffcbcbcb);
  Color textColor = Colors.black87;

  @override
  Widget listTile(
      {required IconData icon, required String title, void Function()? onTap}) {
    return Column(
      children: [
        Divider(
          height: 1,
        ),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: onTap,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var userData = widget.userProvider.currentUserData;

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        elevation: 0.0,
        title: Text(
          "My Profile",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      drawer: DrawerSide(
        userProvider: widget.userProvider,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 60,
                color: Colors.black54,
              ),
              Container(
                height: 600,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 250,
                          height: 80,
                          padding: EdgeInsets.only(left: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    userData!.userName,
                                    // 'Alian Sajib',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: textColor),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(userData.userEmail),
                                ],
                              ),
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: textColor,
                                child: CircleAvatar(
                                  radius: 12,
                                  child: Icon(
                                    Icons.edit,
                                    color: textColor,
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    listTile(
                      icon: Icons.shop_outlined,
                      title: "My Orders",
                      onTap: () {},
                    ),
                    listTile(
                      icon: Icons.location_on_outlined,
                      title: "My Delivery Address",
                      onTap: () {},
                    ),
                    // listTile(
                    //     icon: Icons.person_outline, title: "Refer A Friends"),
                    // listTile(
                    //     icon: Icons.file_copy_outlined,
                    //     title: "Terms & Conditions"),
                    // listTile(
                    //     icon: Icons.policy_outlined, title: "Privacy Policy"),
                    // listTile(icon: Icons.add_chart, title: "About")

                    listTile(
                      icon: Icons.exit_to_app_outlined,
                      title: "Log Out",
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
                  ],
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 30),
            child: CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor,
              child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    userData.userImage,
                  ),
                  radius: 45,
                  backgroundColor: scaffoldBackgroundColor),
            ),
          )
        ],
      ),
    );
  }
}
