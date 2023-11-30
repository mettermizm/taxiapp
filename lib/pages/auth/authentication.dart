import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/model/user_model.dart';
import 'package:taxiapp/pages/map_page.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key});

  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return FirebaseAuth.instance
        .signInWithEmailAndPassword(
          email: data.name!,
          password: data.password!,
        )
        .then((_) => null)
        .catchError((e) {
      debugPrint('Hata: $e');
      return 'Giriş yapılamadı: $e';
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return FirebaseAuth.instance
        .createUserWithEmailAndPassword(
          email: data.name!,
          password: data.password!,
        )
        .then((_) => null)
        .catchError((e) {
      debugPrint('Hata: $e');
      return 'Hesap oluşturulamadı: $e';
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return FirebaseAuth.instance
        .sendPasswordResetEmail(email: name)
        .then((_) => 'Şifre sıfırlama maili gönderildi')
        .catchError((e) {
      debugPrint('Hata: $e');
      return 'Hata: $e';
    });
  }

  //  decoration: BoxDecoration(
  //           image: DecorationImage(
  //             fit: BoxFit.cover,
  //             image: NetworkImage(
  //                 'https://storage.googleapis.com/thepangeapost/static/login-register-bg.png'),
  //           ),
  //         ),
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SingleChildScrollView(
        child: Container(
          height:
              MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
          child: FlutterLogin(
            title: 'TaxiApp',
            logo: AssetImage('./assets/car.png'),
            onLogin: _authUser,
            onSignup: _signupUser,
            loginProviders: <LoginProvider>[
              LoginProvider(
                icon: FontAwesomeIcons.google,
                callback: () async {
                  // Google ile giriş yapmak için gerekli kodları buraya ekleyin
                  return null;
                },
              ),
              LoginProvider(
                icon: FontAwesomeIcons.facebookF,
                callback: () async {
                  // Facebook ile giriş yapmak için gerekli kodları buraya ekleyin
                  return null;
                },
              ),
              LoginProvider(
                icon: FontAwesomeIcons.linkedinIn,
                callback: () async {
                  // LinkedIn ile giriş yapmak için gerekli kodları buraya ekleyin
                  return null;
                },
              ),
              LoginProvider(
                icon: FontAwesomeIcons.instagram,
                callback: () async {
                  // Instagram ile giriş yapmak için gerekli kodları buraya ekleyin
                  return null;
                },
              ),
            ],
            onSubmitAnimationCompleted: () {
              User? user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                // Provider'a kullanıcı bilgilerini aktar
                Provider.of<UserModel>(context, listen: false).setUser(user);

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              } else {
                print('Kullanıcı bilgisi alınamadı');
              }
            },
            onRecoverPassword: _recoverPassword,
          ),
        ),
      ),
    );
  }
}
