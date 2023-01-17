import 'package:flutter/material.dart';
import 'package:hamyon/models/expense.dart';
import 'budget.dart';
import 'expense_list.dart';

class Body extends StatelessWidget {
  final double totalByMonth;
  final List<Expense> expenses;
  final Function delete;

  Body(this.totalByMonth, this.expenses, this.delete);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Budget(totalByMonth),
        ExpenseList(expenses,delete),
      ],
    );
  }
}
