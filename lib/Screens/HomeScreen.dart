import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:personal_wallets_01/Screens/CreditCards.dart';
import 'package:personal_wallets_01/Screens/InVocieScreen.dart';
import 'package:personal_wallets_01/Screens/Income.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class GelirDetay {
  int miktar;
  String gelirTarihi;
  Color color;

  GelirDetay(this.miktar, this.gelirTarihi, this.color);
}

class GiderDetay {
  int miktar;
  String giderTarihi;
  Color color;

  GiderDetay(this.miktar, this.giderTarihi, this.color);
}

class _HomeScreenState extends State<HomeScreen> {
  int gelir = 0;
  int gider = 0;
  List<GelirDetay> gelirDetayListesi = [];
  List<GiderDetay> giderDetayListesi = [];
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kişisel Cüzdan'),
      ),
      body: Stack(
        children: [
          Container(
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
                        onTap: () async {
                          await _animation();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreditCardsScreen(),
                            ),
                          );
                        },
                        child: _buildGridItem(Icons.credit_card,
                            'Kredi Kartları', Color.fromARGB(255, 8, 18, 213)),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await _animation();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => InvoiceScreen(),
                            ),
                          );
                        },
                        child: _buildGridItem(
                            Icons.inventory, 'Faturalar', Colors.red),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await _animation();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IncomesScreen(
                                gelirDetayListesi: gelirDetayListesi
                                    .map((e) => e.miktar.toString())
                                    .toList(),
                              ),
                            ),
                          );
                        },
                        child: _buildGridItem(
                            Icons.money, 'Gelirlerim', Colors.green),
                      ),
                      _buildGridItem(Icons.account_balance_wallet, 'Giderlerim',
                          Colors.orange),
                    ],
                  ),
                ),
                _buildDivider(),
                SizedBox(height: 20),
                _buildBalanceRow(
                  "Toplam Gelen:",
                  "${gelirDetayListesi.isNotEmpty ? _formatCurrency(gelirDetayListesi.map((e) => e.miktar).reduce((value, element) => value + element)) : "0.00"}",
                ),
                SizedBox(height: 20),
                _buildBalanceRow("Toplam Gider:",
                    "${giderDetayListesi.isNotEmpty ? _formatCurrency(giderDetayListesi.map((e) => e.miktar).reduce((value, element) => value + element)) : "0.00"}"),
                SizedBox(height: 20),
                _buildBalanceRow("Toplam Bakiye:",
                    "${_formatCurrency((gelirDetayListesi.isNotEmpty ? gelirDetayListesi.map((e) => e.miktar).reduce((value, element) => value + element) : 0) - (giderDetayListesi.isNotEmpty ? giderDetayListesi.map((e) => e.miktar).reduce((value, element) => value + element) : 0))}"),
                SizedBox(height: 20),
              ],
            ),
          ),
          isLoading
              ? Align(
                  alignment: Alignment.center,
                  child: Lottie.asset(
                    'assets/animations/animation.json',
                    width: 100,
                    height: 100,
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 70,
            height: 55,
            margin: EdgeInsets.only(right: 100),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: Colors.blue[900],
              onPressed: () => _gelirEkleDialog(context),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 30, color: Colors.white),
                    Text(
                      "Gelir",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 70,
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: FloatingActionButton(
              heroTag: "btn2",
              backgroundColor: Colors.orange,
              onPressed: () => _giderEkleDialog(context),
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.remove, size: 30, color: Colors.white),
                    Text(
                      "Gider",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(IconData icon, String text, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
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
    return const Divider(
      height: 20,
      color: Colors.amber,
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
      Color randomColor = Color.fromARGB(255, Random().nextInt(256),
          Random().nextInt(256), Random().nextInt(256));

      GelirDetay yeniGelirDetay =
          GelirDetay(gelir, DateTime.now().toString(), randomColor);

      gelirDetayListesi.add(yeniGelirDetay);
      _animation();
    });
  }

  Future<void> _animation() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  void _giderEkle() {
    setState(() {
      GiderDetay yeniGiderDetay =
          GiderDetay(gider, DateTime.now().toString(), Colors.orange);

      giderDetayListesi.add(yeniGiderDetay);
      _animation();
    });
  }

  void _giderEkleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Gider Ekle"),
          content: TextField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                gider = int.parse(value);
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
                _giderEkle();
                Navigator.of(context).pop();
              },
              child: Text("Ekle"),
            ),
          ],
        );
      },
    );
  }

  // miktar güncelleme
  String _formatCurrency(int amount) {
    return NumberFormat.currency(locale: 'tr_TR', symbol: '₺')
        .format(amount.toDouble());
  }
}
