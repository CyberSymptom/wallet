import 'package:flutter/material.dart';

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final IconData icon;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    this.icon = Icons.ac_unit,
  });
}

class Expenses {
  List<Expense> _items = [
    Expense(id: "r1", title: "Qovun", amount: 20000, date: DateTime.now()),
    Expense(id: "r2", title: "Krasovka", amount: 200000, date: DateTime.now()),
  ];

  List<Expense> get items {
    return _items;
  }

  List<Expense> expenseByMonth(DateTime date) {
    return _items
        .where((expense) =>
            expense.date.month == date.month && expense.date.year == date.year)
        .toList();
  }

  double totalExpenseByMonth(DateTime date) {
    final itemByMonth = expenseByMonth(date);

    return itemByMonth.fold(0, (previousValue, expense) {
      return previousValue + expense.amount;
    });
  }

  void addNewExpense(String title, double amount, DateTime date, IconData icon) {
    _items.add(Expense(
        id: "r${_items.length}", title: title, amount: amount, date: date, icon: icon));
  }

  void deleteExpense(String id) {
    _items.removeWhere((expense) => expense.id == id);
  }
}
