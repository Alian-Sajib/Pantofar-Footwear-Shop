import 'package:flutter/material.dart';
import 'package:pantofar/models/review_cart_model.dart';

class OrderItem extends StatelessWidget {
  final ReviewCartModel e;

  OrderItem({required this.e});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        e.cartImage,
        width: 60,
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            e.cartName,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "${e.cartPrice}/=",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      subtitle: Text(

          "Quantity : ${ e.cartQuantity.toString()}",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
