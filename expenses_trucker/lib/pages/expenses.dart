
import 'package:expenses_trucker/models/expensemodel.dart';
import 'package:expenses_trucker/pages/char.dart';
import 'package:expenses_trucker/pages/expensesList.dart';
import 'package:expenses_trucker/pages/new_expenses.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expensemodel> _registredExpenses = [
    Expensemodel(
        amount: 19.9,
        data: DateTime.now(),
        title: "Flutter Course",
        category: Category.work),
    Expensemodel(
        amount: 13.9,
        data: DateTime.now(),
        title: "Cinema",
        category: Category.lesisure)
  ];

  void OPenExpensesModelOverly(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return Center(
            child: NewExpenses(
          onAddExpense: addExpenses,
        ));
      },
    );
  }

  void addExpenses(Expensemodel expense) {
    setState(() {
      _registredExpenses.add(expense);
    });
  }

  void RemoveExpenses(Expensemodel expense) {
    final expenseremovedIndex = _registredExpenses.indexOf(expense);
    setState(() {
      _registredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text("Expenses deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registredExpenses.insert(expenseremovedIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text("No expenses here , pls make some"),
    );

    if (_registredExpenses.isNotEmpty) {
      mainContent = Expenseslist(
        expenses: _registredExpenses,
        onRemoveExpense: RemoveExpenses,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expenses Tracker"),
        actions: [
          IconButton(
              onPressed: () => OPenExpensesModelOverly(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Chart(
            expenses: _registredExpenses,
          ),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
}
