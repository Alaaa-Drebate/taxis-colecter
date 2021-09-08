import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function removeItem;

  //Constructor
  TransactionList(this.transaction,this.removeItem);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: transaction.isEmpty
          ? Column(
              children: [
                Text(
                  '  Ops the transactions is empty..!!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 250,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transaction.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: FittedBox(
                        child: Text(
                          '\$${transaction[index].amount}',
                        ),
                      ),
                    ),
                    title: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text('${transaction[index].title}'),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        DateFormat.yMMMd().format(transaction[index].date),
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_forever_rounded),
                      onPressed:()=>removeItem(index),
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
