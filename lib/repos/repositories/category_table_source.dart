import 'package:flutter/material.dart';

import '../models/category.dart';

class CategoryTableRowSource extends DataTableSource {
  List<Category> myData;
  final count;
  CategoryTableRowSource({
    required this.myData,
    required this.count,
  });

  @override
  DataRow? getRow(int index) {
    if (index < rowCount) {
      return recentFileDataRow(myData[index]);
    } else
      return null;
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => count;

  @override
  int get selectedRowCount => 0;
}

DataRow recentFileDataRow(Category data) {
  return DataRow(
    cells: [
      DataCell(Text(data.categoryId.toString())),
      DataCell(Text(data.categoryName.toString())),
    ],
  );
}
