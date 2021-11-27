import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pantofar/providers/review_cart_provider.dart';
import 'package:pantofar/review_cart.dart';
import 'package:pantofar/widgets/count.dart';
import 'package:provider/provider.dart';
import 'home.dart';

enum SinginCharacter { fill, outline }

class ProductOverview extends StatefulWidget {
  // const ProductOverview({Key? key, required this.productName, required this.productImage, required this.productPrice}) : super(key: key);

  String productName;
  String productImage;
  int productPrice;
  String productId;

  ProductOverview({
    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.productId,
  });

  @override
  _ProductOverviewState createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  Color primaryColor = Color(0xffd1ad17);
  Color scaffoldBackgroundColor = Color(0xffcbcbcb);
  Color textColor = Colors.black87;
  String dropdownValue = '39';
  bool isTrue = false;
  int count = 1;

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Item Added To Cart"),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget Count(context) {
    //  getAddAndQuantity();
   // ReviewCartProvider reviewCartProvider = Provider.of(context);
    return Container(
      height: 35,
      width: 90,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black87),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              if (count == 1) {
                setState(() {
                  count = 1;
                });
                //reviewCartProvider.reviewCartDataDelete(widget.productId);
              } else if (count > 1) {
                setState(() {
                  count--;
                });
                // reviewCartProvider.updateReviewCartData(
                //   cartId: widget.productId,
                //   cartImage: widget.productImage,
                //   cartName: widget.productName,
                //   cartPrice: widget.productPrice,
                //   cartQuantity: count,
                // ),
              }
            },
            child: Icon(
              Icons.remove,
              size: 22,
              color: Colors.black87,
            ),
          ),
          Text(
            " $count ",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                count++;
              });
              // reviewCartProvider.updateReviewCartData(
              //   cartId: widget.productId,
              //   cartImage: widget.productImage,
              //   cartName: widget.productName,
              //   cartPrice: widget.productPrice,
              //   cartQuantity: count,
              //);
            },
            child: Icon(
              Icons.add,
              size: 22,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  getAddAndQuantity() {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("UserReviewCart")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            if (this.mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      count = value.get("cartQuantity");
                      isTrue = value.get("isAdd");
                    })
                  }
              }
          },
        );
  }

  Widget bottomNavigatorBar({
    required Color iconColor,
    required Color backgroundColor,
    required Color color,
    required String title,
    required IconData iconData,
    required void Function() onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          color: backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 22,
                color: iconColor,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                title,
                style: TextStyle(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool wishListBool = false;

  @override
  Widget build(BuildContext context) {
   // getAddAndQuantity();
    ReviewCartProvider reviewCartProvider = Provider.of(context);

    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          bottomNavigatorBar(
              backgroundColor: Colors.black,
              color: Colors.white70,
              iconColor: Colors.grey,
              title: "Add To Cart",
              iconData: wishListBool == false
                  ? Icons.shopping_cart_outlined
                  : Icons.favorite,
              onTap: () {
                // setState(() {
                //   wishListBool = !wishListBool;
                // });
                // if (wishListBool == true) {
                //   wishListProvider.addWishListData(
                //     wishListId: widget.productId,
                //     wishListImage: widget.productImage,
                //     wishListName: widget.productName,
                //     wishListPrice: widget.productPrice,
                //     wishListQuantity: 2,
                //
                //   );
                // } else {
                //   wishListProvider.deleteWishtList(widget.productId);
                // }
                  reviewCartProvider.addReviewCartData(
                  cartId: widget.productId,
                  cartImage: widget.productImage,
                  cartName: widget.productName,
                  cartPrice: widget.productPrice,
                  cartQuantity: count,
                  cartSize: dropdownValue,
                );
                  showAlertDialog(context);
              }),
          bottomNavigatorBar(
              backgroundColor: Color(0xffffd878),
              color: Colors.black87,
              iconColor: Colors.black87,
              title: "Go To Cart",
              iconData: Icons.shop_outlined,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReviewCart(),
                  ),
                );
              }),
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Product Overview",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children:[
                  //     Text(
                  //       "${widget.productName}",
                  //       style: TextStyle(
                  //         color: Colors.black87,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //     Text(
                  //       "Price : ${widget.productPrice}",
                  //       style: TextStyle(
                  //         color: Colors.black87,
                  //         fontWeight: FontWeight.w600,
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //
                  //   ]
                  // ),
                  ListTile(
                    title: Text(
                      "${widget.productName}",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      "Price : ${widget.productPrice}",
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    height: 230,
                    width: double.infinity,
                    // padding: EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage(
                          widget.productImage,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    width: double.infinity,
                    child: Text(
                      "Available Options",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          Text(
                            "   Sizes :     ",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                            },
                            items: <String>['39', '40', '41', '42']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ]),
                        Count(context),
                        // Count(
                        //   productId: widget.productId,
                        //   productImage: widget.productImage,
                        //   productName: widget.productName,
                        //   productPrice: widget.productPrice,
                        //   productUnit: '500 Gram',
                        //  ),

                        // Container(
                        //   padding: EdgeInsets.symmetric(
                        //     horizontal: 30,
                        //     vertical: 10,
                        //   ),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //       color: Colors.black,
                        //     ),
                        //     borderRadius: BorderRadius.circular(
                        //       30,
                        //     ),
                        //   ),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.center,
                        //     children: [
                        //       Icon(
                        //         Icons.add,
                        //         size: 17,
                        //         color: Colors.black87,
                        //       ),
                        //       Text(
                        //         "ADD",
                        //         style: TextStyle(color: Colors.black87),
                        //       )
                        //
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          // SizedBox(height: 20),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: ListView(
                children: [
                  Text(
                    "About This Product",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Designed in a textured black leather, these loafers are perfect to stand out in a crowd. Each pair is handcrafted using finest leather with padded footbed for all day comfort\n\n"
                    '-> Handcrafted in Bangladesh Material\n ->Genuine Leatherle',
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
        ],
      ),
    );
  }
}
