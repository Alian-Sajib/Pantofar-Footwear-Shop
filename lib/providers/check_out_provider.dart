import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pantofar/models/delivery_address_model.dart';
import 'package:pantofar/models/review_cart_model.dart';

class CheckoutProvider with ChangeNotifier {
  bool isloadding = false;

  FToast fToast = FToast();
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 14.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.redAccent,
    ),
    child: Text("Some Field Missing"),
  );

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController postalcode = TextEditingController();

  /// LocationData setLoaction;

  void validator(context) async {
    if (firstName.text.isEmpty) {
      //Fluttertoast.showToast(msg: "Firstname is empty");
      fToast.showToast(
        child: toast,
      );
    } else if (lastName.text.isEmpty) {
      //  Fluttertoast.showToast(msg: "Lastname is empty");
      fToast.showToast(
        child: toast,
      );
    } else if (mobileNo.text.isEmpty) {
      // Fluttertoast.showToast(msg: "Mobile No is empty");
      fToast.showToast(
        child: toast,
      );
    } else if (address.text.isEmpty) {
      // Fluttertoast.showToast(msg: "Address is empty");
      fToast.showToast(
        child: toast,
      );
    } else if (city.text.isEmpty) {
      //Fluttertoast.showToast(msg: "City is empty");
      fToast.showToast(
        child: toast,
      );
    } else if (postalcode.text.isEmpty) {
      // Fluttertoast.showToast(msg: "Postal Code  is empty");
      fToast.showToast(
        child: toast,
      );
    } else {
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("DeliveryAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstname": firstName.text,
        "lastname": lastName.text,
        "mobileNo": mobileNo.text,
        "address": address.text,
        "city": city.text,
        "postalcode": postalcode.text,
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your deliver address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAddressList = [];

  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("DeliveryAddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        firstName: _db.get("firstname"),
        lastName: _db.get("lastname"),
        mobileNo: _db.get("mobileNo"),
        address: _db.get("address"),
        city: _db.get("city"),
        postalcode: _db.get("postalcode"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }

    deliveryAddressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAddressList;
  }
}
