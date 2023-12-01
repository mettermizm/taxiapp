import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/model/user_model.dart';
import 'package:taxiapp/pages/map_page.dart';

const users = {
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

  //<TEXT> 'hello world' </TEXT>
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SingleChildScrollView(
        child: Container(
          height:
              MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
          child: FlutterLogin(
            theme: LoginTheme(pageColorDark: Colors.amber, pageColorLight: Colors.amber, primaryColor: Colors.black,  buttonStyle: TextStyle(color: Colors.white)),
            logo: AssetImage('./assets/project_taxi_son.png'),
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

/*
_currentIndex == 2 ? Column(
                        children: [
                          SizedBox(height: 16.0),
                          // Name field.
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'İsim Soyisim',
                              //labelStyle: TextStyle(color: Colors.black),
                              prefixIcon: Icon(Icons.person),
                              enabledBorder: OutlineInputBorder(
                                // Etkin olmayan durum için kenarlık
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                // Odaklanıldığında kenarlık
                                borderSide:
                                    BorderSide(color: Colors.yellow, width: 5),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                          ),
                          SizedBox(height: 16.0),
                          // Email field.
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'E-Posta',
                              prefixIcon: Icon(Icons.email),
                              enabledBorder: OutlineInputBorder(
                                // Etkin olmayan durum için kenarlık
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                // Odaklanıldığında kenarlık
                                borderSide:
                                    BorderSide(color: Colors.yellow, width: 5),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 16.0),
                          // Password field.
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Şifre',
                              prefixIcon: Icon(Icons.lock),
                              enabledBorder: OutlineInputBorder(
                                // Etkin olmayan durum için kenarlık
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                // Odaklanıldığında kenarlık
                                borderSide:
                                    BorderSide(color: Colors.yellow, width: 5),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            obscureText: true,
                          ),
                          SizedBox(height: 24.0),
                        ],
                      ) : 
 */









/*
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/model/user_model.dart';
import 'package:taxiapp/pages/map_page.dart';

const users = {
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


  //<TEXT> 'hello world' </TEXT>
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
*/