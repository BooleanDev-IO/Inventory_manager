import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:inventory_manager/config/contants.dart';

import '../../../repos/models/category.dart';
import '../../../repos/models/product.dart';
import '../../../reusable_widgets/datefield.dart';

class AddaCategory extends StatefulWidget {
  AddaCategory({super.key});

  @override
  State<AddaCategory> createState() => _AddaCategoryState();
}

class _AddaCategoryState extends State<AddaCategory> {
  TextEditingController name = TextEditingController(), type = TextEditingController(), numberOfProducts = TextEditingController(), creationDate = TextEditingController();

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
              title: Text("Add a category"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Category Name", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w600)),
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: name,
                          decoration: InputDecoration(
                            hintText: "Enter category name here",
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
                      int length = allcategories!.length;
                      allcategories!.add(Category(categoryId: ++length, categoryName: name.text));
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
