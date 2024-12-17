import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mira_newproject/login.dart';
import 'donasisaya.dart';
import 'transparan.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  Future<Map<String, String?>> _getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      String? username = userDoc['username'];
      String? email = user.email;

      return {'username': username, 'email': email};
    } else {
      return {'username': null, 'email': null};
    }
  }

  // Fungsi untuk mendapatkan total donasi dan jumlah pasien yang terdonasikan
  Future<Map<String, dynamic>> _getDonationData() async {
    User? user = FirebaseAuth.instance.currentUser;
    double totalDonation = 0;
    int donationCount = 0;

    if (user != null) {
      // Ambil data donasi yang terkait dengan pengguna saat ini
      QuerySnapshot donationSnapshot = await FirebaseFirestore.instance
          .collection('donations')
          .where('email', isEqualTo: user.email)
          .get();

      // Hitung total donasi dan jumlah donasi
      donationSnapshot.docs.forEach((doc) {
        totalDonation += double.tryParse(doc['donation_total'].toString()) ?? 0;
        donationCount++;
      });
    }

    return {
      'totalDonation': totalDonation,
      'donationCount': donationCount,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, String?>>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan!'));
          }

          if (!snapshot.hasData || snapshot.data?['username'] == null) {
            return const Center(child: Text('Data pengguna tidak ditemukan!'));
          }

          String? username = snapshot.data?['username'];
          String? email = snapshot.data?['email'];

          return FutureBuilder<Map<String, dynamic>>(
            future: _getDonationData(),
            builder: (context, donationSnapshot) {
              if (donationSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (donationSnapshot.hasError) {
                // Tampilkan kesalahan spesifik di sini
                print(
                    'Error fetching donation data: ${donationSnapshot.error}');
                return Center(
                  child: Text(
                    'Terjadi kesalahan saat mengambil data donasi! ${donationSnapshot.error}',
                    textAlign: TextAlign.center,
                  ),
                );
              }

              if (!donationSnapshot.hasData) {
                return const Center(
                    child: Text('Tidak ada data donasi ditemukan.'));
              }

              double totalDonation =
                  donationSnapshot.data?['totalDonation'] ?? 0;
              int donationCount = donationSnapshot.data?['donationCount'] ?? 0;

              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                'https://storage.googleapis.com/a1aa/image/S9g51O4ErqL7GBdTI7eGGrAv0JbpAH2G1SCNnaoQg5ldXG3JA.jpg'),
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                username ?? 'Nama Tidak Ditemukan',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(email ?? 'Email Tidak Ditemukan'),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              // Tambahkan aksi untuk Edit Profile
                            },
                            icon: Icon(Icons.edit, color: Colors.blue.shade400),
                            tooltip: 'Edit Profile',
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () async {
                              try {
                                await FirebaseAuth.instance
                                    .signOut(); // Logout dari Firebase Auth
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                  (route) => false,
                                );
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Logout failed: $e')));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade900,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              minimumSize: const Size(50, 50),
                            ),
                            child: const Icon(Icons.logout),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              const Text('Dana didonasikan'),
                              Text(
                                'Rp ${totalDonation.toStringAsFixed(0)}',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade900,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text('Donasi Sekarang'),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text('Pasien terdonasikan'),
                              Text(
                                '$donationCount',
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.account_balance_wallet,
                                  color: Colors.blue.shade400, size: 30),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Saldo Kantong Amal'),
                                  Text(
                                    'Rp 0',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.blue.shade400,
                              side: BorderSide(
                                color: Colors.blue.shade400,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('+ Top Up'),
                          ),
                          Row(
                            children: [
                              Icon(Icons.monetization_on,
                                  color: Colors.yellow[700], size: 30),
                              const SizedBox(width: 8),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Poin'),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.blue.shade400,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.info, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Mohon lengkapi profil anda untuk memverifikasi akun',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1),
                    const Divider(height: 1),
                    ListTile(
                      leading:
                          Icon(Icons.book_rounded, color: Colors.blue.shade400),
                      title: const Text('Transparansi Donasi'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TransparanPage()),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading:
                          Icon(Icons.favorite, color: Colors.blue.shade400),
                      title: const Text('Donasi saya'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const DonasiSayaPage()),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: Icon(Icons.calendar_today,
                          color: Colors.blue.shade400),
                      title: const Text('Donasi rutin saya'),
                      onTap: () {},
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
