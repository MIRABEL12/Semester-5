import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart'; // Import ini diperlukan untuk TapGestureRecognizer
import 'dashboard.dart';
import 'signin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return; // Jangan lanjutkan jika form tidak valid
    }

    try {
      // Login menggunakan Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(), // Trim untuk menghapus spasi
        password: _passwordController.text.trim(),
      );

      // Navigasi ke HomePage jika login berhasil
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // Menangani error spesifik dari FirebaseAuth
      switch (e.code) {
        case 'user-not-found':
          errorMessage =
              'Pengguna tidak ditemukan. Silakan daftar terlebih dahulu.';
          break;
        case 'wrong-password':
          errorMessage = 'Password salah. Coba lagi.';
          break;
        case 'invalid-email':
          errorMessage = 'Format email tidak valid.';
          break;
        default:
          errorMessage = 'Terjadi kesalahan: ${e.message}';
      }

      // Tampilkan pesan error menggunakan SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } catch (e) {
      // Menangani error umum lainnya
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login gagal. Silakan coba lagi.')),
      );
    }
  }

  bool obscureText = true; // Kontrol visibilitas password

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Username atau E-Mail tidak boleh kosong';
    }
    if (!value.contains('@') && value.length < 4) {
      return 'Username terlalu pendek atau email tidak valid';
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
                  'Masuk',
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
                    'Pastikan anda sudah memiliki akun sebelumnya.',
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
                      'Username atau E-Mail',
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
                  validator: (value) => _validateEmail(value ?? ''),
                  decoration: InputDecoration(
                    hintText: 'Masukkan username atau e-mail anda',
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
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade400,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Masuk'),
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
                      const SnackBar(content: Text('Masuk dengan Apple')),
                    );
                  },
                  icon: const Icon(Icons.apple, color: Colors.black),
                  label: const Text(
                    'Masuk dengan Apple',
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
                      const SnackBar(content: Text('Masuk dengan Google')),
                    );
                  },
                  icon: const Icon(Icons.golf_course),
                  label: const Text(
                    'Masuk dengan Google',
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
                        text: 'Belum memiliki akun DisCare',
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
                        text: 'Yuk daftar di sini!',
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
                                  builder: (context) => const SignInPage()),
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
