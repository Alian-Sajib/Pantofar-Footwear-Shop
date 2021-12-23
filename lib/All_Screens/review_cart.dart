import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pantofar/providers/review_cart_provider.dart';
import 'package:pantofar/widgets/SingleItem.dart';
import 'package:provider/provider.dart';
import '../Checkout_Screens/delivery_details.dart';
import '../models/review_cart_model.dart';

class ReviewCart extends StatefulWidget {
  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  late ReviewCartProvider reviewCartProvider;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.redAccent,
    ),
    child: Text("No Review Cart Item"),
  );

  showAlertDialog(BuildContext context, ReviewCartModel delete) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        reviewCartProvider.reviewCartDataDelete(delete.cartId);
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Cart Product"),
      content: Text("Are you want to delete cartProduct?"),
      actions: [
        cancelButton,
        continueButton,
      ],
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
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();

    return Scaffold(
        bottomNavigationBar: ListTile(
          title: Text(
            'Total Amount :',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(
            '${reviewCartProvider.getTotalPrice()}.00/=',
            style: TextStyle(
              color: Colors.green[900],
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          trailing: Container(
            width: 160,
            child: MaterialButton(
              child: Text(
                'Order Now',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              ),
              color: Colors.black87,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              onPressed: () {
                if (reviewCartProvider.getReviewCartDataList.isEmpty) {
                  //  Fluttertoast.showToast(msg: "No Cart Data Found");
                  return fToast.showToast(
                    child: toast,
                  );
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DeliveryDetails(),
                  ),
                );
              },
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text(
            "Review Cart",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: reviewCartProvider.getReviewCartDataList.isEmpty
            ? Center(
                child: Text("NO ITEM"),
              )
            : ListView.builder(
                itemCount: reviewCartProvider.getReviewCartDataList.length,
                itemBuilder: (context, index) {
                  ReviewCartModel data =
                      reviewCartProvider.getReviewCartDataList[index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      SingleItem(
                        isBool: true,
                        wishList: false,
                        productImage: data.cartImage,
                        productName: data.cartName,
                        productPrice: data.cartPrice,
                        productId: data.cartId,
                        productQuantity: data.cartQuantity,
                        productSize: data.cartSize,
                        onDelete: () {
                          showAlertDialog(context, data);
                        },
                      ),
                    ],
                  );
                },
              ));
  }
}
