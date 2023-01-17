import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  final Function addNewExpense;

  AddExpense(this.addNewExpense);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  DateTime? selectDay;
  IconData? selectedIcon;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void showNewCalendar(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        setState(() {
          selectDay = value;
        });
      }
    });
  }

  void showExpenseIcon(BuildContext context) {
    FlutterIconPicker.showIconPicker(context).then((icon) {
      if (icon == null) {
        return;
      }
      setState(() {
        selectedIcon = icon;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 16.0, right: 16.0, left: 16.0, bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? MediaQuery.of(context).viewInsets.bottom : 80.0),
        child: Column(children: [
          TextField(
            decoration: InputDecoration(
              label: Text(
                "Xarajat nomi",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            controller: titleController,
          ),
          TextField(
            decoration: InputDecoration(
                label: Text("Xarajat miqdori",
                    style: TextStyle(
                      fontSize: 14.0,
                    ))),
            keyboardType: TextInputType.number,
            controller: amountController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selectDay == null
                  ? Text("Xarajat kuni tanlanmadi")
                  : Text(
                      "Xarajat kuni: ${DateFormat("d MMMM y").format(selectDay!)}"),
              TextButton(
                  onPressed: () {
                    showNewCalendar(context);
                  },
                  child: Text("Kunni Tanlash"))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              selectedIcon == null
                  ? Text("Icon Tanlanmadi")
                  : Row(
                      children: [
                        Text("Icon tanlandi"),
                        Icon(selectedIcon),
                      ],
                    ),
              ElevatedButton(
                  onPressed: () {
                    showExpenseIcon(context);
                  },
                  child: Text("Icon Tanlash"))
            ],
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
                    if (titleController.text.isEmpty ||
                        amountController.text.isEmpty ||
                        selectDay == null) {
                      return;
                    }
    
                    var title = titleController.text;
                    var amount = double.parse(amountController.text);
    
                    if (amount <= 0) {
                      return;
                    }
    
                    widget.addNewExpense(title, amount, selectDay, selectedIcon);
                  },
                  child: Text("Kiritish"))
            ],
          )
        ]),
      ),
    );
  }
}
