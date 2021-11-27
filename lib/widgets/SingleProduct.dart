import 'package:flutter/material.dart';

class SingleProduct extends StatefulWidget {
  final String productImage;
  final String productName;
  final int productPrice;
  final void Function() onTap;

  //final Function onTap;
  //final String productId;
  //final ProductModel productUnit;

  SingleProduct({

    required this.productImage,
    required this.productName,
    required this.productPrice,
    required this.onTap,
  });

  @override
  _SingleProductState createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  var unitData;
  var firstValue;

  @override
  Widget build(BuildContext context) {
    /* widget.productUnit.productUnit.firstWhere((element) {
      setState(() {
        firstValue = element;
      });
      return true;
    });*/
    /*var width = MediaQuery
        .of(context)
        .size
        .width * .5;*/

    return Card(
      color: Color(0xffd9dad9),
      semanticContainer: true,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 11,
      margin: EdgeInsets.all(0),
      child: Stack(
        children: [
        GestureDetector(
        onTap: widget.onTap,
        child: Container(
          // Container(
          height: 125,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                widget.productImage,
              ),
            ),
          ),
        ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              color: Colors.black,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.productName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 8.0),
                    child: Text(
                      'Price : ${widget.productPrice} /=',
                      /* '\$/${unitData == null ? firstValue : unitData}',*/
                      style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )
        ],
      ),
    );
    // Column(
    //   children: [
    //     Text(
    //       widget.productName,
    //       style: TextStyle(
    //         color: Colors.black,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //     Text(
    //       'Price : ${widget.productPrice}',
    //       /* '\$/${unitData == null ? firstValue : unitData}',*/
    //       style: TextStyle(
    //         color: Colors.black,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //   ],
    // );

    // return Column(children: [
    //   Container(
    //     margin: EdgeInsets.only(right: 10),
    //     height: 230,
    //     width: 165,
    //     decoration: BoxDecoration(
    //       color: Color(0xffd9dad9),
    //       // color: Colors.blueGrey,
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //     child: Expanded(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Expanded(
    //             child: GestureDetector(
    //               //onTap: widget.onTap(),
    //               child: Expanded(
    //                 child: Container(
    //                   height: 160,
    //                   width: double.infinity,
    //                   padding: EdgeInsets.all(5),
    //                   decoration: BoxDecoration(
    //                     image: DecorationImage(
    //                       fit: BoxFit.cover,
    //                       image: NetworkImage(
    //                         widget.productImage,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Padding(
    //             padding:
    //                 const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 Text(
    //                   widget.productName,
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 5,
    //                 ),
    //                 Text(
    //                   'Price : ${widget.productPrice}',
    //                   /* '\$/${unitData == null ? firstValue : unitData}',*/
    //                   style: TextStyle(
    //                     color: Colors.black,
    //                     fontWeight: FontWeight.bold,
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ]);
  }
}
