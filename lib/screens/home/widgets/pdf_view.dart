import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PDFView extends StatefulWidget {
  String? filePath;
  String? title;
  PDFView({super.key, this.filePath, this.title});

  @override
  State<PDFView> createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  PdfController? pdfController;

  @override
  void dispose() {
    // TODO: implement dispose
    pdfController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    pdfController = PdfController(document: PdfDocument.openFile(widget.filePath!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inoivce:- " + widget.title!),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.print),
            label: Text("Print"),
          )
        ],
      ),
      body: PdfView(
        controller: pdfController!,
        onDocumentLoaded: (document) {},
        onPageChanged: (page) {},
      ),
    );
  }
}
