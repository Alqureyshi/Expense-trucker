import 'package:expenses_trucker/models/expensemodel.dart';
import 'package:expenses_trucker/pages/expenses_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Expenseslist extends StatelessWidget {
  Expenseslist(
      {super.key, required this.expenses, required this.onRemoveExpense});
  final void Function(Expensemodel expense) onRemoveExpense;
  List<Expensemodel> expenses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) {
        return Dismissible(
          onDismissed: (direction) {
            onRemoveExpense(
              expenses[index],
            );
          },
          key: ValueKey(
            expenses[index],
          ),
          child: ExpensesItem(
            expenses[index],
          ),
        );
      },
    );
  }
}
