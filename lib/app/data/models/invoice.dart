class Invoice {
  CustomerDetails? customerDetails;
  SuplierDetails? suplierDetails;
  InvoiceInfo? invoiceInfo;
  List<InvoiceItem>? invoiceItems;
  double netAmount = 0.0, vat = 0.0, totalAmount = 0.0;

  Invoice({
    this.customerDetails,
    this.suplierDetails,
    this.invoiceInfo,
    this.invoiceItems,
  });

  double get getNetAmount {
    double net = 0.0;
    for (InvoiceItem item in invoiceItems!) {
      net += item.total;
    }
    return net;
  }

  double get getVat {
    double vat = 0.0;
    for (InvoiceItem item in invoiceItems!) {
      vat += (((item.total) * item.vat) / 100);
    }
    return vat;
  }

  double get getTotal {
    double vat = 0.0, net = 0.0, total = 0.0;
    for (InvoiceItem item in invoiceItems!) {
      net += item.total;
      vat += (((item.total) * item.vat) / 100);
    }
    total = net + vat;
    return total;
  }
}

class CustomerDetails {
  late String name, address, paymentInfo;
  CustomerDetails({this.name = '', this.address = '', this.paymentInfo = ''});
}

class SuplierDetails {
  late String name, address;
  SuplierDetails({this.name = '', this.address = ''});
}

class InvoiceInfo {
  late String number, date, dueDate, desc;
  InvoiceInfo(
      {this.number = '', this.date = '', this.dueDate = '', this.desc = ''});
}

class InvoiceItem {
  late String name;
  late int quantity, vat;
  late double unitPrice, total;
  InvoiceItem(
      {this.name = '',
      this.unitPrice = 0.0,
      this.quantity = 0,
      this.vat = 0,
      this.total = 0.0});
}
