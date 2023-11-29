import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Giriş başarılı ise burada işlemler yapabilirsiniz.
      User? user = userCredential.user;
      print('Giriş yapıldı: ${user!.uid}');

      // Giriş başarılıysa başka bir işlem yapabilir veya sayfayı değiştirebilirsiniz.
      // Örneğin:
      // Navigator.pushReplacementNamed(context, '/home'); // Ana sayfaya yönlendirme
    } catch (e) {
      // Giriş sırasında bir hata oluştuğunda burada hata işlemlerini yapabilirsiniz.
      print('Giriş yapılamadı: $e');
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Hesap oluşturma başarılıysa burada işlemler yapabilirsiniz.
      User? user = userCredential.user;
      print('Hesap oluşturuldu: ${user!.uid}');

      // Hesap oluşturulduktan sonra başka bir işlem yapabilir veya sayfayı değiştirebilirsiniz.
      // Örneğin:
      // Navigator.pushReplacementNamed(context, '/home'); // Ana sayfaya yönlendirme
    } catch (e) {
      // Hesap oluşturma sırasında bir hata oluştuğunda burada hata işlemlerini yapabilirsiniz.
      print('Hesap oluşturulamadı: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.amber),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: email,
              decoration: InputDecoration(labelText: 'Email Giriniz'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen email adresinizi giriniz';
                }
                return null;
              },
            ),
            TextFormField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Şifre Giriniz'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Lütfen şifrenizi giriniz';
                }
                return null;
              },
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Vazgeç',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      String userEmail = email.text.trim();
                      String userPassword = password.text.trim();
                      signInWithEmailAndPassword(userEmail, userPassword);
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Giriş Yap',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      String userEmail = email.text.trim();
                      String userPassword = password.text.trim();
                      createUserWithEmailAndPassword(userEmail, userPassword);
                    }
                  },
                  child: Container(
                    width: 100,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        'Hesap Oluştur',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
