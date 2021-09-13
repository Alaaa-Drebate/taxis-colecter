import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taxis_colecter/widgets/chart.dart';
import 'package:taxis_colecter/widgets/new_transaction.dart';
import 'package:taxis_colecter/widgets/transaction_list.dart';
import 'models/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'OpenSans',
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        buttonColor: Colors.white,
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                )),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 1,
    //   title: 'Personal Expenses',
    //   amount: 3.9,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 2,
    //   title: 'the second title',
    //   amount: 100,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime timePicked) {
    final tx = Transaction(
        id: DateTime.now().microsecond,
        title: txTitle,
        amount: txAmount,
        date: timePicked);
    setState(() {
      _userTransactions.add(tx);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: context,
      builder: (bCtx) {
        return GestureDetector(
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
          onTap: () {},
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void removeTransaction(int index) {
    setState(() {
      _userTransactions.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final dynamic _appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Taxis collector App'),
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add_circled_solid),
                  onTap:  () => _startNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Taxis collector App'),
            actions: [
              IconButton(
                onPressed: () => _startNewTransaction(context),
                icon: Icon(Icons.add_circle),
              ),
            ],
          );
    final _appBody = SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (isLandscape)
            Container(
              height: (mediaQuery.size.height -
                      _appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text('show chart : '),
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  )
                ],
              ),
            ),
          if (isLandscape)
            _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            _appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.4,
                    child: Chart(_recentTransactions))
                : Container(
                    height: (mediaQuery.size.height -
                            _appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.95,
                    child:
                        TransactionList(_userTransactions, removeTransaction)),
          if (!isLandscape)
            Container(
                height: (mediaQuery.size.height -
                        _appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.4,
                child: Chart(_recentTransactions)),
          if (!isLandscape)
            Container(
                height: (mediaQuery.size.height -
                        _appBar.preferredSize.height -
                        mediaQuery.padding.top) *
                    0.6,
                child: TransactionList(_userTransactions, removeTransaction)),
        ],
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(navigationBar: _appBar,child: _appBody)
        : Scaffold(
            appBar: _appBar,
            body: _appBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                :  FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startNewTransaction(context),
            ),
          );
  }
}
