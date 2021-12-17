import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pantofar/providers/review_cart_provider.dart';
import 'package:provider/provider.dart';

class SingleItem extends StatefulWidget {
  bool isBool = false;
  String productImage;
  String productName;
  String productSize;
  bool wishList = false;
  int productPrice;
  String productId;
  int productQuantity;
  void Function() onDelete;

  SingleItem(
      {required this.productQuantity,
      required this.productId,
      required this.productSize,
      required this.onDelete,
      required this.isBool,
      required this.productImage,
      required this.productName,
      required this.productPrice,
      required this.wishList});

  @override
  _SingleItemState createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  late ReviewCartProvider reviewCartProvider;

 // Color primaryColor = Color(0xffd1ad17);
 // Color scaffoldBackgroundColor = Color(0xffcbcbcb);
   Color textColor = Colors.black87;

  @override
  Widget build(BuildContext context) {
    reviewCartProvider = Provider.of<ReviewCartProvider>(context);
    reviewCartProvider.getReviewCartData();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 90,
                  child: Center(
                    child: Image.network(
                      widget.productImage,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 100,
                  child: Column(
                    mainAxisAlignment: widget.isBool == false
                        ? MainAxisAlignment.spaceAround
                        : MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.productName,
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            "Price: ${widget.productPrice}/=",
                            style: TextStyle(
                                color: textColor, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text(
                        "Size: ${widget.productSize}",
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        "Quantity: ${widget.productQuantity}",
                        style: TextStyle(
                            color: textColor, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 90,
                  child: Row(
                    children: [
                      SizedBox(width: 60),
                      InkWell(
                        onTap: widget.onDelete,
                        child: Icon(
                          Icons.delete_rounded,
                          size: 30,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        widget.isBool == false
            ? Container()
            : Divider(
                height: 1,
                color: Colors.black45,
              )
      ],
    );
  }
}
