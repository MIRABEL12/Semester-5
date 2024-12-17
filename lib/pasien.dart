import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: PasienPage(),
    );
  }
}

class PasienPage extends StatelessWidget {
  const PasienPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'images/donasione.jpg', // Ganti placeholder dengan gambar lokal
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: GestureDetector(
                    onTap: () {
                      // Kembali ke halaman sebelumnya (HomePage)
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(Icons.arrow_back, color: Colors.grey[600]),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://storage.googleapis.com/a1aa/image/eAo3WRoAgehriUAMkqXeLdZf9ZzxVtRupmYXWM1dfUklD7xdC.jpg'),
                      ),
                      const SizedBox(width: 8),
                      Text('ID', style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://storage.googleapis.com/a1aa/image/15T2ndYNklJvPpjIeKWVI6tf6Zn1NfftT3k22sbaZq26h94OB.jpg'),
                      ),
                      SizedBox(width: 8),
                      Text('Suryanto', style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('Campaign ini sudah terverifikasi',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800])),
                  const SizedBox(height: 8),
                  Text(
                    'Lahir Tanpa Lubang Anus, Yuk Bantu Naura Sembuh!',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[900]),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(Icons.people, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text('4 Donatur',
                          style: TextStyle(color: Colors.grey[600])),
                      const SizedBox(width: 16),
                      Icon(Icons.access_time, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text('178 hari lagi',
                          style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value: 0.011,
                        backgroundColor: Colors.grey[200],
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Rp 254.000 Terdanai',
                              style: TextStyle(color: Colors.grey[600])),
                          Text('Rp 15.746.000 Kekurangan',
                              style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text('Campaign',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold)),
                            Container(
                              height: 2,
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('Perkembangan',
                                style: TextStyle(color: Colors.grey[600])),
                            Container(
                              height: 2,
                              color: Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text('Rincian Dana',
                                style: TextStyle(color: Colors.grey[600])),
                            Container(
                              height: 2,
                              color: Colors.transparent,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text('Kisah',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800])),
                  const SizedBox(height: 8),
                  Text(
                    'Pada tahun 2018 kami sangat mengharapkan putri ke2 kami lahir dengan normal pada saat itu tanggal 16 Juni 2018 kami menantikan kelahiran putri ke2 kami. Alhamdulillah pukul 01.10 dini har, lahir dengan lancar jenis kelamin perempuan tapi kami sekeluarga k',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade400,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Baca Selengkapnya'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.share, color: Colors.blue),
                        label: const Text('Bagikan',
                            style: TextStyle(color: Colors.blue)),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDonationDialog(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Donasikan'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showDonationDialog(BuildContext context) {
    final TextEditingController amountController = TextEditingController();
    String? paymentMethod = 'Transfer'; // Default payment method
    bool isSuccess = false; // Status untuk feedback animasi

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Masukkan Donasi'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: amountController,
                    decoration: InputDecoration(labelText: 'Jumlah Donasi'),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  Text('Pilih Metode Pembayaran'),
                  ListTile(
                    title: Text('Transfer'),
                    leading: Radio<String>(
                      value: 'Transfer',
                      groupValue: paymentMethod,
                      onChanged: (String? value) {
                        setState(() {
                          paymentMethod = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              actions: [
                // Tombol Batal
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Menutup dialog
                  },
                  child: Text('Batal'),
                ),
                // Tombol Donasi
                TextButton(
                  onPressed: () {
                    String amount = amountController.text;
                    if (amount.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Jumlah donasi tidak boleh kosong'),
                      ));
                    } else if (paymentMethod == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Pilih metode pembayaran terlebih dahulu'),
                      ));
                    } else {
                      // Simpan donasi ke Firestore
                      _saveDonationToFirestore(amount, paymentMethod!);

                      // Update status untuk menampilkan animasi feedback
                      setState(() {
                        isSuccess = true;
                      });

                      // Tampilkan animasi keberhasilan
                      Future.delayed(Duration(seconds: 2), () {
                        // Setelah beberapa detik, tampilkan animasi transisi feedback
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.green),
                              SizedBox(width: 8),
                              Text('Donasi Berhasil!'),
                            ],
                          ),
                          backgroundColor: Colors.green[600],
                        ));

                        // Menutup dialog setelah feedback selesai
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text('Donasi'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<String> getUsernameFromFirestore() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return 'Unknown'; // Jika tidak ada pengguna yang login
      }

      final userRef =
          FirebaseFirestore.instance.collection('users').doc(user.uid);
      final docSnapshot = await userRef.get();

      if (docSnapshot.exists) {
        final username = docSnapshot
            .data()?['username']; // Mengambil username dari Firestore
        return username ??
            'Unknown'; // Jika username tidak ada, kembalikan 'Unknown'
      } else {
        return 'Unknown'; // Jika dokumen tidak ditemukan
      }
    } catch (e) {
      print('Error fetching username: $e');
      return 'Unknown'; // Jika ada kesalahan
    }
  }

  Future<void> _saveDonationToFirestore(
      String amount, String paymentMethod) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('User not logged in');
        return;
      }

      // Ambil username dari Firestore
      String username = await getUsernameFromFirestore();
      String email = user.email ?? 'No email provided';
      double donationTotal = double.tryParse(amount) ?? 0.0;
      String currentDate = DateTime.now().toIso8601String();

      final donationRef = FirebaseFirestore.instance.collection('donations');
      await donationRef.add({
        'username': username,
        'email': email,
        'donation_total': donationTotal,
        'payment_method': paymentMethod,
        'date': currentDate,
      });

      print('Donasi berhasil ditambahkan');
    } catch (e) {
      print('Error: $e');
    }
  }
}
