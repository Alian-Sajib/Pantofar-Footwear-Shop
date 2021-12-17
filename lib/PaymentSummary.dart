import 'package:flutter/material.dart';
import 'package:pantofar/delivery_details.dart';
import 'package:provider/provider.dart';
import 'models/delivery_address_model.dart';
import 'providers/review_cart_provider.dart';
import 'widgets/order_item.dart';
import 'widgets/single_delivery_item.dart';

class PaymentSummary extends StatefulWidget {
  final DeliveryAddressModel deliverAddressList;

  PaymentSummary({required this.deliverAddressList});

  @override
  _PaymentSummaryState createState() => _PaymentSummaryState();
}

enum PaymentTypes {
  CashOn,
  OnlinePayment,
}

class _PaymentSummaryState extends State<PaymentSummary> {
  var myType = PaymentTypes.CashOn;

  @override
  Widget build(BuildContext context) {
    ReviewCartProvider reviewCartProvider = Provider.of(context);
    reviewCartProvider.getReviewCartData();
    double totalPrice = reviewCartProvider.getTotalPrice() + 100;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          'Payment Summary',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      bottomNavigationBar: ListTile(
        title: Text(
          "Total Amount",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
        subtitle: Text(
          "${totalPrice}/=",
          style: TextStyle(
            color: Colors.green[900],
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        trailing: Container(
          width: 160,
          child: MaterialButton(
            onPressed: () {
              myType == PaymentTypes.OnlinePayment
                  ? Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DeliveryDetails(
                            //    total: totalPrice,
                            ),
                      ),
                    )
                  : Container();
            },
            child: Text(
              "Place Order",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            color: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                SingleDeliveryItem(
                  address:
                      "Address :  ${widget.deliverAddressList.address} \nCity :      ${widget.deliverAddressList.city}"
                      "\nPostal Code :  ${widget.deliverAddressList.postalcode}",
                  title:
                      "${widget.deliverAddressList.firstName} ${widget.deliverAddressList.lastName}",
                  number: widget.deliverAddressList.mobileNo,
                ),
                ExpansionTile(
                  children: reviewCartProvider.getReviewCartDataList.map((e) {
                    return OrderItem(
                      e: e,
                    );
                  }).toList(),
                  title: Text(
                    "Order Items ${reviewCartProvider.getReviewCartDataList.length}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Sub Total",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Text(
                    "${totalPrice - 100}/=",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  minVerticalPadding: 5,
                  leading: Text(
                    "Shipping Charge",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  trailing: Text(
                    "100/=",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Text(
                    "Payment Options",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                RadioListTile(
                  value: PaymentTypes.CashOn,
                  groupValue: myType,
                  title: Text(
                    "Cash On Delivery",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onChanged: (PaymentTypes? value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                  secondary: Icon(
                    Icons.home,
                    color: Colors.black87,
                  ),
                ),
                Divider(),
                RadioListTile(
                  value: PaymentTypes.OnlinePayment,
                  groupValue: myType,
                  title: Text(
                    "Online Payment",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onChanged: (PaymentTypes? value) {
                    setState(() {
                      myType = value!;
                    });
                  },
                  secondary: Icon(
                    Icons.devices_other,
                    color: Colors.black87,
                  ),
                ),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }
}
