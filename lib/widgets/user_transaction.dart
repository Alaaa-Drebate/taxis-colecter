// import 'package:flutter/material.dart';
// import '../models/transaction.dart';
// import './transaction_list.dart';
//
// import 'new_transaction.dart';
//
// class UserTransaction extends StatefulWidget {
//   @override
//   _UserTransactionState createState() => _UserTransactionState();
// }
//
// class _UserTransactionState extends State<UserTransaction> {
//   final List<Transaction> _userTransactions = [
//     Transaction(
//       id: 1,
//       title: 'the first title',
//       amount: 3.9,
//       date: DateTime.now(),
//     ),
//     Transaction(
//       id: 2,
//       title: 'the second title',
//       amount: 100,
//       date: DateTime.now(),
//     ),
//   ];
//
//   void _addNewTransaction(String txTitle,double txAmount){
//     final tx = Transaction(id: DateTime.now().microsecond, title: txTitle, amount: txAmount, date: DateTime.now());
//     setState(() {
//       _userTransactions.add(tx);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         NewTransaction(_addNewTransaction),
//         TransactionList(_userTransactions),
//       ],
//     );
//   }
// }
