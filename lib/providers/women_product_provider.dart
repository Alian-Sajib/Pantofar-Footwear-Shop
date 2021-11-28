import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pantofar/models/product_model.dart';

class WomenProductProvider with ChangeNotifier {
  late ProductModel productModel;

  List<ProductModel> womensProductList = [];

  fatchWomensProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
    await FirebaseFirestore.instance.collection("WomensProduct").get();

    value.docs.forEach(
          (element) {
        // productModel(element);
        // newList.add(productModel);
        //  print(element.data());
        productModel = ProductModel(

          productId: element.get("productId"),
          productName: element.get("productName"),
          productPrice: element.get("productPrice"),
          productImage: element.get("productImage"),

        );
        newList.add(productModel);
      },
    );
    womensProductList = newList;
    notifyListeners();
  }
  List<ProductModel>  get getWomensProductDataList{
    return womensProductList;
  }
}