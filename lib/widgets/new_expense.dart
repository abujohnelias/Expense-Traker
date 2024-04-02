import 'package:expense_tracker/models/expense.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMMMMd();

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Categories? _selectedCategory;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(
      now.year - 1,
      now.month,
      now.day,
    );
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      showDialog(
        context: context,
        builder: (ctxx) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            "Invalid Input",
            style: GoogleFonts.raleway(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          content: Text(
            """Please make sure that the valid Title, Amount, Date & Catogary is selected...""",
            style: GoogleFonts.raleway(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 5,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctxx);
              },
              child: Text(
                "OK",
                style: GoogleFonts.raleway(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory!,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //

        //?row for title and close button
        Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            bottom: 16.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add New Expense",
                style: GoogleFonts.raleway(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 18,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.close,
                  color: Theme.of(context).colorScheme.onBackground,
                  size: 35,
                ),
              ),
            ],
          ),
        ),

        //? expense title
        TextFormField(
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground,
                width: 2,
              ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            hintText: "Title",
            hintStyle: GoogleFonts.raleway(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 16,
            ),
          ),
          controller: _titleController,
        ),

        //? expense amount
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: TextFormField(
            decoration: InputDecoration(
              suffixText: "₹ ",
              suffixStyle: GoogleFonts.overpassMono(),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onBackground,
                  width: 2,
                ),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onBackground,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onBackground,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    10,
                  ),
                ),
              ),
              hintText: "Amount",
              hintStyle: GoogleFonts.raleway(
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 16,
              ),
            ),
            controller: _amountController,
            keyboardType: TextInputType.number,
          ),
        ),

        DropdownButtonFormField(
          iconEnabledColor: Theme.of(context).colorScheme.onBackground,
          decoration: InputDecoration(
            // prefix: const Icon(Icons.abc),
            hintText: "Category",
            hintStyle: GoogleFonts.raleway(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 16,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground,
                width: 2,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  10,
                ),
              ),
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onBackground,
                width: 2,
              ),
            ),
          ),
          items: Categories.values
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(
                    category.name.toUpperCase().toString(),
                  ),
                ),
              )
              .toList(),
          value: _selectedCategory,
          onChanged: (value) {
            if (value == null) {
              return;
            }
            setState(() {
              _selectedCategory = value;
            });
          },
        ),

        //?date picker
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Row(
            children: [
              GestureDetector(
                onTap: _presentDatePicker,
                child: AnimatedContainer(
                  height: 60,
                  width: _selectedDate == null
                      ? MediaQuery.of(context).size.width - 34
                      : 60,
                  duration: const Duration(milliseconds: 300),
                  decoration: ShapeDecoration(
                    color: _selectedDate == null
                        ? Theme.of(context).colorScheme.onBackground
                        : Colors.transparent,
                    shape: SmoothRectangleBorder(
                      borderRadius: const SmoothBorderRadius.all(
                        SmoothRadius(
                          cornerRadius: 10,
                          cornerSmoothing: 1,
                        ),
                      ),
                      side: _selectedDate == null
                          ? BorderSide.none
                          : BorderSide(
                              width: 2,
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                    ),
                  ),
                  child: _selectedDate == null
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              "Tap to select date",
                              style: GoogleFonts.raleway(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        )
                      : Center(
                          child: Icon(
                            Icons.calendar_month,
                            color: _selectedDate == null
                                ? Colors.white
                                : Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                ),
              ),
              Visibility(
                visible: _selectedDate != null,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: AnimatedContainer(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 102,
                    duration: const Duration(
                      milliseconds: 300,
                    ),
                    decoration: ShapeDecoration(
                      shape: SmoothRectangleBorder(
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.onBackground,
                          width: 2,
                        ),
                        borderRadius: SmoothBorderRadius(
                          cornerRadius: 10,
                          cornerSmoothing: 1,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _selectedDate == null
                            ? "No Date Selected"
                            : formatter.format(_selectedDate!),
                        style: GoogleFonts.overpassMono(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),

        //?save button
        GestureDetector(
          onTap: submitExpense,
          child: Container(
            height: 60,
            decoration: ShapeDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              shape: SmoothRectangleBorder(
                borderRadius: SmoothBorderRadius(
                  cornerRadius: 10,
                  cornerSmoothing: 1,
                ),
              ),
            ),
            child: Center(
              child: Text(
                "+ Add New",
                style: GoogleFonts.raleway(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
