import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // Import ini diperlukan untuk TapGestureRecognizer
import 'dashboard.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Store
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inisialisasi Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'DisCare',
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPage createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool obscureText = true; // Kontrol visibilitas password

  String? _validateusername(String value) {
    if (value.isEmpty) {
      return 'Username tidak boleh kosong'; // Validation message
    }
    return null; // Return null if validation passes
  }

  // Firebase registration method
  Future<void> _registerUser() async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Menyimpan data user tambahan (username dan email) ke Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid) // Gunakan UID pengguna sebagai dokumen
          .set({
        'username': _usernameController.text,
        'email': _emailController.text,
      });

      // Menampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pendaftaran berhasil')),
      );

      // Navigate ke halaman utama setelah registrasi sukses
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password terlalu lemah')));
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text('Email sudah terdaftar. Silakan gunakan email lain.')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Terjadi kesalahan. Silakan coba lagi nanti.')));
    }
  }

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'E-Mail tidak boleh kosong';
    }
    if (!value.contains('@') && value.length < 5) {
      return 'E-Mail tidak valid';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (value.length < 8) {
      return 'Password harus minimal 8 karakter';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('images/logo.png', width: 50, height: 50),
                        const SizedBox(width: 8),
                        const Text(
                          'DisCare',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 24,
                          height: 16,
                          decoration: BoxDecoration(
                            color: Colors.red.shade900,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'ID',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  'Daftar',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade800,
                  ),
                ),
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Pastikan data diri anda benar yaa!',
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 4.0), // Adjust the left padding as needed
                    child: Text(
                      'Username',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _usernameController,
                  validator: (value) => _validateusername(value ?? ''),
                  decoration: InputDecoration(
                    hintText: 'Masukkan username anda',
                    hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13), // Warna hint teks
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.grey.shade400), // Warna default outline
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors
                              .grey.shade400), // Warna outline saat tidak fokus
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color:
                              Colors.blue.shade400), // Warna outline saat fokus
                    ),
                  ),
                  style:
                      const TextStyle(color: Colors.black), // Warna teks input
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 4.0), // Adjust the left padding as needed
                    child: Text(
                      'E-Mail',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _emailController,
                  validator: (value) => _validateEmail(value ?? '@'),
                  decoration: InputDecoration(
                    hintText: 'Masukkan e-mail anda',
                    hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13), // Warna hint teks
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.grey.shade400), // Warna default outline
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors
                              .grey.shade400), // Warna outline saat tidak fokus
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color:
                              Colors.blue.shade400), // Warna outline saat fokus
                    ),
                  ),
                  style:
                      const TextStyle(color: Colors.black), // Warna teks input
                ),
                const SizedBox(height: 10),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 4.0), // Adjust the left padding as needed
                    child: Text(
                      'Password',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: _passwordController,
                  obscureText: obscureText,
                  validator: (value) => _validatePassword(value ?? ''),
                  decoration: InputDecoration(
                    hintText: 'Masukkan password anda',
                    hintStyle: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 13), // Warna hint teks
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors.grey.shade400), // Warna default outline
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color: Colors
                              .grey.shade400), // Warna outline saat tidak fokus
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(
                          color:
                              Colors.blue.shade400), // Warna outline saat fokus
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.grey.shade600, // Warna ikon
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                  ),
                  style:
                      const TextStyle(color: Colors.black), // Warna teks input
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Lupa kata sandi?',
                    style: TextStyle(color: Colors.blue.shade400, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _registerUser(); // Panggil metode untuk registrasi
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Daftar'),
                ),
                const SizedBox(height: 15),
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('Atau', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider(color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 15),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Daftar dengan Apple')),
                    );
                  },
                  icon: const Icon(Icons.apple, color: Colors.black),
                  label: const Text(
                    'Daftar dengan Apple',
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Daftar dengan Google')),
                    );
                  },
                  icon: const Icon(Icons.golf_course),
                  label: const Text(
                    'Daftar dengan Google',
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Sudah memiliki akun DisCare',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13), // Warna teks biasa
                      ),
                      const TextSpan(
                        text: ' #DisabilitasCare',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 197, 24),
                            fontSize: 13), // Warna teks biasa
                      ),
                      const TextSpan(
                        text: ' ? ',
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13), // Warna teks biasa
                      ),
                      TextSpan(
                        text: 'Masuk di sini!',
                        style: const TextStyle(
                          color:
                              Colors.blue, // Mengubah warna teks menjadi biru
                          fontSize: 13,
                          decoration: TextDecoration
                              .underline, // Menambahkan garis bawah
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Arahkan ke halaman signin
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
