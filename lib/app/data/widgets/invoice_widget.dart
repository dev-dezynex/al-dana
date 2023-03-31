import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data.dart';

class InvoiceWidget extends StatelessWidget {
  const InvoiceWidget({super.key, required this.invoice});
  final Invoice invoice;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: textDark10, borderRadius: BorderRadius.circular(5)),
      width: Get.width,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text('Invoice',
              textAlign: TextAlign.center,
              style: tsPoppins(size: 18, weight: FontWeight.w700)),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('No.: ${invoice.invoiceInfo!.number}',
                textAlign: TextAlign.end, style: tsPoppins()),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text('Date: ${invoice.invoiceInfo!.date}',
                textAlign: TextAlign.end, style: tsPoppins()),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Text('Supplier',
                textAlign: TextAlign.start,
                style: tsPoppins(size: 15, weight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Text(invoice.suplierDetails!.name,
                textAlign: TextAlign.start,
                style: tsPoppins(weight: FontWeight.w600, size: 13)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Text(invoice.suplierDetails!.address,
                textAlign: TextAlign.start, style: tsPoppins()),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Text('Customer',
                textAlign: TextAlign.start,
                style: tsPoppins(size: 15, weight: FontWeight.w700)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Text(invoice.customerDetails!.name,
                textAlign: TextAlign.start,
                style: tsPoppins(weight: FontWeight.w600, size: 13)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Text(invoice.customerDetails!.address,
                textAlign: TextAlign.start, style: tsPoppins()),
          ),
          const SizedBox(
            height: 20,
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FlexColumnWidth(1),
              2: FlexColumnWidth(1),
              3: FlexColumnWidth(1),
              4: FlexColumnWidth(1),
            },
            border: const TableBorder(),
            children: [
              tableHeadings(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
                4: FlexColumnWidth(1),
              },
              children: List.generate(
                  invoice.invoiceItems!.length, (index) => tableContent(index)),
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: .5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FractionColumnWidth(.3),
                4: FractionColumnWidth(.2),
              },
              children: [
                TableRow(children: [
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  Text('Net Total: ',
                      textAlign: TextAlign.end,
                      style: tsPoppins(weight: FontWeight.w600)),
                  Text('${invoice.getNetAmount}',
                      textAlign: TextAlign.end,
                      style: tsPoppins(size: 14, weight: FontWeight.w600)),
                ]),
                TableRow(children: [
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  Text(
                    'VAT : ',
                    textAlign: TextAlign.end,
                    style: tsPoppins(weight: FontWeight.w600),
                  ),
                  Text('${invoice.getVat}',
                      textAlign: TextAlign.end,
                      style: tsPoppins(size: 14, weight: FontWeight.w600)),
                ]),
              ],
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: .5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
                3: FractionColumnWidth(.4),
                4: FractionColumnWidth(.25),
              },
              children: [
                TableRow(children: [
                  const SizedBox(),
                  const SizedBox(),
                  const SizedBox(),
                  Text('Total Amount: ',
                      textAlign: TextAlign.end,
                      style: tsPoppins(weight: FontWeight.w600, size: 15)),
                  Text('${invoice.getTotal}',
                      textAlign: TextAlign.end,
                      style: tsPoppins(size: 17, weight: FontWeight.w600)),
                ]),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }

  tableHeadings() {
    return TableRow(decoration: const BoxDecoration(color: textDark40), children: [
      Text('  Name', textAlign: TextAlign.left, style: tsPoppins()),
      Text('Price', textAlign: TextAlign.left, style: tsPoppins()),
      Text('Qty.', textAlign: TextAlign.left, style: tsPoppins()),
      Text('VAT', textAlign: TextAlign.left, style: tsPoppins()),
      Text('Total  ', textAlign: TextAlign.left, style: tsPoppins()),
    ]);
  }

  tableContent(int i) {
    return TableRow(
      children: [
        Text('${invoice.invoiceItems![i].name} ',
            textAlign: TextAlign.left, style: tsPoppins()),
        Text('${invoice.invoiceItems![i].unitPrice} ',
            textAlign: TextAlign.center, style: tsPoppins()),
        Text('${invoice.invoiceItems![i].quantity} ',
            textAlign: TextAlign.center, style: tsPoppins()),
        Text('${invoice.invoiceItems![i].vat} % ',
            textAlign: TextAlign.center, style: tsPoppins()),
        Text('${invoice.invoiceItems![i].total}    ',
            textAlign: TextAlign.right, style: tsPoppins()),
      ],
    );
  }
}
