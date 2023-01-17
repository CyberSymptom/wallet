import 'package:flutter/material.dart';

import 'budget.dart';

class Progressbar extends StatelessWidget {
  final double totalPercentage;

  Progressbar(this.totalPercentage);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      height: 5.0,
      decoration: BoxDecoration(
        color: Color.fromRGBO(212, 219, 239, 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: FractionallySizedBox(
        heightFactor: 2,
        widthFactor: totalPercentage / 100,
        child: Container(
          width: double.infinity,
          height: 10,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.blue.shade900,
              Colors.blue,
              Colors.blue.shade200,
              Colors.blue,
            ]),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.shade900,
                blurRadius: 10,
                spreadRadius: -1,
              )
            ],
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
