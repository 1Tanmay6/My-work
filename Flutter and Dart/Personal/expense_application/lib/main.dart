import 'package:expense_application/new_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './models/transaction.dart';
import './transaction_list.dart';
import './chart.dart';

void main() => {
      // WidgetsFlutterBinding.ensureInitialized(),
      // SystemChrome.setPreferredOrientations(
      //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]),
      runApp(MyApp())
    };

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.purple,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: TextStyle(
                  fontFamily: 'Quicksand',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.purple),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                textStyle: MaterialStateProperty.all(TextStyle(
                    fontFamily: 'Quicksand', fontWeight: FontWeight.bold))),
          ),
          appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold))),
      title: 'Personal Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // String? titleInput;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final List<Transaction> _userTransaction = [
    // Transaction(
    //     id: 't1', title: 'New Shoes', amount: 19.0, date: DateTime.now()),
    // Transaction(
    //     id: 't2', title: 'Groceries', amount: 16.99, date: DateTime.now()),
    // Transaction(
    //     id: 't3', title: 'Flutter book', amount: 20.03, date: DateTime.now()),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) {
      return tx.date!.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransactions(String title, double amount, DateTime pickedDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: pickedDate);
    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addNewTransactions),
          );
        });
  }

  void _deleteTransactions(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  List<Widget> _buildLandscapeContent(
      Widget chartLandscape, bool showChart, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      showChart ? chartLandscape : txListWidget
    ];
  }

  List<Widget> _buildPotraitContent(
      Widget chartWidgetPotrait, Widget txListWidget) {
    return [chartWidgetPotrait, txListWidget];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final isLandsacpe = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add)),
      ],
      title: Text('Personal Expenses'),
    );

    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        userTransaction: _userTransaction,
        deleteFunction: _deleteTransactions,
      ),
    );

    final chartWidgetPotrait = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.25,
        child: Chart(_recentTransactions));

    final chartWidgetLandscape = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.75,
        child: Chart(_recentTransactions));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandsacpe)
              ..._buildLandscapeContent(
                  chartWidgetLandscape, _showChart, txListWidget),
            if (!isLandsacpe)
              ..._buildPotraitContent(chartWidgetPotrait, txListWidget),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
