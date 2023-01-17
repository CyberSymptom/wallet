import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';

class Header extends StatelessWidget {
  final double totalExpenseByMonth;
  final Function CalendarShow;
  final DateTime selectedDay;
  final Function() lastMonth;
  final Function() nextMonth;

  Header(this.totalExpenseByMonth, this.CalendarShow, this.selectedDay, this.lastMonth, this.nextMonth);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      Center(
        child: TextButton(
            onPressed: () {
              CalendarShow(context);
            },
            child: Text(
              DateFormat("MMMM, y").format(selectedDay),
              style: TextStyle(fontSize: 18.0),
            )),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 45.0,
            height: 45.0,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: lastMonth,
              icon: Icon(
                Icons.arrow_left,
                size: 40.0,
                color: Colors.green,
              ),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.green,
                ),
                borderRadius: BorderRadius.circular(30)),
          ),
          Text(
            totalExpenseByMonth.toStringAsFixed(0),
            style: TextStyle(fontSize: 25.0),
          ),
      
          Container(
            width: 45.0,
            height: 45.0,
            child: IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: nextMonth,
                icon: Icon(
                  Icons.arrow_right,
                  size: 40.0,
                  color: Colors.green,
                )),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.green),
                borderRadius: BorderRadius.circular(30)),
          )
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("so'm",style: TextStyle(fontSize: 15.0),)
        ],
      ),
    ]);
  }
}
