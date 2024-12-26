import 'package:expenses_trucker/models/expensemodel.dart';
import 'package:flutter/material.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.onAddExpense});

  final void Function(Expensemodel expense) onAddExpense;

  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  DateTime? selectedDatePicker;
  Category selectedCategory = Category.lesisure;
  void PresentdatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickdate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: now,
        initialDate: now);

    setState(() {
      selectedDatePicker = pickdate;
    });
  }

  void submitExpenses() {
    final entredamount = double.tryParse(_amountController.text);

    final amountInvalid = entredamount == null || entredamount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        selectedDatePicker == null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("invalid Input"),
            content: const Text(
                "please make sure a valid , title , amount ,and category was enterd"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Oky"),
              ),
            ],
          );
        },
      );

      return;
    } else {
      Navigator.pop(context);
    }
    widget.onAddExpense(Expensemodel(
        amount: entredamount,
        data: selectedDatePicker!,
        title: _titleController.text,
        category: selectedCategory));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              label: Text(
                "Title",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: "\$",
                    label: Text(
                      "Amount",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(selectedDatePicker == null
                        ? "No date selected"
                        : Formatter.format(selectedDatePicker!)),
                    IconButton(
                      onPressed: PresentdatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            children: [
              DropdownButton(
                value: selectedCategory,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value!;
                  });
                },
              ),
              const SizedBox(
                width: 100,
              ),
              TextButton(
                onPressed: submitExpenses,
                child: const Text(
                  "Save Expenses",
                  style: TextStyle(fontSize: 17),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
