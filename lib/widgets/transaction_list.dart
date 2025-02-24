import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_app/models/trasaction.dart';

class TransactonList extends StatelessWidget{
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactonList(this.transactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 500,
      child: transactions.isEmpty ? Column(children: <Widget>[
        Text('No transaction added yet'),
        SizedBox(height: 10,),
        Container(height: 200, child:  Image.asset('assets/images/waiting.png',fit: BoxFit.cover,))
      ],) :
      ListView.builder(
          itemBuilder: (ctx,index){
            return Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 8,horizontal: 5),
              child: ListTile(leading: CircleAvatar(radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: FittedBox(child: Text('\$${transactions[index].amount}')),
                ),),
                title: Text(transactions[index].title,style: Theme.of(context).textTheme.titleMedium,),
                subtitle: Text(DateFormat.yMMMd().format(transactions[index].date)),
                trailing: IconButton(icon: Icon(Icons.delete),color: Colors.red,onPressed: () => deleteTx(transactions[index].id),),
              ),
            );
          },
          itemCount: transactions.length,


      ),
    );
  }
}
