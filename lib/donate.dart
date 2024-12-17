import 'package:flutter/material.dart';
import 'pasien.dart'; // Import halaman PasienPage

class Pasien extends StatefulWidget {
  const Pasien({super.key});

  @override
  _PasienState createState() => _PasienState();
}

class _PasienState extends State<Pasien> {
  bool _isAllSelected = false;
  bool _isKankerSelected = false;
  bool _isGiziBurukSelected = false;
  bool _isStuntingSelected = false;

  void _onButtonPressed(bool isAll) {
    setState(() {
      _isAllSelected = isAll;
      _isKankerSelected = !isAll;
      _isGiziBurukSelected = !isAll;
      _isStuntingSelected = !isAll;
    });
  }

  void _onIndividualButtonPressed(String type) {
    setState(() {
      _isAllSelected = false;
      _isKankerSelected = type == 'Kanker';
      _isGiziBurukSelected = type == 'Gizi Buruk';
      _isStuntingSelected = type == 'Stunting';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ClipRRect(
            child: Image.asset(
              'images/android.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Mau berbagi dengan siapa hari ini?',
                hintStyle: TextStyle(color: Colors.blue.shade400, fontSize: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.blue.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.blue.shade400),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.blue.shade400),
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 255, 255, 255),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                prefixIcon: Icon(Icons.search, color: Colors.blue.shade400),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _onButtonPressed(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isAllSelected
                          ? Colors.blue.shade400
                          : Colors.blue.shade400,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('Semua'),
                  ),
                  const SizedBox(width: 8),
                  _buildOutlinedButton('Kanker', _isKankerSelected),
                  const SizedBox(width: 8),
                  _buildOutlinedButton('Gizi Buruk', _isGiziBurukSelected),
                  const SizedBox(width: 8),
                  _buildOutlinedButton('Stunting', _isStuntingSelected),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey.shade400),
          Expanded(
            child: ListView(
              children: [
                buildCard(
                  'Lahir Tanpa Lubang Anus, Yuk Bantu Naura Sembuh!',
                  'Suryanto',
                  'images/donasione.jpg',
                  254000,
                  4,
                  50,
                  157,
                ),
                buildCard(
                  'Kesulitan Bernapas Sejak Lahir, Yuk Bersama Kita Bantu Perjuangan Panji untuk Sembuh!',
                  'Ladang pahala',
                  'images/donasitwo.png',
                  95000,
                  3,
                  20,
                  176,
                ),
                buildCard(
                  'Retina Matanya Lepas Sejak Lahir, Bantu Syafira Melihat Dunia!',
                  'Syafira Nur Hidayat',
                  'images/donasithree.jpg',
                  1556000,
                  19,
                  80,
                  65,
                ),
                buildCard(
                  'Ditinggal sang Ayah akibat Kelainan Bawaan Lahir, Yuni Mengharapkan Bantuanmu!',
                  'Yuni Aprianti',
                  'images/donasifour.jpg',
                  625000,
                  5,
                  30,
                  353,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutlinedButton(String label, bool isSelected) {
    return OutlinedButton(
      onPressed: () {
        _onIndividualButtonPressed(label);
      },
      style: OutlinedButton.styleFrom(
        foregroundColor: isSelected ? Colors.white : Colors.blue,
        side:
            BorderSide(color: isSelected ? Colors.blue : Colors.blue.shade400),
        backgroundColor: isSelected ? Colors.blue : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(label),
    );
  }

  Widget buildCard(String title, String author, String imageUrl, int amount,
      int donors, double progress, int daysLeft) {
    return GestureDetector(
      onTap: () {
        if (title == 'Lahir Tanpa Lubang Anus, Yuk Bantu Naura Sembuh!') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PasienPage()),
          );
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.person, size: 15, color: Colors.grey),
                        const SizedBox(width: 5),
                        Text(
                          author,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text('Dana terkumpul',
                        style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    LinearProgressIndicator(
                      value: progress / 100,
                      backgroundColor: const Color.fromARGB(255, 215, 215, 215),
                      color: const Color.fromARGB(255, 84, 159, 221),
                    ),
                    const SizedBox(height: 5),
                    Text('Rp ${amount.toString()}',
                        style: const TextStyle(color: Colors.grey)),
                    Text('$donors Donatur',
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
