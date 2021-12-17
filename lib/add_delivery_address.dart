import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/check_out_provider.dart';
import 'widgets/custom_text_field.dart';

class AddDeliverAddress extends StatefulWidget {
  @override
  _AddDeliverAddressState createState() => _AddDeliverAddressState();
}

class _AddDeliverAddressState extends State<AddDeliverAddress> {
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          'Add Delivery Address',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        height: 48,
        child: checkoutProvider.isloadding == false
            ? MaterialButton(
                onPressed: () {
                  checkoutProvider.validator(context);
                },
                child: Text(
                  "Add Address",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: ListView(
          children: [
            CustomTextField(
              labText: "First name",
              controller: checkoutProvider.firstName, // keyboardType: null,
            ),
            CustomTextField(
              labText: "Last name",
              controller: checkoutProvider.lastName, //keyboardType: null,
            ),
            CustomTextField(
              labText: "Mobile No",
              controller: checkoutProvider.mobileNo, //keyboardType: null,
            ),
            CustomTextField(
              labText: "Address",
              controller: checkoutProvider.address, //keyboardType: null,
            ),
            CustomTextField(
              labText: "City",
              controller: checkoutProvider.city, // keyboardType: null,
            ),
            CustomTextField(
              labText: "Postal Code",
              controller: checkoutProvider.postalcode, //keyboardType: null,
            ),
          ],
        ),
      ),
    );
  }
}
