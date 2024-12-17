import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final String name; // User's name
  final String email; // User's email

  const AccountPage({super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Akun Saya'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama: $name',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: $email',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            // Add more user details or options here
            ElevatedButton(
              onPressed: () {
                // Handle logout or any other action
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
