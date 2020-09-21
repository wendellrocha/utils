import 'package:flutter/material.dart';
import 'package:modules/app/modules/home/widgets/drawer/drawer_widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Theme.of(context).backgroundColor,
        bottom: PreferredSize(
          child: Container(
            color: Theme.of(context).dividerColor,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).splashColor,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(color: Colors.red),
          Expanded(
            child: ButtonSolidWidget('Imprimir', () {
              Printing.layoutPdf(onLayout: (PdfPageFormat format) {
                return buildPdf(format, itemSelecionado);
              });
            }),
          ),
        ],
      ),
      drawer: DrawerWidget(),
    );
  }

  buildPdf(PdfPageFormat format, PedidoModel item) {
    final pw.Document doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {
          return pw.SizedBox(
            height: 300 * PdfPageFormat.mm,
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'iFoome',
                  style: pw.TextStyle(
                    fontSize: 24,
                  ),
                ),
                pw.SizedBox(height: 8),
                pw.Text('Pedido: ${item.codPedido}'),
                pw.Divider(height: 2),
                pw.Column(
                  mainAxisSize: pw.MainAxisSize.max,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      'Itens: ',
                      style: pw.TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    pw.ListView.builder(
                      itemCount: item.produtos.length,
                      itemBuilder: (context, index) {
                        return pw.Container(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(
                                item.produtos[index].observacao != null
                                    ? item.produtos[index].observacao
                                    : 'Sem observação',
                                style: pw.TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Expanded(
                                    child: pw.Row(
                                      children: [
                                        pw.Text(
                                          item.produtos[index].quantidadeItem +
                                              'X',
                                          style: pw.TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        pw.SizedBox(width: 8),
                                        pw.Text(
                                          item.produtos[index].nome,
                                          style: pw.TextStyle(
                                              fontSize: 14,
                                              fontWeight: pw.FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  pw.SizedBox(width: 8),
                                  pw.Text(
                                    'R\$ ' +
                                        (int.parse(item.produtos[index]
                                                    .precoPraticado) /
                                                100)
                                            .toStringAsFixed(2)
                                            .toString(),
                                    style: pw.TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              pw.ListView.builder(
                                itemCount:
                                    item.produtos[index].complemento.length,
                                itemBuilder: (context, idx) {
                                  return pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Expanded(
                                        child: pw.Row(
                                          children: [
                                            pw.Text(
                                              item.produtos[index]
                                                  .complemento[idx].nome,
                                              style: pw.TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                pw.Divider(height: 2),
                pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text('Total do pedido'),
                    pw.Text(
                      'R\$ ' +
                          (double.parse(item.total) / 100)
                              .toStringAsFixed(2)
                              .toString(),
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                      ),
                      textAlign: pw.TextAlign.right,
                    ),
                  ],
                ),
                pw.Divider(height: 2),
                pw.Text('Cliente'),
                pw.Text(
                  item.cliente,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 6),
                pw.Text(
                  'Local da entrega:',
                ),
                pw.SizedBox(
                  height: 10,
                ),
                pw.Container(
                  child: pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(
                        item.endereco.logradouro != null
                            ? item.endereco.logradouro +
                                ', ' +
                                (item.endereco.numero != null
                                    ? item.endereco.numero
                                    : 'S/N') +
                                ' - ' +
                                (item.endereco.bairro != null
                                    ? item.endereco.bairro
                                    : 'S/N')
                            : ' ',
                      ),
                      pw.SizedBox(
                        height: 5,
                      ),
                      pw.Text(
                        item.endereco.complemento != null
                            ? item.endereco.complemento
                            : ' ',
                      ),
                      pw.SizedBox(
                        height: 5,
                      ),
                      pw.Text(
                        item.endereco.referencia != null
                            ? item.endereco.referencia
                            : ' ',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    return doc.save();
  }
}
