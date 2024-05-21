import 'dart:math';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inventory_manager/screens/home/widgets/line_chart.dart';
import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AnalyticalWidget extends StatefulWidget {
  DeviceScreenType? screenType;

  AnalyticalWidget({super.key, this.screenType});

  @override
  State<AnalyticalWidget> createState() => _AnalyticalWidgetState();
}

class _AnalyticalWidgetState extends State<AnalyticalWidget> {
  bool isTable = false;
  String? selectedCategory;
  List<List<Map>> categories = [
    [
      {"categoryName": "Plaster", "categoryAmount": "25,000.00"},
      {"categoryName": "Nails", "categoryAmount": "18,000.00"},
      {"categoryName": "Paint", "categoryAmount": "45,000.00"}
    ],
    [
      {"categoryName": "Tools", "categoryAmount": "5,000.00"},
      {"categoryName": "Building Material", "categoryAmount": "25,000.00"},
      {"categoryName": "Raw Material", "categoryAmount": "1,00,000.00"}
    ]
  ];
  List<List<Map>> products = [
    [
      {"categoryName": "Paint", "productSold": "3000", "productName": "Nerolac White"},
      {"categoryName": "Building Material", "productSold": "250", "productName": "Ambuja Cement"},
      {"categoryName": "Raw Material", "productSold": "1500", "productName": "Badarpur"},
    ],
    [
      {"categoryName": "Plaster", "productSold": "340", "productName": "HighTech POP"},
      {"categoryName": "Nails", "productSold": "250", "productName": "S.S Nails"},
      {"categoryName": "Tools", "productSold": "100", "productName": "Hammer"},
    ]
  ];

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(36),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.deepPurple.shade100),
            child: Column(children: [
              SizedBox(
                  height: 250,
                  child: PageView.builder(
                    pageSnapping: true,
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Card(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                        child: Row(children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: LottieBuilder.asset(
                                "assets/lottiefiles/logo.json",
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "BANNER TITLE HERE",
                                  style: Theme.of(context).textTheme.displaySmall,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text("BANNER SUBTITILE HERE"),
                              ],
                            ),
                          ),
                        ]),
                      );
                    },
                  ))
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(36),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.deepPurple.shade100),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Overall Analytics",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                                side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5)))),
                        onPressed: () {
                          QuickAlert.show(
                              context: context,
                              type: QuickAlertType.info,
                              textColor: Colors.white,
                              titleColor: Colors.white,
                              confirmBtnColor: Colors.deepPurple,
                              text: "This feature will be added after Demo is approved!.",
                              animType: QuickAlertAnimType.slideInUp,
                              width: 400,
                              backgroundColor: Theme.of(context).primaryColor);
                        },
                        child: Text(
                          "Export",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 36,
              ),
              SizedBox(
                  height: 120,
                  child: PageView.builder(
                    pageSnapping: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: categories[index]
                            .map(
                              (e) => Expanded(
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  splashColor: Theme.of(context).colorScheme.primary,
                                  onTap: () {
                                    setState(() {
                                      selectedCategory = e["categoryName"];
                                    });
                                  },
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    e["categoryName"],
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .titleMedium!
                                                        .copyWith(fontWeight: FontWeight.bold, fontSize: widget.screenType == DeviceScreenType.desktop ? 16 : 12),
                                                  ),
                                                ),
                                                Text(
                                                  "^3%",
                                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Colors.greenAccent, fontSize: widget.screenType == DeviceScreenType.desktop ? 10 : 10),
                                                )
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              "₹ ${e["categoryAmount"]}",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context).textTheme.titleLarge,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ))
            ]),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(36),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.deepPurple.shade100),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        selectedCategory ?? "Select a Category",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(Colors.transparent),
                              padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    16,
                                  ),
                                  side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.5)))),
                          onPressed: () {
                            setState(() {
                              isTable = false;
                            });
                          },
                          child: Text(
                            "Chart View",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.onPrimary),
                            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  16,
                                ),
                              ),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              isTable = true;
                            });
                          },
                          child: Text(
                            "Table View",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  height: 36,
                ),
                AnimatedSwitcher(
                    duration: Duration(milliseconds: 600),
                    child: isTable
                        ? Row(
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: DataTable(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    headingRowColor: MaterialStatePropertyAll(Colors.deepPurple),
                                    dataTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w300),
                                    columns: [
                                      DataColumn(
                                        label: Text(
                                          "Month",
                                          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Category",
                                          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Product",
                                          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Sales",
                                          style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                      5,
                                      (index) => DataRow(
                                        cells: [
                                          DataCell(Text("Month ${index + 1}")),
                                          DataCell(Text(selectedCategory ?? "Select a Category")),
                                          DataCell(Text("Product ${index + 1}")),
                                          DataCell(Text(Random(000).nextInt(99990 + index).toString())),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : LineChartWidget()),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            padding: EdgeInsets.all(36),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.deepPurple.shade100),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "Most Sold Products",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                ],
              ),
              Divider(
                height: 36,
              ),
              SizedBox(
                  height: 120,
                  child: PageView.builder(
                    pageSnapping: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: products[index]
                            .map(
                              (e) => Expanded(
                                child: Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  e["categoryName"] + " | " + e["productName"],
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style:
                                                      Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold, fontSize: widget.screenType == DeviceScreenType.desktop ? 16 : 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${e["productSold"]} -/unit",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context).textTheme.titleLarge,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ))
            ]),
          ),
        ],
      ),
    );
  }
}
