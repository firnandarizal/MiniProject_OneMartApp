import 'package:flutter/gestures.dart';
import 'package:flutter_application_1/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/services/api_users.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noTelepon = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/bg.png', width: 150, height: 150),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _namaController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "form nama tidak boleh kosong!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _alamatController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "form alamat tidak boleh kosong!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'Alamat', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _noTelepon,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "form telepon tidak boleh kosong!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'No Telepon',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _userController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "form user tidak boleh kosong!";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: 'User', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "form password tidak boleh kosong!";
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> newItem = {
                        'nama': _namaController.text,
                        'alamat': _alamatController.text,
                        'telp': _noTelepon.text,
                        'user': _userController.text,
                        'password': _passwordController.text,
                      };

                      try {
                        await ApiServiceUsers.addItemUsers(newItem);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Akun berhasil terdaftar!'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ),
                        );

                        await Future.delayed(const Duration(seconds: 2));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()));
                      } catch (error) {
                        print('err: $error');
                        // Handle error, show snackbar, etc.
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: const TextStyle(color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                // Replace 'Login()' with your login page class.
                                return const Login();
                              }));
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
