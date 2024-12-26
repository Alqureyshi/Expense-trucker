import 'package:expenses_trucker/models/expensemodel.dart';
import 'package:flutter/material.dart';

class ExpensesItem extends StatelessWidget {
  const ExpensesItem(this.expense, {super.key});
  final Expensemodel expense;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Card(
        child: Column(
          children: [
            Text(expense.title),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  expense.amount.toStringAsFixed(2),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(CategoryIcons[expense.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expense.formatterdate.toString())
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
