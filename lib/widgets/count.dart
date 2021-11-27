import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pantofar/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class Count extends StatefulWidget {
  // String productName;
  // String productImage;
  // String productId;
  // int productPrice;
  // String productSize;
 // int productQuantity;

//  Count({
    // required this.productName,
    // required this.productSize,
    // required this.productId,
    // required this.productImage,
    // required this.productPrice,
  //  required this.productQuantity,
//  });

  @override
  _CountState createState() => _CountState();
}

class _CountState extends State<Count> {
  int count = 1;
  bool isTrue = false;

  @override
  Widget build(BuildContext context) {
    //  getAddAndQuantity();
    ReviewCartProvider reviewCartProvider = Provider.of(context);
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
}
