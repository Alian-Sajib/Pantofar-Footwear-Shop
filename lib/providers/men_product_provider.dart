import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:pantofar/models/product_model.dart';

class ProductProvider with ChangeNotifier {

  late ProductModel productModel;
  List<ProductModel> mensProductList = [];

    fatchMensProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
    await FirebaseFirestore.instance.collection("MensProduct").get();

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
    mensProductList = newList;
    notifyListeners();
  }
   List<ProductModel>  get getMensProductDataList{
    return mensProductList;
  }
}