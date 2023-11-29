import 'package:flutter/material.dart';
import 'package:taxiapp/main.dart';
import 'package:taxiapp/pages/map_page.dart';

class MyTextFormField extends StatelessWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final bool isPassword;

  MyTextFormField({
    required this.labelText,
    this.validator,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontWeight: FontWeight.w600),
      ),
      validator: validator,
    );
  }
}

class AccountProfile extends StatefulWidget {
  const AccountProfile({super.key});

  @override
  State<AccountProfile> createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.amber),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    print('CircleAvatar Tıklandı!');
                  },
                  borderRadius: BorderRadius.circular(70),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Color(0xFFFFC107),
                  ),
                ),
                SizedBox(height: 16),
                MyTextFormField(
                  labelText: 'Kullanıcı Adı',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kullanıcı Adı boş olamaz';
                    }
                    return null;
                  },
                ),
                MyTextFormField(
                  labelText: 'Ad',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ad boş olamaz';
                    }
                    return null;
                  },
                ),
                MyTextFormField(
                  labelText: 'Soyad',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Soyad boş olamaz';
                    }
                    return null;
                  },
                ),
                MyTextFormField(
                  labelText: 'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email boş olamaz';
                    }
                    return null;
                  },
                ),
                MyTextFormField(
                  labelText: 'Şifre',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Şifre boş olamaz';
                    }
                    return null;
                  },
                ),
                MyTextFormField(
                  labelText: 'Şifre Tekrar',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Şifre boş olamaz';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print('Formdan Vazgeçildi');
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Vazgeç',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, color: Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          bool confirmResult = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Güncelleme Onayı"),
                              content: Text(
                                  "Güncelleme işlemini kabul ediyor musunuz?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: Text("Hayır"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: Text("Evet"),
                                ),
                              ],
                            ),
                          );

                          if (confirmResult == true) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyHomePage()),
                              (route) => false,
                            );
                          }
                        }
                      },
                      child: Text('Güncelle',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black)),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
