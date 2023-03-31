import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import '../data.dart';

class InvoiceProvider {
  final Invoice invoice;
  InvoiceProvider({required this.invoice});
  Future<File> generatePdf() async {
    final pdf = Document();

    pdf.addPage(MultiPage(
        build: (con) => [
              pdfView(),
            ]));

    return saveDocument(name: 'my_doc.pdf', pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();
    final basePath = await FileService.getBaseFilePath();
    final file = File('$basePath/$path_invoice/$name');
    print('filepath ${file.path}');
    await file.writeAsBytes(bytes);
    return file;
  }

  Widget pdfView() {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      SizedBox(
        height: 20,
      ),
      Text('Invoice',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text('No.: ${invoice.invoiceInfo!.number}',
            textAlign: TextAlign.right, style: const TextStyle()),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text('Date: ${invoice.invoiceInfo!.date}',
            textAlign: TextAlign.right, style: const TextStyle()),
      ),
      SizedBox(
        height: 30,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Text('Supplier',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Text(invoice.suplierDetails!.name,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Text(invoice.suplierDetails!.address,
            textAlign: TextAlign.left, style: const TextStyle()),
      ),
      SizedBox(
        height: 20,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Text('Customer',
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Text(invoice.customerDetails!.name,
            textAlign: TextAlign.left,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8),
        child: Text(invoice.customerDetails!.address,
            textAlign: TextAlign.left, style: const TextStyle()),
      ),
      SizedBox(
        height: 20,
      ),
      Table(
        columnWidths: {
          0: const FlexColumnWidth(3),
          1: const FlexColumnWidth(1),
          2: const FlexColumnWidth(1),
          3: const FlexColumnWidth(1),
          4: const FlexColumnWidth(1),
        },
        border: const TableBorder(),
        children: [
          tableHeadings(),
        ],
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
        child: Table(
          columnWidths: {
            0: const FlexColumnWidth(3),
            1: const FlexColumnWidth(1),
            2: const FlexColumnWidth(1),
            3: const FlexColumnWidth(1),
            4: const FlexColumnWidth(1),
          },
          children: List.generate(
              invoice.invoiceItems!.length, (index) => tableContent(index)),
        ),
      ),
      Divider(
        thickness: .5,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
        child: Table(
          columnWidths: {
            0: const FlexColumnWidth(1),
            1: const FlexColumnWidth(1),
            2: const FlexColumnWidth(1),
            3: const FractionColumnWidth(.3),
            4: const FractionColumnWidth(.2),
          },
          children: [
            TableRow(children: [
              SizedBox(),
              SizedBox(),
              SizedBox(),
              Text('Net Total: ',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('${invoice.getNetAmount}',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ]),
            TableRow(children: [
              SizedBox(),
              SizedBox(),
              SizedBox(),
              Text(
                'VAT : ',
                textAlign: TextAlign.right,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('${invoice.getVat}',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            ]),
          ],
        ),
      ),
      Divider(
        thickness: .5,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
        child: Table(
          columnWidths: {
            0: const FlexColumnWidth(1),
            1: const FlexColumnWidth(1),
            2: const FlexColumnWidth(1),
            3: const FractionColumnWidth(.4),
            4: const FractionColumnWidth(.25),
          },
          children: [
            TableRow(children: [
              SizedBox(),
              SizedBox(),
              SizedBox(),
              Text('Total Amount: ',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text('${invoice.getTotal}',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ]),
          ],
        ),
      ),
      SizedBox(
        height: 30,
      ),
    ]);
  }

  tableHeadings() {
    return TableRow(
        decoration: BoxDecoration(color: PdfColor.fromHex('#909090')),
        children: [
          Text('  Name', textAlign: TextAlign.left, style: const TextStyle()),
          Text('Price', textAlign: TextAlign.left, style: const TextStyle()),
          Text('Qty.', textAlign: TextAlign.left, style: const TextStyle()),
          Text('VAT', textAlign: TextAlign.left, style: const TextStyle()),
          Text('Total  ', textAlign: TextAlign.left, style: const TextStyle()),
        ]);
  }

  tableContent(int i) {
    return TableRow(
      children: [
        Text('${invoice.invoiceItems![i].name} ',
            textAlign: TextAlign.left, style: const TextStyle()),
        Text('${invoice.invoiceItems![i].unitPrice} ',
            textAlign: TextAlign.center, style: const TextStyle()),
        Text('${invoice.invoiceItems![i].quantity} ',
            textAlign: TextAlign.center, style: const TextStyle()),
        Text('${invoice.invoiceItems![i].vat} % ',
            textAlign: TextAlign.center, style: const TextStyle()),
        Text('${invoice.invoiceItems![i].total}    ',
            textAlign: TextAlign.right, style: const TextStyle()),
      ],
    );
  }
}
