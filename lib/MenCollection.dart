import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pantofar/providers/men_product_provider.dart';
import 'package:pantofar/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'ProductOverview.dart';
import 'widgets/SingleProduct.dart';
import 'drawer.dart';

class Mens extends StatefulWidget {
  const Mens({Key? key}) : super(key: key);

  @override
  _MensState createState() => _MensState();
}

class _MensState extends State<Mens> {
  late ProductProvider productProvider;

  Widget _buildMensProduct(context) {
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
            children: productProvider.getMensProductDataList.map(
                  (mensProductData) {
                return SingleProduct(
                    onTap :() {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                          builder: (context) => ProductOverview(
                            productId: mensProductData.productId,
                            productName: mensProductData.productName,
                            productImage: mensProductData.productImage,
                            productPrice: mensProductData.productPrice,
                          ),
                          ),
                      );
                    },
                  productImage: mensProductData.productImage,
                  productName: mensProductData.productName,
                  productPrice: mensProductData.productPrice,
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
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fatchMensProductData();
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
          'Mens Collection',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      body: Container(
        child: _buildMensProduct(context),
      ),
    );
  }
}
