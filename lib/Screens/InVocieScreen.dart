import 'package:flutter/material.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  List<Map<String, dynamic>> faturaDetayListesi = [
    {
      "id": 1,
      "name": "Elektrik",
      "Tutar": 100,
      "tarih": "12.12.2021",
      "icon": Icons.electric_bolt_sharp,
      "color": Colors.red,
    },
    {
      "id": 2,
      "name": "Su",
      "Tutar": 100,
      "tarih": "12.12.2021",
      "icon": Icons.water,
      "color": Colors.blue,
    },
    {
      "id": 3,
      "name": "Telefon",
      "Tutar": 100,
      "tarih": "12.12.2021",
      "icon": Icons.phone,
      "color": Colors.green,
    },
    {
      "id": 4,
      "name": "Doğalgaz",
      "Tutar": 100,
      "tarih": "12.12.2021",
      "icon": Icons.fireplace,
      "color": Colors.pink,
    },
  ];

  final TextEditingController _faturaAdiController = TextEditingController();
  final TextEditingController _tutarController = TextEditingController();
  final TextEditingController _tarihController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faturalarım'),
      ),
      body: ListView.builder(
          itemCount: faturaDetayListesi.length,
          itemBuilder: (context, index) {
            return Card(
              color: faturaDetayListesi[index]["color"],
              elevation: 3,
              margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: Icon(
                  faturaDetayListesi[index]["icon"],
                  color: Colors.white,
                ),
                title: Text(
                  '${faturaDetayListesi[index]["name"]}',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                subtitle: Text(
                  'Tutar: ${faturaDetayListesi[index]["Tutar"]} ₺',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      faturaDetayListesi.removeAt(index);
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }),
      floatingActionButton: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.blue[900],
          onPressed: () {
            _showDialog();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, size: 30, color: Colors.white),
              Text(
                "Fatura",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Fatura Ekle"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  controller: _faturaAdiController,
                  decoration: InputDecoration(
                    hintText: "Fatura Adı",
                  ),
                ),
                TextField(
                  controller: _tutarController,
                  decoration: InputDecoration(
                    hintText: "Tutar",
                  ),
                ),
                TextField(
                  controller: _tarihController,
                  decoration: InputDecoration(
                    hintText: "Tarih",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _faturaEkle(
                  _faturaAdiController.text,
                  double.tryParse(_tutarController.text) ?? 0,
                  _tarihController.text,
                );
              },
              child: Text("Ekle"),
            ),
          ],
        );
      },
    );
  }

  void _faturaEkle(String faturaAdi, double tutar, String tarih) {
    Map<String, dynamic> yeniFatura = {
      "id": faturaDetayListesi.length + 1,
      "name": faturaAdi,
      "Tutar": tutar,
      "tarih": tarih,
      "icon": Icons.attach_money, //
    };

    setState(() {
      faturaDetayListesi.add(yeniFatura);
    });

    Navigator.of(context).pop();
  }
}
