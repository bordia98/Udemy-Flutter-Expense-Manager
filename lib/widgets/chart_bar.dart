import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Bar extends StatelessWidget {
  
  final String label; 
  final double amount;
  final double percent;

  Bar({
    @required this.label,
    @required this.amount,
     @required this.percent
  });

  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FittedBox(child: 
          Text("Rs. ${amount.toStringAsFixed(0)}"),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          margin: EdgeInsets.all(10),
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  ),
              ),
              FractionallySizedBox(
                
                heightFactor: percent,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}