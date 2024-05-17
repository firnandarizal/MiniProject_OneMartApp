import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/auth/register_screen.dart';
import 'package:flutter_application_1/screens/main_screens/dashboard_screen.dart';
import 'package:flutter_application_1/services/api_users.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<Map<String, dynamic>> userData = [];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/bg.png',
                  width: 150, height: 150),
              const SizedBox(height: 10),
              TextFormField(
                key: const Key('formUser'),
                controller: _userController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "form user tidak boleh kosong!";
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'User',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                key: const Key('formPassword'),
                controller: _passwordController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "form password tidak boleh kosong!";
                  }
                  return null;
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(), // Add this line
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: const Key('loginButton'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    try {
                      userData = await ApiServiceUsers.fetchDataUsers();
                      String enteredUser = _userController.text;
                      String enteredPassword = _passwordController.text;
                      Map<String, dynamic>? matchedUserData =
                          performLogin(enteredUser, enteredPassword);

                      if (matchedUserData != null) {
                        String setNama = matchedUserData['nama'];
                        String setAlamat = matchedUserData['alamat'];
                        String setTelp = matchedUserData['telp'];

                        final SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        await prefs.setString('user_nama', setNama);
                        await prefs.setString('user_alamat', setAlamat);
                        await prefs.setString('user_telp', setTelp);
                        
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Login berhasil!'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ),
                        );

                        await Future.delayed(const Duration(seconds: 2));

                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (builder) {
                          return const Dashboard();
                        }));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('User atau Password Salah Masbro'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    } catch (error) {
                      print('err: $error');
                    }
                  }
                },
                child: const Text('Login'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: RichText(
                  text: TextSpan(
                    text: 'Don\'t have an account? ',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Create Account',
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                        
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => const Register(),
                              ),
                            );
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
    );
  }

  Map<String, dynamic>? performLogin(
      String enteredUser, String enteredPassword) {
    for (var user in userData) {
      if (user['user'] == enteredUser && user['password'] == enteredPassword) {
        return user;
      }
    }
    return null;
  }
}
