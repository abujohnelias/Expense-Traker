import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "title",
      amount: 56,
      date: DateTime.now(),
      category: Categories.food,
    ),
    Expense(
      title: "title2",
      amount: 56,
      date: DateTime.now(),
      category: Categories.travel,
    ),
  ];

  void _openAddExpense() {
    showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: NewExpenses(
            onAddExpense: _addExpense,
          ),
        ),
      ),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        duration: const Duration(seconds: 3),
        content: Text(
          "Expense deleted",
          style: GoogleFonts.raleway(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w400,
          ),
        ),
        action: SnackBarAction(
          label: "Undo",
          textColor: Theme.of(context).colorScheme.onPrimary,
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget emptyContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'No expenses yet!',
          style: GoogleFonts.raleway(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 30,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.left,
        ),
        SizedBox(
          // color: Colors.black,
          width: MediaQuery.sizeOf(context).width - 150,
          child: Text(
            "Looks like you haven't added any expenses.\nLet's get started!",
            style: GoogleFonts.raleway(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Expenses",
        ),
      ),
      body: _registeredExpenses.isEmpty
          ? Center(
              child: emptyContent,
            )
          : Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 55.0),
                    child: ExpensesList(
                      expenses: _registeredExpenses,
                      onRemoveExpense: _removeExpense,
                    ),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: 18,
              cornerSmoothing: 1,
            ),
            side: BorderSide(
              color: Theme.of(context).colorScheme.onPrimary,
              width: 2,
            )),
        onPressed: _openAddExpense,
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
