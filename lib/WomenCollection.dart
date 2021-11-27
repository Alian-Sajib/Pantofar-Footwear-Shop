import 'package:flutter/material.dart';
import 'package:pantofar/providers/user_provider.dart';
import 'package:pantofar/providers/women_product_provider.dart';
import 'package:provider/provider.dart';
import 'ProductOverview.dart';
import 'widgets/SingleProduct.dart';
import 'drawer.dart';

class Womens extends StatefulWidget {
  const Womens({Key? key}) : super(key: key);

  @override
  _WomensState createState() => _WomensState();
}

class _WomensState extends State<Womens> {

  late WomenProductProvider productProvider;

  Widget _buildWomensProduct(context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GridView.count(
            primary: true,
            padding: const EdgeInsets.all(10),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: productProvider.getWomensProductDataList.map(
                  (womensProductData) {
                return SingleProduct(
                  onTap :() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          productId: womensProductData.productId,
                          productName: womensProductData.productName,
                          productImage: womensProductData.productImage,
                          productPrice: womensProductData.productPrice,
                        ),
                      ),
                    );
                  },
                  productImage: womensProductData.productImage,
                  productName: womensProductData.productName,
                  productPrice: womensProductData.productPrice,
                );
              },
            ).toList(),
          ),
        ),

      ],
    );
  }

  @override
  void initState() {
    WomenProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchWomensProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    productProvider = Provider.of(context);
    UserProvider userProvider = Provider.of(context);
    userProvider.getUserData();

    return Scaffold(
      drawer: DrawerSide(
        userProvider: userProvider,
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Womens Collection',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: Container(
        child: _buildWomensProduct(context),
      ),
    );
  }
}
