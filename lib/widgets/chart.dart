import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './chart_bar.dart';
import '../models/transaction.dart';
 

class Chart extends StatelessWidget{

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List <Map<String,Object>> get groupedTransactionValues{
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days: index)); 

      double sum=0;
      for(var i = 0; i< recentTransactions.length;i++){
        if(recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year
          ){
            sum += recentTransactions[i].amount;
          }
      }

      print( DateFormat.E().format(weekDay));
      print(sum);

      return {
         'day' :DateFormat.E().format(weekDay) ,
         'amount':sum
         };
    }).reversed.toList();
  }

  double get maxspending{
    return groupedTransactionValues.fold(0.0, (sum,item){
        return sum += item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues); 
    return Card(
      elevation: 10,
      margin: EdgeInsets.all(10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransactionValues.map((data){
              return Flexible(
                fit: FlexFit.tight,
                child: Bar(
                label: data['day'],
                amount: data['amount'], 
                percent: maxspending == 0? 0.0 : (data['amount'] as double) / maxspending)
              );  
          }).toList(),
        ),
      ), 
    );
  }
}