import 'package:flutter/material.dart';

class ChangeMothlyLimit extends StatefulWidget {
  
  final Function changeBudgetLimit;

  ChangeMothlyLimit(this.changeBudgetLimit);

  @override
  State<ChangeMothlyLimit> createState() => _ChangeMothlyLimitState();
}

class _ChangeMothlyLimitState extends State<ChangeMothlyLimit> {
  final _BudgetAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(children: [
        TextField(
          decoration: InputDecoration(label: Text("Yangi limit kiriting")),
          keyboardType: TextInputType.number,
          controller: _BudgetAmountController,
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Bekor Qilish",
                  style: TextStyle(color: Colors.grey),
                )),
            ElevatedButton(
              onPressed: () {
                if (_BudgetAmountController.text.isEmpty) {
                  return;
                }

                final amount = double.parse(_BudgetAmountController.text);
                if (amount > 0) {
                  widget.changeBudgetLimit(amount);
                }
              },
              child: Text("Kiritish"),
            ),
          ],
        ),
      ]),
    );
  }
}
