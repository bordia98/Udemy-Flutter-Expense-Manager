import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  DateTime dateoftrans;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || dateoftrans == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      dateoftrans
    );

    Navigator.of(context).pop();
  }

  void _presentdatepicker(){
    showDatePicker(
      context: context , 
      initialDate: DateTime.now(),
      firstDate: DateTime(2019), 
      lastDate: DateTime.now()
    ).then((pickeddate){
      if ( pickeddate == null){
        return;
      }

      setState(() {
        dateoftrans = pickeddate;      
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    dateoftrans == null ? "No date choosen" : DateFormat.yMd().format(dateoftrans),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    color: Colors.white,
                    onPressed: _presentdatepicker,
                  )
                 ],
              ),
            ),
            FlatButton(
              child: Text('Add Transaction', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: submitData,
            ),
          ],
        ),
      ),
    );
  }
}