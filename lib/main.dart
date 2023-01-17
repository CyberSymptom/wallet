import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hamyon/models/expense.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import './widgets/header.dart';
import './widgets/budget.dart';
import './widgets/body.dart';
import './models/expense.dart';
import './widgets/add_expense.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green, accentColor: Colors.pink),
      home: Hamyon(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Hamyon extends StatefulWidget {
  @override
  State<Hamyon> createState() => _HamyonState();
}

class _HamyonState extends State<Hamyon> {
  Expenses expenseData = Expenses();

  DateTime selectedDay = DateTime.now();
  bool _showExpenseList = false;

  void CalendarShow(BuildContext context) {
    showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedDay = value;
        });
      }
    });
  }

  void lastMonth() {
    if (selectedDay.year == DateTime(2020) && selectedDay.month == 1) {
      return;
    }

    setState(() {
      selectedDay =
          DateTime(selectedDay.year, selectedDay.month - 1, selectedDay.day);
    });
  }

  void nextMonth() {
    if (selectedDay.year == DateTime(2031) &&
        selectedDay.month == DateTime.now()) ;

    setState(() {
      selectedDay =
          DateTime(selectedDay.year, selectedDay.month + 1, selectedDay.day);
    });
  }

  void showNewExpense(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (ctx) {
          return AddExpense(addNewExpense);
        });
  }

  void addNewExpense(
      String title, double amount, DateTime date, IconData icon) {
    setState(() {
      expenseData.addNewExpense(title, amount, date, icon);
      Navigator.of(context).pop();
    });
  }

  void delete(String id) {
    setState(() {
      expenseData.deleteExpense(id);
    });
  }

  Widget _showPortrait(totalByMonth, deviceHeight, deviceWidth) {
    return Column(
      children: [
        Container(
          height: deviceHeight > 761.7 ? deviceHeight * 0.2 : deviceHeight * 0.3 ,
          child: Header(
            totalByMonth,
            CalendarShow,
            selectedDay,
            lastMonth,
            nextMonth,
          ),
        ),
        Container(
            height:deviceHeight >  761.7 ? deviceHeight * 0.8 : deviceHeight * 0.7,
            child: Body(
                totalByMonth, expenseData.expenseByMonth(selectedDay), delete)),
      ],
    );
  }

  Widget _showLandScape(totalByMonth, deviceHeight, deviceWidth) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Xarajatlarni ko'rsatish"),
            Switch(
                value: _showExpenseList,
                onChanged: (value) {
                  setState(() {
                    _showExpenseList = value;
                  });
                }),
          ],
        ),
        _showExpenseList
            ? Container(
                width: deviceWidth,
                height: deviceHeight,
                child: Body(totalByMonth,
                    expenseData.expenseByMonth(selectedDay), delete),
              )
            : Container(
                width: deviceWidth,
                height: deviceHeight,
                child: Header(
                  totalByMonth,
                  CalendarShow,
                  selectedDay,
                  lastMonth,
                  nextMonth,
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalByMonth = expenseData.totalExpenseByMonth(selectedDay);

    final islandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final appBar = AppBar(
      centerTitle: true,
      title: Text(
        "Hamyon",
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );

    final topPadding = MediaQuery.of(context).padding.top;

    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        topPadding;
    

    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            islandScape
                ? _showLandScape(totalByMonth, deviceHeight, deviceWidth)
                : _showPortrait(totalByMonth, deviceHeight, deviceWidth),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNewExpense(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
