import 'package:flutter/material.dart';
import 'package:personal_wallets_01/Screens/HomeScreen.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Logo',
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                "Logo",
                style: TextStyle(fontSize: 30, color: Colors.blue[900]),
              ),
              SizedBox(height: 30),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Kullanıcı Adı',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Şifre',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Colors.blue[900],
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                child: Text(
                  'Giriş Yap',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Kayıt Ol',
                    style: TextStyle(color: Colors.blue[800], fontSize: 20),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Şifremi Unuttum',
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.facebook, size: 50, color: Colors.blue[900]),
                  SizedBox(width: 10),
                  Icon(Icons.calendar_view_week_sharp,
                      size: 50, color: Colors.red),
                ],
              )
              // Image(
              //   image: AssetImage('assets/images/asap.png'),
              //   width: 300,
              //   height: 250,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SignIn(),
  ));
}
