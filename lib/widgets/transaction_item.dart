import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taxis_colecter/models/transaction.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function removeItem;
  
  TransactionItem(this.transaction,this.removeItem);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
      elevation: 5,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)),
      child: ListTile(
        leading: CircleAvatar(
          child: FittedBox(
            child: Text(
              '\$${transaction.amount}',
            ),
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text('${transaction.title}'),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            DateFormat.yMMMd().format(transaction.date),
          ),
        ),
        trailing:MediaQuery.of(context).size.width > 460 ? TextButton.icon(
          label: Text(
            'Delete item',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
          icon: Icon(
            Icons.delete_forever_rounded,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () => removeItem,
        ): IconButton(
          icon: Icon(
            Icons.delete_forever_rounded,
            color: Theme.of(context).errorColor,
          ),
          onPressed: () => removeItem,
        ),
      ),
    );
  }
}
