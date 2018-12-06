import 'package:Corey/ui/body/body_dream_weight_widget.dart';
import 'package:Corey/ui/body/body_info_widget.dart';
import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          BodyInfoWidget(),
          BodyDreamWeightWidget(),
        ],
      ),
    );
  }
}
