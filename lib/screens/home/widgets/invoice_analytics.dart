import 'dart:io';
import 'dart:math';
import 'package:file_saver/file_saver.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:inventory_manager/screens/home/widgets/pdf_view.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' as pw show TextStyle;
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:side_sheet_material3/side_sheet_material3.dart';

import '../../../repos/models/product.dart';

class InvoiceAnalytics extends StatefulWidget {
  List<Product>? products;
  List<ProductPartner>? partners;
  InvoiceAnalytics({super.key, this.products, this.partners});

  @override
  State<InvoiceAnalytics> createState() => _InvoiceAnalyticsState();
}

class _InvoiceAnalyticsState extends State<InvoiceAnalytics> {
  TextEditingController _searchController = TextEditingController();
  bool gstEnabled = true;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Scaffold(
          body: Container(
        padding: EdgeInsets.all(36),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(32), color: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.deepPurple.shade100),
        child: Column(children: [
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Expanded(
              child: Text(
                "Daily Partner Product Sales",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.picture_in_picture))
          ]),
          Expanded(
            child: ListView.builder(
              itemCount: widget.partners!.length,
              itemBuilder: (context, index) {
                return Theme(
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: ExpansionTile(
                          trailing: Text("Rs. ${getTotalPartnerSales(widget.partners![index])}"),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          title: Text(widget.partners![index].partnerName),
                          subtitle: Text("No. of Products:${widget.products!.where((element) => element.productPartner.partnerId == widget.partners![index].partnerId).length}"),
                          children: widget.products!
                              .where((element) => element.productPartner.partnerId == widget.partners![index].partnerId)
                              .map(
                                (e) => ListTile(
                                  title: Text("Product:- ${e.productName}"),
                                  subtitle: Text("Price:-Rs. ${e.price}"),
                                  trailing: Wrap(
                                    direction: Axis.vertical,
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [Text("Sales"), Text(e.productId.toString())],
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ));
              },
            ),
          ),
          Row(children: [
            Expanded(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.onPrimary),
                  padding: MaterialStatePropertyAll(
                    EdgeInsets.symmetric(vertical: 20),
                  ),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  List<Product> cartProduct = [];
                  List<Product>? searchList = [];

                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return Padding(
                              padding: const EdgeInsets.all(36.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Card(
                                          child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "All Products",
                                              style: Theme.of(context).textTheme.headlineMedium,
                                            ),
                                            Divider(),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                      padding: const EdgeInsets.all(12.0),
                                                      child: SearchBar(
                                                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                                        padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 12)),
                                                        hintText: "Search Products..",
                                                        controller: _searchController,
                                                        leading: Icon(Icons.search),
                                                        onChanged: (value) {
                                                          if (value.isEmpty) {
                                                            searchList = widget.products;
                                                            setState(() {});
                                                          } else {
                                                            searchList = widget.products!.where((element) => element.productName.toLowerCase().contains(value.toLowerCase())).toList();

                                                            setState(() {});
                                                          }
                                                        },
                                                        trailing: [
                                                          IconButton(
                                                            onPressed: () {
                                                              _searchController.clear();
                                                            },
                                                            icon: Icon(Icons.close),
                                                          ),
                                                        ],
                                                      )),
                                                ),
                                              ],
                                            ),
                                            Divider(),
                                            Expanded(
                                                child: ListView.builder(
                                              itemCount: searchList!.isNotEmpty ? searchList!.length : widget.products!.length,
                                              itemBuilder: (context, index) {
                                                final e = searchList!.isNotEmpty ? searchList![index] : widget.products![index];
                                                return ListTile(
                                                  title: Text(e.productName),
                                                  subtitle: Text("Rs. " + e.price.toString()),
                                                  trailing: TextButton(
                                                    child: Text("Add +"),
                                                    onPressed: () {
                                                      cartProduct.add(Product(
                                                          productId: e.productId,
                                                          productName: e.productName,
                                                          categoryId: e.categoryId,
                                                          price: e.price,
                                                          quantity: 1,
                                                          description: e.description,
                                                          productPartner: e.productPartner));
                                                      setState(() {});
                                                    },
                                                  ),
                                                );
                                              },
                                            ))
                                          ],
                                        ),
                                      ))),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Card(
                                          child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Cart",
                                                  style: Theme.of(context).textTheme.headlineMedium,
                                                ),
                                                CloseButton()
                                              ],
                                            ),
                                            Divider(),
                                            Expanded(
                                                child: ListView(
                                              children: cartProduct.map((e) {
                                                return Card(
                                                  color: Colors.grey.shade800,
                                                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                  child: ListTile(
                                                    title: Text(
                                                      e.productName,
                                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                                    ),
                                                    subtitle: Text('Rs. ${e.price}'),
                                                    trailing: Card(
                                                      child: Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 15,
                                                            backgroundColor: Colors.black,
                                                            child: IconButton(
                                                              iconSize: 15,
                                                              onPressed: () {
                                                                if (e.quantity > 1) {
                                                                  setState(() {
                                                                    e.quantity -= 1;
                                                                  });
                                                                } else {
                                                                  cartProduct.remove(e);
                                                                  setState(() {});
                                                                }
                                                              },
                                                              icon: Icon(Icons.remove),
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                            child: Text(e.quantity.toString()),
                                                          ),
                                                          CircleAvatar(
                                                            radius: 15,
                                                            backgroundColor: Colors.black,
                                                            child: IconButton(
                                                              iconSize: 15,
                                                              onPressed: () {
                                                                setState(() {
                                                                  e.quantity += 1;
                                                                });
                                                              },
                                                              icon: Icon(Icons.add),
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }).toList(),
                                            )),
                                            Visibility(
                                              visible: gstEnabled,
                                              child: Divider(),
                                            ),
                                            Visibility(
                                              visible: gstEnabled,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text("Amount:-"),
                                                  Text("Rs. ${getTotal(cartProduct)}"),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: gstEnabled,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text("CGST(9%):-"),
                                                  Text(
                                                    "Rs. ${((getTotal(cartProduct) * 9) / 100).toString()}",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Visibility(
                                              visible: gstEnabled,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Text("SGST(9%):-"),
                                                  Text(
                                                    "Rs. ${((getTotal(cartProduct) * 9) / 100).toString()}",
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Divider(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Text("Total Amount:-"),
                                                Text(
                                                  "Rs. ${gstEnabled ? (((getTotal(cartProduct) * 18) / 100) + getTotal(cartProduct)).toString() : getTotal(cartProduct).toString()}",
                                                ),
                                              ],
                                            ),
                                            Divider(),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                                              child: SwitchListTile(
                                                contentPadding: EdgeInsets.zero,
                                                title: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("GST Enabled"),
                                                ),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(36)),
                                                value: gstEnabled,
                                                onChanged: (value) {
                                                  setState(() {
                                                    gstEnabled = value;
                                                  });
                                                },
                                              ),
                                            ),
                                            Row(children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    savePdf(
                                                      cart: cartProduct,
                                                      cgst: ((getTotal(cartProduct) * 9) / 100).toString(),
                                                      sgst: ((getTotal(cartProduct) * 9) / 100).toString(),
                                                      isGst: gstEnabled,
                                                      subtotal: getTotal(cartProduct).toString(),
                                                      total: gstEnabled ? (((getTotal(cartProduct) * 18) / 100) + getTotal(cartProduct)).toString() : getTotal(cartProduct).toString(),
                                                    );
                                                  },
                                                  style: ButtonStyle(
                                                    backgroundColor: MaterialStatePropertyAll(Theme.of(context).colorScheme.onPrimary),
                                                    padding: MaterialStatePropertyAll(
                                                      EdgeInsets.symmetric(vertical: 20),
                                                    ),
                                                    shape: MaterialStatePropertyAll(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(
                                                          16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text("Generate Invoice"),
                                                ),
                                              ),
                                            ]),
                                          ],
                                        ),
                                      ))),
                                ],
                              ),
                            );
                          },
                        );
                      });
                },
                child: Text(
                  "Create Cart +",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ),
          ]),
        ]),
      )),
    );
  }

  Future<pw.Document> generateInvoicePdf({List<Product>? cart, String? subtotal, String? cgst, String? sgst, String? total, bool? isGst}) async {
    final pdf = pw.Document();

    final pw.TextStyle titleStyle = pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold);
    final pw.TextStyle headerStyle = pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold);
    final pw.TextStyle headerStyle1 = pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold);
    final pw.TextStyle contentStyle = pw.TextStyle(fontSize: 12);
    final pw.TextStyle contentStylebold = pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold);

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Container(
              padding: pw.EdgeInsets.all(16),
              child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Text(
                  "Tax Invoice",
                  style: titleStyle,
                ),
              ]),
              decoration: pw.BoxDecoration(
                border: pw.TableBorder.all(
                  width: 1,
                  color: PdfColor.fromInt(Colors.black.value),
                ),
              )),
          pw.Container(
              padding: pw.EdgeInsets.all(16),
              child: pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Text("Invento Hub", style: headerStyle),
                    pw.Text('Address: XY-123, Test place, etc', style: contentStyle),
                    pw.Text('Phone No.: 91xxxxxxxx', style: contentStyle),
                  ],
                ),
              ]),
              decoration: pw.BoxDecoration(
                border: pw.TableBorder.all(
                  width: 1,
                  color: PdfColor.fromInt(Colors.black.value),
                ),
              )),
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.TableBorder.all(
                width: 1,
                color: PdfColor.fromInt(Colors.black.value),
              ),
            ),
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Flexible(
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(16),
                    decoration: pw.BoxDecoration(
                      border: pw.TableBorder.all(
                        width: 1,
                        color: PdfColor.fromInt(Colors.black.value),
                      ),
                    ),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Invoice No.:', style: contentStyle),
                            pw.Text('#${Random(10000).nextDouble() * 9999}', style: contentStyle),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Date:', style: contentStyle),
                            pw.Text('${DateFormat("dd/MMM/yyyy").format(DateTime.now())}', style: contentStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                pw.Flexible(
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(16),
                    decoration: pw.BoxDecoration(
                      border: pw.TableBorder.all(
                        width: 1,
                        color: PdfColor.fromInt(Colors.black.value),
                      ),
                    ),
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.start,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisSize: pw.MainAxisSize.min,
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('GSTN No.:', style: contentStyle),
                            pw.Text('#${Random(10000).nextDouble() * 9999}', style: contentStyle),
                          ],
                        ),
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Sales Through:', style: contentStyle),
                            pw.Text('Worker Name', style: contentStyle),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          pw.Container(
            padding: pw.EdgeInsets.all(16),
            decoration: pw.BoxDecoration(
              border: pw.TableBorder.all(
                width: 1,
                color: PdfColor.fromInt(Colors.black.value),
              ),
            ),
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Recipient Name.:', style: contentStyle),
                    pw.Text('Dummy Name', style: contentStyle),
                  ],
                ),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Recipent Address:', style: contentStyle),
                    pw.Text('XYZ-12, qwerty road, keyboard city', style: contentStyle),
                  ],
                ),
              ],
            ),
          ),
          pw.Table(
            border: pw.TableBorder.all(width: 1.0, color: PdfColor.fromInt(Colors.black.value)),
            children: [
              pw.TableRow(children: [
                pw.Padding(
                  padding: pw.EdgeInsets.all(6),
                  child: pw.Text('Sr. No.', textAlign: pw.TextAlign.center, style: headerStyle1),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(6),
                  child: pw.Text('Item', textAlign: pw.TextAlign.center, style: headerStyle1),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(6),
                  child: pw.Text('Qty.', textAlign: pw.TextAlign.center, style: headerStyle1),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(6),
                  child: pw.Text('Item Price', textAlign: pw.TextAlign.center, style: headerStyle1),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(6),
                  child: pw.Text('(Rs.) Amount', textAlign: pw.TextAlign.center, style: headerStyle1),
                )
              ]),
              ...List.generate(
                cart!.length,
                (index) => pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.all(6),
                      child: pw.Text('${index + 1}', textAlign: pw.TextAlign.center, style: contentStyle),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(6),
                      child: pw.Text(cart[index].productName, style: contentStyle),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(6),
                      child: pw.Text('${cart[index].quantity}', textAlign: pw.TextAlign.center, style: contentStyle),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(6),
                      child: pw.Text('Rs. ${cart[index].price.toStringAsFixed(2)}', textAlign: pw.TextAlign.right, style: contentStyle),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(6),
                      child: pw.Text('Rs. ${((cart[index].price) * cart[index].quantity).toStringAsFixed(2)}', textAlign: pw.TextAlign.right, style: contentStyle),
                    ),
                  ],
                ),
              ).toList(),
              pw.TableRow(
                children: [
                  pw.Padding(
                    padding: pw.EdgeInsets.all(6),
                    child: pw.Text('', textAlign: pw.TextAlign.center, style: contentStyle),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(6),
                    child: pw.Text('', style: contentStyle),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(6),
                    child: pw.Text('', textAlign: pw.TextAlign.center, style: contentStyle),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(6),
                    child: pw.Text('Subtotal:', textAlign: pw.TextAlign.right, style: contentStylebold),
                  ),
                  pw.Padding(
                    padding: pw.EdgeInsets.all(6),
                    child: pw.Text('Rs. ${double.parse(subtotal!).toStringAsFixed(2)}', textAlign: pw.TextAlign.right, style: contentStylebold),
                  ),
                ],
              ),
              isGst!
                  ? pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text('', textAlign: pw.TextAlign.center, style: contentStyle),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text('', style: contentStyle),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text('', textAlign: pw.TextAlign.center, style: contentStyle),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text('CGST (9%):', textAlign: pw.TextAlign.right, style: contentStylebold),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text(
                            'Rs. ${double.parse(cgst!).toStringAsFixed(2)}',
                            textAlign: pw.TextAlign.right,
                            style: contentStylebold,
                          ),
                        )
                      ],
                    )
                  : pw.TableRow(children: []),
              isGst!
                  ? pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text('', textAlign: pw.TextAlign.center, style: contentStyle),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text('', style: contentStyle),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text('', textAlign: pw.TextAlign.center, style: contentStyle),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text('SGST (9%):', textAlign: pw.TextAlign.right, style: contentStylebold),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text(
                            'Rs. ${double.parse(sgst!).toStringAsFixed(2)}',
                            textAlign: pw.TextAlign.right,
                            style: contentStylebold,
                          ),
                        )
                      ],
                    )
                  : pw.TableRow(children: []),
              isGst!
                  ? pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text('', textAlign: pw.TextAlign.center, style: contentStyle),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text('', style: contentStyle),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text('', textAlign: pw.TextAlign.center, style: contentStyle),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text('Grand Total:', textAlign: pw.TextAlign.right, style: contentStylebold),
                        ),
                        pw.Padding(
                          padding: pw.EdgeInsets.all(6),
                          child: pw.Text(
                            'Rs. ${double.parse(total!).toStringAsFixed(2)}',
                            textAlign: pw.TextAlign.right,
                            style: contentStylebold,
                          ),
                        )
                      ],
                    )
                  : pw.TableRow(children: []),
            ],
          ),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
            pw.Expanded(
              flex: 2,
              child: pw.Container(
                height: 100,
                decoration: pw.BoxDecoration(
                  border: pw.TableBorder.all(
                    width: 1,
                    color: PdfColor.fromInt(Colors.black.value),
                  ),
                ),
                padding: pw.EdgeInsets.all(16),
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Text("Declaration", style: headerStyle1),
                    pw.Text('We declare that this invoice shows the actual price of the goods described and that all particulars are true and correct.', style: contentStyle),
                  ],
                ),
              ),
            ),
            pw.Expanded(
              flex: 1,
              child: pw.Container(
                height: 100,
                decoration: pw.BoxDecoration(
                  border: pw.TableBorder.all(
                    width: 1,
                    color: PdfColor.fromInt(Colors.black.value),
                  ),
                ),
                padding: pw.EdgeInsets.all(16),
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisSize: pw.MainAxisSize.min,
                  children: [
                    pw.Text("Invento Hub", style: headerStyle1),
                    pw.SizedBox(
                      height: 20,
                    ),
                    pw.Text("________________", style: headerStyle1),
                  ],
                ),
              ),
            ),
          ]),
        ],
      ),
    );

    return pdf;
  }

  void savePdf({List<Product>? cart, String? subtotal, String? cgst, String? sgst, String? total, bool? isGst}) async {
    final pdf = await generateInvoicePdf(
      cart: cart,
      cgst: cgst,
      isGst: isGst,
      sgst: sgst,
      subtotal: subtotal,
      total: total,
    );
    final data = await pdf.save();
    // final dir = await getDownloadsDirectory();
    // final file = File("${dir!.path}/example.pdf");
    // await file.writeAsBytes(data);
    final path = await FileSaver.instance.saveFile(
      name: "Invoice#${DateTime.now().microsecondsSinceEpoch}.pdf",
      bytes: data,
    );
    print(path);
    Future.delayed(Duration(seconds: 1)).whenComplete(() => Get.to(() => PDFView(
          filePath: path,
          title: '#${Random(10000).nextDouble() * 9999}',
        )));
  }

  getTotalPartnerSales(ProductPartner partner) {
    double total = 0;

    final prods = widget.products!.where((element) => element.productPartner.partnerId == partner.partnerId);

    prods.forEach((product) {
      total = total + (product.price * product.productId);
    });
    return total;
  }

  getTotal(List<Product> cart) {
    double total = 0;

    cart.forEach((product) {
      total = total + (product.price * product.quantity);
    });
    return total;
  }
}
