import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget{
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime?  _selectedDate;

  void _submitData(){
    final enteredTitle = _titlecontroller.text;
    final enteredAmount = double.parse( _amountcontroller.text);

    if(enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null){
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate
    );

    Navigator.of(context).pop();
  }

  void _PresentDatePicker(){
    showDatePicker(context: context, firstDate: DateTime(2024), lastDate: DateTime.now()
    ).then((pickedDate){
      if (pickedDate == null){
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(decoration: InputDecoration(labelText: 'Tilte'),
              controller: _titlecontroller,
              onSubmitted: (_) => _submitData(),
            ),
            TextField(decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountcontroller,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(children: <Widget>[
                Text(_selectedDate == null
                    ? 'No Date Chosen'
                    : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                TextButton(onPressed: _PresentDatePicker,
                    child: Text('Chosse Date',
                      style: TextStyle(fontWeight: FontWeight.bold),))
              ],),
            ),
            ElevatedButton(
                onPressed: _submitData,
                child: Text('Add Transaction',
                    style: TextStyle(fontWeight: FontWeight.bold)))
          ],),
      ),
    );
  }}
