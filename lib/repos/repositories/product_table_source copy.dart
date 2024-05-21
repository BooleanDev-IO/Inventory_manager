import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductTableRowSource extends DataTableSource {
  List<Product> myData;
  final count;
  ProductTableRowSource({
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

DataRow recentFileDataRow(Product data) {
  return DataRow(
    cells: [
      DataCell(Text(data.productId.toString())),
      DataCell(Text(data.categoryId.toString())),
      DataCell(Text(data.productName.toString())),
      DataCell(Text(data.quantity.toString())),
      DataCell(Text(data.price.toString())),
      DataCell(Text(data.description.toString())),
      DataCell(Text(data.productPartner.toJson().toString().replaceAll(",", "\n"))),
    ],
  );
}
