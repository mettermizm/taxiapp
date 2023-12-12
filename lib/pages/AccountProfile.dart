import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/model/theme.dart';
import 'package:taxiapp/class/model/user_model.dart';
import 'package:taxiapp/class/widget_class.dart';
import 'package:taxiapp/pages/map_page.dart';

class AccountProfile extends StatefulWidget {
  const AccountProfile({super.key});

  @override
  State<AccountProfile> createState() => _AccountProfileState();
}

class _AccountProfileState extends State<AccountProfile> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    final user = userModel.user;
    TextEditingController username = TextEditingController();
    TextEditingController name = TextEditingController();
    TextEditingController surname = TextEditingController();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController passwordAgain = TextEditingController();

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
                    print(user!.email ?? 'hata');
                  },
                  borderRadius: BorderRadius.circular(70),
                  child: CircleAvatar(
                    radius: 70,
                    backgroundColor: Color(0xFFFFC107),
                  ),
                ),
                SizedBox(height: 26),
                Row(
                  children: [
                    Text(
                        'Kullanıcı adı : \n${user?.displayName ?? 'Hello\n'}\n'),
                    Text('E-mail : \n${user?.email ?? 'Hello\n'}\n')
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                MyTextFormField.textFormField(
                  username,
                  'Kullanıcı Adı',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Kullanıcı Adı boş olamaz';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                MyTextFormField.textFormField(
                  name,
                  'Ad',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Ad boş olamaz';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                MyTextFormField.textFormField(
                  surname,
                  'Surname',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Soyad boş olamaz';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                MyTextFormField.textFormField(
                  email,
                  'Email',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email boş olamaz';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                MyTextFormField.textFormField(
                  password,
                  'Şifre',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Şifre boş olamaz';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 50,
                ),
                MyTextFormField.textFormField(
                  passwordAgain,
                  'Şifre Tekrar',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Şifre boş olamaz';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 50,
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
                            color: Provider.of<ThemeNotifier>(context)
                                        .isDarkMode ==
                                    true
                                ? Colors.red
                                : Colors.red,
                          )),
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
