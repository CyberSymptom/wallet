import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hamyon/models/expense.dart';
import 'body.dart';
import 'package:intl/intl.dart';
import 'expense_item.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense> expenses;
  final Function delete;

  ExpenseList(this.expenses, this.delete);


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, Constraints) {
        return Container(
          clipBehavior: Clip.hardEdge,
          width: MediaQuery.of(context).size.width,
          height: Constraints.maxHeight - 104.0,
          margin: const EdgeInsets.only(top: 104.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50), topRight: Radius.circular(50)),
          ),
          child: expenses.length > 0
              ? ListView.builder(
                  itemBuilder: (ctx, index) {
                    return ExpenseItem(
                        expenses[index].id,
                        expenses[index].title,
                        expenses[index].date,
                        expenses[index].amount,
                        expenses[index].icon,
                        ValueKey(expenses[index].id),
                        delete,
                        );
                  },
                  itemCount: expenses.length,
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Xarajatlar yo'q, Soqqa qilishda davom eting!",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Image.asset(
                      "assets/images/ufo.png",
                      fit: BoxFit.cover,
                      width: 200.0,
                    )
                  ],
                ),
        );
      },
    );
  }
}
