import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'body.dart';
import 'progres_bar.dart';
import './change_month_limit.dart';

class Budget extends StatefulWidget {
  final double totalByMonth;
  Budget(this.totalByMonth);

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  double budgetLimit = 1000000;

  void showBudgetLimit(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (ctx) {
          return ChangeMothlyLimit(changeBudgetLimit);
        });
  }

  void changeBudgetLimit(double amount) {
    setState(() {
      budgetLimit = amount;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    var totalPercentage = 100 * widget.totalByMonth / budgetLimit;
    totalPercentage = totalPercentage > 100 ? 100 : totalPercentage;

    return LayoutBuilder(
      builder: (context, Constraints) {
        return Container(
          padding: const EdgeInsets.all(20),
          width: double.infinity,
          height: Constraints.maxHeight,
          decoration: BoxDecoration(
              color: Color.fromRGBO(239, 240, 250, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text("Oylik Byudjet"),
                    TextButton.icon(
                        onPressed: () {
                          showBudgetLimit(context);
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 18.0,
                        ),
                        label: Text("${budgetLimit.toStringAsFixed(0)} so'm"))
                  ],
                ),
                Text("${totalPercentage.toStringAsFixed(0)}%"),
              ],
            ),
            Progressbar(totalPercentage),
          ]),
        );
      },
    );
  }
}
