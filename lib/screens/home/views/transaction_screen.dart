import 'dart:math';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      padding: const EdgeInsets.all(36),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(36), color: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.deepPurple.shade100),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "All Transactions",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Expanded(
              child: ListView(
                children: List.generate(
                    20,
                    (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Theme(
                            data: ThemeData(
                              useMaterial3: true,
                              splashColor: Colors.transparent,
                              brightness: Brightness.dark,
                              expansionTileTheme: ExpansionTileThemeData(
                                  backgroundColor: Colors.grey.shade800,
                                  iconColor: Colors.purple.shade300,
                                  textColor: Colors.purple.shade300,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: ExpansionTile(
                                leading: Icon(Icons.receipt),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("Order id: "),
                                            Text("Invoice#${Random(0).nextInt(999999)}"),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("Order Date: "),
                                            Text("${index + 1}, Jan 23"),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Products: "),
                                            Column(children: List.generate(4, (index) => Text("Prduct#$index  - ₹ 5,000"))),
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.white,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text("Total Amount: "),
                                            Text("₹ 20,000.00"),
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.white,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(child: ElevatedButton(onPressed: () {}, child: Text("Print Invoice"))),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            Expanded(child: ElevatedButton(onPressed: () {}, child: Text("Print Invoice(without GST)"))),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                title: Text(
                                  "Invoice#${Random(0).nextInt(999999 + index)}",
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                                ),
                                subtitle: Text("Products - A, B, C"),
                                trailing: Wrap(
                                  direction: Axis.vertical,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  alignment: WrapAlignment.center,
                                  children: [
                                    Text(
                                      "₹ 20,000.00",
                                      style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
                                    ),
                                    Text(
                                      "CREDIT",
                                      style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold, color: Colors.green),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
