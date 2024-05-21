import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:inventory_manager/config/contants.dart';
import 'package:inventory_manager/repos/models/product.dart';
import 'package:inventory_manager/reusable_widgets/datefield.dart';

import '../../../repos/models/category.dart';

class AddProduct extends StatefulWidget {
  AddProduct({
    super.key,
  });

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController prodName = TextEditingController(),
      prodDate = TextEditingController(),
      prodMRP = TextEditingController(),
      prodQty = TextEditingController(),
      prodDescription = TextEditingController();
  ProductPartner? selectedPartner;
  Category? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(36),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Scaffold(
            appBar: AppBar(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
              clipBehavior: Clip.none,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text("Add a product"),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("#${Random(0000).nextInt(9999)}"),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Product Category", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                            DropdownButtonFormField(
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value!;
                                });
                              },
                              items: List.generate(
                                  allcategories!.length,
                                  (index) => DropdownMenuItem(
                                        child: Text(allcategories![index].categoryName),
                                        value: allcategories![index],
                                      )),
                              decoration: InputDecoration(
                                hintText: "Select a category for product",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text("Product Name", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: prodName,
                              decoration: InputDecoration(
                                hintText: "Enter product name here",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Product description", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                            TextFormField(
                              controller: prodDescription,
                              keyboardType: TextInputType.name,
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: "Enter product description here",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Expanded(
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("Product manufacturing date", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                      DateTimeField(
                        controller: prodDate,
                        onShowPicker: (context, currentValue) async {
                          final time = await showDatePicker(context: context, initialDate: DateTime.now(), lastDate: DateTime.now(), firstDate: DateTime(1900));
                          setState(() {
                            prodDate.text = DateFormat("dd/MMM/yyyy").format(time!);
                          });
                          return time;
                        },
                        format: DateFormat("dd/MMM/yyyy"),
                        decoration: InputDecoration(
                          hintText: "Enter or select date",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("Product market price", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                      TextFormField(
                        controller: prodMRP,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter product price here",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("Product quantity ", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                      TextFormField(
                        controller: prodQty,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Enter product quantity here",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Expanded(
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("Product Partner ", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                      DropdownButtonFormField(
                        onChanged: (value) {
                          setState(() {
                            selectedPartner = value!;
                          });
                        },
                        items: List.generate(
                            allpartner!.length,
                            (index) => DropdownMenuItem(
                                  child: Text(allpartner![index].partnerName),
                                  value: allpartner![index],
                                )),
                        decoration: InputDecoration(
                          hintText: "Select a partner for product",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: BottomNavigationBar(
                currentIndex: 1,
                landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.close),
                    label: "Cancel",
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: "Add",
                  ),
                ],
                onTap: (value) {
                  switch (value) {
                    case 0:
                      Navigator.pop(context);
                      break;
                    case 1:
                      int length = allproducts!.length;
                      allproducts!.add(
                        Product(
                            productId: ++length,
                            productName: prodName.text,
                            categoryId: selectedCategory!.categoryId,
                            price: double.parse(prodMRP.text),
                            quantity: int.parse(prodQty.text),
                            description: prodDescription.text,
                            productPartner: selectedPartner!),
                      );
                      setState(() {});

                      Navigator.pop(context);
                      break;

                    default:
                      break;
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
