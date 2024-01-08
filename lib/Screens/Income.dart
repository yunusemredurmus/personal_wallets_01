import 'package:flutter/material.dart';
import 'package:personal_wallets_01/Screens/HomeScreen.dart';

class IncomesScreen extends StatefulWidget {
  final List<String> gelirDetayListesi;

  const IncomesScreen({Key? key, required this.gelirDetayListesi})
      : super(key: key);

  @override
  State<IncomesScreen> createState() => _IncomesScreenState();
}

class _IncomesScreenState extends State<IncomesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gelirlerim'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.gelirDetayListesi.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildListItem(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(int index) {
    return Card(
      color: Color.fromARGB(255, 68, 6, 201),
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(
          'Gelir: ${widget.gelirDetayListesi[index]} ₺',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        subtitle: Text(
          'Tarih: ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              widget.gelirDetayListesi.removeAt(index);
            });
          },
          icon: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
