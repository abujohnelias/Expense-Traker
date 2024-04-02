import 'package:expense_tracker/expenses.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMMMd();
const uuid = Uuid();

enum Categories {
  food,
  travel,
  leisure,
  work,
}

const categoryIcons = {
  Categories.food: "assets/images/food.jpeg",
  Categories.travel: "assets/images/travel.jpeg",
  Categories.leisure: "assets/images/leisure.jpeg",
  Categories.work: "assets/images/work.jpeg",
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Categories category;
  final List<Expense> expenses;

  ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
