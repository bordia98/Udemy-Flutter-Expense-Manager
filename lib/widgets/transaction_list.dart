import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';


class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetrans;

  TransactionList(this.transactions,this.deletetrans);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  child: Card(
                  elevation: 5, 
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 40,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        child: FittedBox(
                          child: 
                            Text(
                              'Rs. ${transactions[index].amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                                ),
                            ),
                        ),
                      ) 
                    ),
                    title: Text(
                        "${transactions[index].title}",
                        style: Theme.of(context).textTheme.title
                      ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                      style: TextStyle(
                        color: Colors.grey,
                        ),
                      ),
                      trailing: FlatButton(
                        child: Icon(
                          Icons.delete,
                          color: Theme.of(context).errorColor,
                        ),
                        color: Colors.white,
                        onPressed: ()=> deletetrans(transactions[index].id),
                      ),
                    )
                  )
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
