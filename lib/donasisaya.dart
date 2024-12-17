import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DonasiSayaPage(),
    );
  }
}

class DonasiSayaPage extends StatelessWidget {
  const DonasiSayaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.blue.shade400),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Donasi Saya',
          style: TextStyle(
              color: Colors.blue.shade400, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade400,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'Total donasi',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              Divider(height: 1, color: Colors.grey[300]),
              const SizedBox(height: 20),
              Column(
                children: [
                  Image.network(
                    'https://storage.googleapis.com/a1aa/image/3SoKfNsSB0R5ACd8ZS67nwb55lE1ue5r43FSH6XnvuE34MuTA.jpg',
                    width: 150,
                    height: 150,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Belum ada donasi campaign',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
