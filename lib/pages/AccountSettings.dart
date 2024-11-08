import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/app_color.dart';
import 'package:taxiapp/class/model/theme.dart';
import 'package:taxiapp/pages/auth/authentication.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);

  @override
  State<AccountSettings> createState() => AccountSettingsState();
}

class AccountSettingsState extends State<AccountSettings> {
  bool smsNotification = false;
  bool mailNotification = false;

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginPage(),
      ));
    } catch (e) {
      print('Çıkış yapılamadı: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.amber),
        title: Text("Hesap Ayarları"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        children: [
          buildNotificationItem(Icons.message,
              'Sms ile bildirim almak istiyorum.', smsNotification, (value) {
            setState(() {
              smsNotification = value;
            });
          }),
          SizedBox(
            height: 20.0,
          ),
          buildNotificationItem(Icons.email,
              'Mail ile bildirim almak istiyorum.', mailNotification, (value) {
            setState(() {
              mailNotification = value;
            });
          }),
          SizedBox(
            height: 20.0,
          ),
          Provider.of<ThemeNotifier>(context).isDarkMode == true ?
            buildNotificationItem(
              Icons.mode_night_outlined, 
              'Karanlık Tema',
              true, 
              (value) {
                setState(() {
                  value;
                });
                Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
              }
            ) : buildNotificationItem(
              Icons.light_mode_outlined, 
              'Aydınlık Tema',
              false, 
              (value) {
                setState(() {
                  value;
                });
                Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
              }
            ),
          SizedBox(
            height: 20.0,
          ),
          buildListItem(Icons.cookie, 'Çerezler ve Gizlilik Politikası'),
          SizedBox(
            height: 20.0,
          ),
          buildListItem(Icons.price_change_outlined, 'Abonelik Planı'),
          SizedBox(
            height: 20.0,
          ),
          buildListItem(Icons.help, 'Destek'),
          SizedBox(
            height: 20.0,
          ),
          buildListItem(Icons.logout_outlined, 'Çıkış Yap'),
          SizedBox(
            height: 20.0,
          ),
          buildListItem(Icons.delete, 'Hesabımı Sil'),
        ],
      ),
    );
  }

  Widget buildNotificationItem(
      IconData icon, String text, bool value, Function(bool) onChanged) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color:Provider.of<ThemeNotifier>(context).isDarkMode ==
                                      true
                                  ? AppColors.dark_theme.wigdetColor : Color(0xfff2f2f2),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.7),
                spreadRadius: 4,
                blurRadius: 7,
                offset: Offset(0, 2))
          ]),
      margin: EdgeInsets.symmetric(horizontal: 15.0),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: InkWell(
        // onTap: () {
        //   onChanged(!value);
        // },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.orange,
                ),
                SizedBox(width: 10),
                Text(text),
              ],
            ),
            Switch(
              value: value,
              activeColor: Colors.orange,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListItem(IconData icon, String text) {
    return SizedBox(
      height: 60,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Provider.of<ThemeNotifier>(context).isDarkMode ==
                                      true
                                  ? AppColors.dark_theme.wigdetColor : Color(0xfff2f2f2),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: Offset(0, 2))
            ]),
        margin: EdgeInsets.symmetric(horizontal: 15.0),
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: InkWell(
          onTap: () {
            if(text == 'Çıkış Yap'){
              signOut(); 
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    icon,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 10),
                  Text(text),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
