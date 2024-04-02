import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  const ExpenseItem(
    this.expense, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.secondary,
        shape: SmoothRectangleBorder(
          borderRadius: SmoothBorderRadius(
            cornerRadius: 16,
            cornerSmoothing: 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                // padding: const EdgeInsets.all(16),
                height: 60, width: 60,
                decoration: ShapeDecoration(
                  // color: Colors.white,
                  shape: SmoothRectangleBorder(
                    borderRadius: SmoothBorderRadius(
                      cornerRadius: 12,
                      cornerSmoothing: 1,
                    ),
                    side: BorderSide(
                        color: Theme.of(context).colorScheme.onPrimary,
                        width: 2),
                  ),
                  image: DecorationImage(
                    image: AssetImage(
                      categoryIcons[expense.category]!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: expense.title.toUpperCase(),
                          style: GoogleFonts.raleway(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: " (${expense.category.name})",
                          style: GoogleFonts.raleway(
                            color: Theme.of(context).colorScheme.surface,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    expense.formattedDate,
                    style: GoogleFonts.raleway(
                      color: Theme.of(context).colorScheme.surface,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "₹${expense.amount.toStringAsFixed(2)}",
                style: GoogleFonts.nunito(
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Icon(
                Icons.keyboard_double_arrow_left_rounded,
                color: Theme.of(context).colorScheme.surface,
              ),
            ],
          )
        ],
      ),
    );
  }
}
