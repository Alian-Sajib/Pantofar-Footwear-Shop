import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:pantofar/providers/check_out_provider.dart';
import 'package:pantofar/providers/review_cart_provider.dart';
import 'package:pantofar/widgets/bkashPayFieldsTitle&Value.dart';
import 'package:provider/provider.dart';

import '../models/delivery_address_model.dart';
import 'order_confirm.dart';

class BkashPay extends StatefulWidget {
  String firstName;
  String lastName;
  String address;
  String mobileNo;
  String city;
  String postalCode;

  BkashPay({
    required this.firstName,
    required this.lastName,
    required this.mobileNo,
    required this.address,
    required this.city,
    required this.postalCode,
  });

  @override
  State<BkashPay> createState() => _BkashPayState();
}

class _BkashPayState extends State<BkashPay> {
  var get_otp_clicked = 0, otp_verified = 0;

  void optVerified() {
    setState(() {
      otp_verified = 1;
    });
  }

  void getOTPclicked() {
    setState(() {
      get_otp_clicked = 1;
    });
  }
  secureScreen () async{
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_KEEP_SCREEN_ON);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    secureScreen();
  }

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();

    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();

    int totalPrice = reviewCartProvider.getTotalPrice() + 100;
    var height = MediaQuery.of(context).size.height;

    void uploadOrderInfo() {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      for (int i = 0;
          i < reviewCartProvider.getReviewCartDataList.length;
          i++) {
        firebaseFirestore
            .collection("OnlineOrderInfo")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection("Order Serial Id")
            .doc()
            .set({
          "id": reviewCartProvider.getReviewCartDataList[i].cartId,
          "quantity": reviewCartProvider.getReviewCartDataList[i].cartQuantity,
          "price": reviewCartProvider.getReviewCartDataList[i].cartPrice,
          "size": reviewCartProvider.getReviewCartDataList[i].cartSize,
        });
      }
      //delivery list...
      FirebaseFirestore.instance
          .collection("OnlineOrderInfo")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstname": widget.firstName,
        "lastname": widget.lastName,
        "mobileNo": widget.mobileNo,
        "address": widget.address,
        "city": widget.city,
        "postalcode": widget.postalCode,
      });

      for (int i = 0;
          i < reviewCartProvider.getReviewCartDataList.length;
          i++) {
        reviewCartProvider.reviewCartDataDelete(
            reviewCartProvider.getReviewCartDataList[i].cartId);
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ConfirmOrder(),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        floatingActionButton: Visibility(
          visible: otp_verified == 0 ? false : true,
          child: FloatingActionButton(
            onPressed: () {
              uploadOrderInfo();
            },
            isExtended: false,
            backgroundColor: Colors.pink,
            child: Text(
              'Pay',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //   Padding(
                //     padding: const EdgeInsets.fromLTRB(18, 18, 18, 0),
                //     // child: Text(
                //   'bKash Online Payment :',
                //   style: TextStyle(
                //       fontWeight: FontWeight.w900,
                //       fontSize: 25,
                //       color: Colors.black),
                // ),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(
                      image: AssetImage("assets/images/bkash_payment_logo.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // ),
                SizedBox(
                  height: height * .03,
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        // height: height * .5,
                        margin: EdgeInsets.all(11),
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(11)),
                        child: Padding(
                          padding: const EdgeInsets.all(7.0),
                          child: Column(
                            children: [
                              bkashPayFieldsTitleAndValueKey('Chosen Product:',
                                  'Pantofar Slides (Premium)'),
                              bkashPayFieldsTitleAndValueKey('Quantity:',
                                  '${reviewCartProvider.getReviewCartDataList.length} pcs.'),
                              // bkashPayFieldsTitleAndValueKey(
                              //     'price per piece:', 'BDT. ' + 575.toString()),
                              bkashPayFieldsTitleAndValueKey(
                                  'Total Price:', 'BDT. $totalPrice.00/='),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 9, 18, 5),
                        child: Text(
                          'bKash Phone Number:',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(11, 0, 11, 0),
                        child: TextField(
                          cursorColor: Colors.white,
                          textAlign: TextAlign.center,
                          autofocus: false,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            hintText: '01xxxxxxxxx',
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.w900,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            filled: true,
                            contentPadding: EdgeInsets.all(15),
                            fillColor: Colors.pink,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(11, 3, 11, 3),
                        child: MaterialButton(
                          onPressed: () {
                            get_otp_clicked == 0 ? getOTPclicked() : () {};
                          },
                          color: Colors.white,
                          elevation: 0,
                          child: Text(
                            'get OTP',
                            style: TextStyle(
                              fontSize: 17,
                              color: get_otp_clicked == 0
                                  ? Colors.black
                                  : Colors.black12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: get_otp_clicked == 0 ? false : true,
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: OtpTextField(
                            numberOfFields: 5,
                            borderColor: Colors.pink,
                            showFieldAsBox: true,
                            onCodeChanged: (String code) {},
                            onSubmit: (String verificationCode) {
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actions: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                            optVerified();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              'ok!',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 21),
                                            ),
                                          ),
                                        )
                                      ],
                                      title: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 7.0),
                                            child: Icon(
                                              Icons.done_all,
                                              color: Colors.pink,
                                              size: 27,
                                            ),
                                          ),
                                          Text("Verification Code"),
                                        ],
                                      ),
                                      content: Text(
                                          'Code entered is $verificationCode'),
                                    );
                                  });
                            }, // end onSubmit
                          ),
                        ),
                      ),
                      Visibility(
                        visible: otp_verified == 0 ? false : true,
                        child: Padding(
                          padding: const EdgeInsets.all(11.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            obscureText: true,
                            autofocus: false,
                            cursorColor: Colors.pink,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.password,
                                size: 15,
                                color: Colors.pink,
                              ),
                              alignLabelWithHint: false,
                              labelText: 'bKash PIN:',
                              hintText: '****',
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.pink, width: 1.9),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.pink, width: 1.9),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
