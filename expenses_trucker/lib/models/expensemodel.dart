import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final Formatter = DateFormat.yMd();

enum Category { food, travel, lesisure, work }

const CategoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.lesisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work,
};

class Expensemodel {
  final String title;
  final double amount;
  final DateTime data;
  final String id;
  final Category category;

  Expensemodel(
      {required this.amount,
      required this.data,
      required this.title,
      required this.category})
      : id = uuid.v4();

  String get formatterdate {
    return Formatter.format(data);
  }
}

class ExpensesBucket {
  ExpensesBucket({required this.category, required this.expenses});

  final Category category;
  final List<Expensemodel> expenses;

  ExpensesBucket.forCategogory(List<Expensemodel> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpense {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
