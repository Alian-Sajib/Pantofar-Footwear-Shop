import 'package:flutter/material.dart';

class SingleDeliveryItem extends StatelessWidget {
  final String title;
  final String address;
  final String number;

  SingleDeliveryItem(
      {required this.title, required this.address, required this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title,style: TextStyle(color: Colors.black, fontSize: 20)),
          leading: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.green,
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(address,style: TextStyle(color: Colors.black, fontSize: 16)),
              SizedBox(
                height: 5,
              ),
              Text("Phone: $number",style: TextStyle(color: Colors.black, fontSize: 16)),
            ],
          ),
        ),
        Divider(
          height: 40,
        ),
      ],
    );
  }
}
