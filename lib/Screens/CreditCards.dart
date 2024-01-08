import 'package:flutter/material.dart';

class CreditCardsScreen extends StatefulWidget {
  const CreditCardsScreen({Key? key}) : super(key: key);

  @override
  State<CreditCardsScreen> createState() => _CreditCardsScreenState();
}

class _CreditCardsScreenState extends State<CreditCardsScreen> {
  List<Map<String, dynamic>> creditCards = [
    {"id": 1, "name": "Kredi Kartı 1", "kartnumarası": "00000000000"},
    {"id": 2, "name": "Kredi Kartı 2", "kartnumarası": "0000000000"},
    {"id": 3, "name": "Kredi Kartı 3", "kartnumarası": "0000000000000"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kredi Kartları'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: creditCards.length,
                itemBuilder: (context, index) {
                  return CreditCardItem(
                    cardName: creditCards[index]["name"],
                    cardNumber: creditCards[index]["kartnumarası"],
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 68, 6, 201),
                ),
                onPressed: () {},
                child: Text(
                  'Kredi Kartı Ekle',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CreditCardItem extends StatelessWidget {
  final String cardName;
  final String cardNumber;

  const CreditCardItem({
    required this.cardName,
    required this.cardNumber,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Display only the last 4 digits of the card number
    String lastFourDigits = cardNumber.substring(cardNumber.length - 4);
    String maskedNumber = '**** **** **** ' + lastFourDigits;

    return Card(
      color: Color.fromARGB(255, 68, 6, 201),
      elevation: 5,
      child: ListTile(
        title: Text(
          cardName,
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(maskedNumber, style: TextStyle(color: Colors.white)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
    );
  }
}
