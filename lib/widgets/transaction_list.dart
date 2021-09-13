import 'package:flutter/material.dart';
import 'package:taxis_colecter/widgets/transaction_item.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function removeItem;

  //Constructor
  TransactionList(this.transaction, this.removeItem);

  @override
  Widget build(BuildContext context) {
    return transaction.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: constraints.maxHeight * 0.2,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    '  Ops the transactions is empty..!!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                ),
                Container(
                  alignment: Alignment.center,
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (context, index) {
              return TransactionItem(transaction[index],removeItem(index));
            },
          );
  }
}
