import 'package:flutter/material.dart';
import 'package:pantofar/providers/check_out_provider.dart';
import 'package:provider/provider.dart';
import 'PaymentSummary.dart';
import 'add_delivery_address.dart';
import '../models/delivery_address_model.dart';
import '../widgets/single_delivery_item.dart';

class ProfileDeliveryDetails extends StatefulWidget {
  @override
  _ProfileDeliveryDetailsState createState() => _ProfileDeliveryDetailsState();
}

class _ProfileDeliveryDetailsState extends State<ProfileDeliveryDetails> {
  late DeliveryAddressModel value;

  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: Text(
          'Delivery Address',
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddDeliverAddress(),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Deliver To",
                style: TextStyle(color: Colors.black, fontSize: 18)),
          ),
          Divider(
            height: 1,
          ),
          deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Center(
                  child: Container(
                    child: Center(
                      child: Text("No Data"),
                    ),
                  ),
                )
              : Column(
                  children: deliveryAddressProvider.getDeliveryAddressList
                      .map<Widget>((e) {
                    setState(() {
                      value = e;
                    });
                    return SingleDeliveryItem(
                      address:
                          "Address : ${e.address}, \nCity :   ${e.city} \nPostal Code : ${e.postalcode}",
                      title: "${e.firstName} ${e.lastName}",
                      number: e.mobileNo,
                    );
                  }).toList(),
                )
        ],
      ),
    );
  }
}
