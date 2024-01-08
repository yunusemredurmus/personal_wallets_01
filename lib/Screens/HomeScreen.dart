import 'package:flutter/material.dart';
import 'package:personal_wallets_01/Screens/CreditCards.dart';
import 'package:personal_wallets_01/Screens/Income.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class GelirDetay {
  String miktar;
  String gelirTarihi;

  GelirDetay(this.miktar, this.gelirTarihi);
}

class _HomeScreenState extends State<HomeScreen> {
  int gelir = 0;
  List<String> gelirDetayListesi = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Kişisel Cüzdan'),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                height: 380,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20.0,
                  mainAxisSpacing: 20.0,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreditCardsScreen(),
                        ),
                      ),
                      child:
                          _buildGridItem(Icons.credit_card, 'Kredi Kartları'),
                    ),
                    _buildGridItem(Icons.inventory, 'Faturalar'),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IncomesScreen(
                              gelirDetayListesi: gelirDetayListesi),
                        ),
                      ),
                      child: _buildGridItem(Icons.money, 'Gelirlerim'),
                    ),
                    _buildGridItem(Icons.account_balance_wallet, 'Giderlerim'),
                  ],
                ),
              ),
              _buildDivider(),
              SizedBox(height: 20),
              _buildBalanceRow(
                "Toplam Bakiye:",
                "${gelirDetayListesi.isNotEmpty ? gelirDetayListesi.map((e) => int.parse(e)).reduce((value, element) => value + element).toString() : "0.00"} ₺",
              ),
              SizedBox(height: 20),
              _buildBalanceRow("Toplam Gider:", "0.00 ₺"),
              SizedBox(height: 20),
              _buildBalanceRow("Toplam Gelir:", "0.00 ₺"),
              SizedBox(height: 20),
              _buildDivider(),
              SizedBox(height: 20),
            ],
          ),
        ),
        floatingActionButton: Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 68, 6, 201),
            borderRadius: BorderRadius.circular(10),
          ),
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 68, 6, 201),
            onPressed: () => _gelirEkleDialog(context),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 30, color: Colors.white),
                  Text(
                    "Gelir",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildGridItem(IconData icon, String text) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 68, 6, 201),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 50,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 20,
      color: Color.fromARGB(255, 68, 6, 201),
      thickness: 2,
    );
  }

  Widget _buildBalanceRow(String label, String amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 20),
        ),
        Text(amount, style: TextStyle(fontSize: 32)),
      ],
    );
  }

  void _gelirEkleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Gelir Ekle"),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                gelir = int.parse(value);
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("İptal"),
            ),
            TextButton(
              onPressed: () {
                _gelirEkle();
                Navigator.of(context).pop();
              },
              child: Text("Ekle"),
            ),
          ],
        );
      },
    );
  }

  void _gelirEkle() {
    setState(() {
      GelirDetay yeniGelirDetay =
          new GelirDetay(gelir.toString(), DateTime.now().toString());

      // Yeni gelir detayını listeye ekleyin
      gelirDetayListesi.add(yeniGelirDetay.miktar);
    });
  }
}
