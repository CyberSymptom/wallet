import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final IconData icon;
  final Key key;
  final Function delete;

  ExpenseItem(
      this.id, this.title, this.date, this.amount, this.icon, this.key, this.delete)
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      onDismissed: (direction) {
        delete(id);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
          ),
        title: Text(title),
        subtitle: Text(DateFormat("MMMM d y").format(date),style: TextStyle(fontSize: 12.0),),
        trailing: Text("${amount.toStringAsFixed(0)} so'm"),
      ),
    );
  }
}
