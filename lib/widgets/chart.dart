import 'package:expense_app/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_app/models/trasaction.dart';

class chart extends StatelessWidget{
  final List<Transaction> recentTransaction;

  chart(this.recentTransaction);

  List<Map<String,Object>> get groupedTransactionvalues{
    return List.generate(7, (index){
      final weekDay = DateTime.now().subtract(Duration(days: index),);
      var totalSum =0.0;

      for(var i = 0; i<recentTransaction.length;i++){
        if(recentTransaction[i].date.day == weekDay.day &&
        recentTransaction[i].date.month == weekDay.month &&
        recentTransaction[i].date.year == weekDay.year ){
          totalSum += recentTransaction[i].amount;
        }
      }



      return {
        'DAY':DateFormat.E().format(weekDay).substring(0,1),'amount': totalSum,
      };
    }).reversed.toList();
  }

  double get maxSpending{
    return groupedTransactionvalues.fold(0.0,(sum,item){
      return sum + (item['amount']as double);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(children: groupedTransactionvalues.map((data){
          return  Flexible(
            fit: FlexFit.tight,
            child: ChartBar(
                (data['DAY']as String),
                (data['amount']as double),
                maxSpending == 0.0 ? 0.0 : (data['amount'] as double )/maxSpending),
          );
        }).toList(),),
      ),
    );
  }
}