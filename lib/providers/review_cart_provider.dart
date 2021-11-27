import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:pantofar/models/review_cart_model.dart';


class ReviewCartProvider with ChangeNotifier {
  void addReviewCartData({
    required String cartId,
    required String cartName,
    required String cartImage,
    required int cartPrice,
    required int cartQuantity,
    required cartSize,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("UserReviewCart")
        .doc(cartId)
        .set(
      {
        "cartId": cartId,
        "cartSize":cartSize,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "isAdd":true,
      },
    );
  }


  void updateReviewCartData({
    required String cartId,
    required String cartName,
    required String cartImage,
    required int cartPrice,
    required int cartQuantity,
  }) async {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("UserReviewCart")
        .doc(cartId)
        .update(
      {
        "cartId": cartId,
        "cartName": cartName,
        "cartImage": cartImage,
        "cartPrice": cartPrice,
        "cartQuantity": cartQuantity,
        "isAdd":true,
      },
    );
  }

  List<ReviewCartModel> reviewCartDataList = [];
  void getReviewCartData() async {
    List<ReviewCartModel> newList = [];

    QuerySnapshot reviewCartValue = await FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("UserReviewCart")
        .get();
    reviewCartValue.docs.forEach((element) {
      ReviewCartModel reviewCartModel = ReviewCartModel(
        cartId: element.get("cartId"),
        cartSize: element.get("cartSize"),
        cartImage: element.get("cartImage"),
        cartName: element.get("cartName"),
        cartPrice: element.get("cartPrice"),
        cartQuantity: element.get("cartQuantity"),

      );
      newList.add(reviewCartModel);
    });
    reviewCartDataList = newList;
    notifyListeners();
  }

  List<ReviewCartModel> get getReviewCartDataList {
    return reviewCartDataList;
  }


//// TotalPrice  ///
//
  getTotalPrice(){
    double total = 0.00;
    reviewCartDataList.forEach((element) {
      total += element.cartPrice * element.cartQuantity;
    });
    return total;
  }


////////////// ReviCartDeleteFunction ////////////
  reviewCartDataDelete(cartId) {
    FirebaseFirestore.instance
        .collection("ReviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("UserReviewCart")
        .doc(cartId)
        .delete();
    notifyListeners();
  }
}