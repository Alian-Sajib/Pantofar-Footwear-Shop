import 'package:flutter/material.dart';

class bkashPayFieldsTitleAndValueKey extends StatelessWidget {
  // const bkashPayFieldsTitleAndValueKey({Key? key}) : super(key: key);
  var title, value;

  bkashPayFieldsTitleAndValueKey(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.w900, color: Colors.black, fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 9.0),
          child: Text(
            value,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w400, color: Colors.black, fontSize: 17),
          ),
        ),
      ],
    );
  }
}
