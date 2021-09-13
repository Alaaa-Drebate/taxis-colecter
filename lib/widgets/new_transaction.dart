import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  //Constructor
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _timePicked;

  bool isNumeric(string) {
    // Null or empty string is not a number
    if (string == null || string.isEmpty) {
      return false;
    }

    final number = num.tryParse(string);

    if (number == null) {
      return false;
    }

    return true;
  }

  void _submitTransaction() {
    String titleText = titleController.text;
    String amountNumber = amountController.text;

    if (amountNumber.isEmpty ||
        titleText.isEmpty ||
        !isNumeric(amountNumber) ||
        _timePicked == null) {
      return;
    }

    widget.addTx(titleText, double.parse(amountNumber), _timePicked);
    Navigator.pop(context);
  }

  void _selectDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime(2022),
    ).then((time) {
      setState(() {
        _timePicked = time;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.only(left: 10, top: 10, right: 10, bottom:MediaQuery.of(context).viewInsets.bottom+10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: amountController,
                onSubmitted: (_) => _submitTransaction(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                          _timePicked == null
                              ? 'No date chosen !!'
                              : 'Picked date : ${DateFormat.yMd().format(
                              _timePicked!)}'),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: _selectDate,
                        label: Text(
                          'Choose Date',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        icon: Icon(Icons.access_time),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  onPressed: _submitTransaction,
                  child: Text('Add Transaction'),
                ),
              ),
            ],
          ),
          margin: EdgeInsets.all(10),
        ),
      ),
    );
  }
}
