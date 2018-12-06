import 'package:flutter/material.dart';

class BodyDreamWeightWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(8),
        child: Container(
          padding: EdgeInsets.all(16),
          child: Text("Dream weight card"),
        ),
      ),
    );
  }
}
