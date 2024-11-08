import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:taxiapp/class/app_color.dart';
import 'package:taxiapp/class/model/theme.dart';
import 'package:taxiapp/class/model/user_model.dart';
import 'package:taxiapp/class/widget_class.dart';
import 'package:taxiapp/pages/map_page.dart';
import 'package:taxiapp/splash_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Duration get loginTime => Duration(milliseconds: 2250);
  bool _isButtonChecked = false;
  bool _isChecked = false;
  int _currentIndex = 0;

  TextEditingController nameSurnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController emailControllerForLogin = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordControllerForLogin = TextEditingController();
  TextEditingController cinsiyetController = TextEditingController();
  TextEditingController yasController = TextEditingController();
  TextEditingController imgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    File? _image;
    final _picker = ImagePicker();
    // PermissionStatus? _cameraPermissionStatus;
    // PermissionStatus? _filePermissionStatus;
    Future<void> _checkPermissions() async {
      final cameraStatus = await Permission.camera.status;
      final storageStatus = await Permission.storage.status;

      if (cameraStatus.isGranted && storageStatus.isGranted) {
        // Kamera ve depolama izinleri verilmişse devam edebilirsiniz.
        // İşlemlerinizi burada gerçekleştirin.
        // setState(() {
        //   _cameraPermissionStatus = cameraStatus;
        //   _filePermissionStatus = storageStatus;
        // });
      } else {
        // Kullanıcı izinleri vermemiş veya reddetmişse, izin isteyin.
        final List<Permission> permissionsToRequest = [];

        if (!cameraStatus.isGranted) {
          permissionsToRequest.add(Permission.camera);
        }

        if (!storageStatus.isGranted) {
          permissionsToRequest.add(Permission.storage);
        }

        await permissionsToRequest.request();

        // Kullanıcı izinleri verildiyse veya reddetmediyse, işlemlerinizi gerçekleştirin.
        if (await Permission.camera.isGranted &&
            await Permission.storage.isGranted) {
          // Kullanıcı izinleri verildi, işlemlerinizi burada gerçekleştirin.
        } else {
          // Kullanıcı izinleri hala verilmedi veya reddedildi.
          // Kullanıcıyı ayarlara yönlendirebilirsiniz.
          openAppSettings();
        }
      }
    }

    Future<bool?> _authUser(String email, String sifre) {
      debugPrint('Name: ${email}, Password: ${sifre}');
      return FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: email,
        password: sifre,
      )
          .then((result) {
        if (result != null) {
          // Giriş başarılı oldu
          if (result.user != null) {
            final userEmail = result.user!.email;
            final userPassword = passwordControllerForLogin.text;

            if (userEmail!.isNotEmpty && userPassword.isNotEmpty) {
              debugPrint('Email ve şifre doğru.');
              // İstediğiniz işlemleri yapabilirsiniz.
              if (userEmail.isNotEmpty && userPassword.isNotEmpty) {
                debugPrint('Email ve şifre doğru.');
                // İstediğiniz işlemleri yapabilirsiniz.
                User? user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  // Provider'a kullanıcı bilgilerini aktar
                  Provider.of<UserModel>(context, listen: false).setUser(user);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SplashScreen()));
                  return true;
                } else {
                  print('Kullanıcı bilgisi alınamadı');
                  return false;
                }
              }
            } else {
              debugPrint('Email veya şifre yanlış.');
              return false;
            }
          } else {
            debugPrint('Kullanıcı bilgileri alınamadı.');
            return false;
          }
        } else {
          // Giriş başarısız oldu, result içinde hata mesajı bulunur
          debugPrint('Giriş başarısız: $result');
          return false;
          // Kullanıcıya hata mesajını gösterebilirsiniz.
        }
      }).catchError((e) {
        debugPrint('Hata: $e');
        return false;
      });
    }

    Future<String?> _signupUser(String name, String password) {
      debugPrint('Signup Name: ${name}, Password: ${password}');
      return FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: name,
            password: password,
          )
          .then((_) => null)
          .catchError((e) {
        debugPrint('Hata: $e');
        return e;
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

    // Galeriden resim seçme işlemi
    Future<void> _pickImageFromGallery() async {
      await _checkPermissions(); // İzinleri kontrol et

      final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _image = File(pickedImage.path);
        });
      }
    }

    Future<void> _takePhotoWithCamera() async {
      await _checkPermissions(); // İzinleri kontrol et

      final cameraStatus = await Permission.camera.status;
      if (cameraStatus.isGranted) {
        final pickedImage = await _picker.pickImage(source: ImageSource.camera);
        if (pickedImage != null) {
          setState(() {
            _image = File(pickedImage.path);
          });
        }
      } else {
        // Kamera izni verilmemişse kullanıcıya bilgi verin.,
        await Permission.camera.request();
        _checkPermissions();
      }
    }

    void _onClickButton() {
      setState(() {
        _currentIndex++;
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }

    @override
    void initState() {
      super.initState();
      _checkPermissions();
      _image = File(
          'assets/profil.png'); // Varsayılan bir resim atayın veya boş bir resim kullanabilirsiniz.
    }

    bool isDarkMode = Provider.of<ThemeNotifier>(context).isDarkMode;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Background image and logo.
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // Resim için Container
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/taksi.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Gradient için Container
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        isDarkMode == true
                            ? Colors.black38.withOpacity(0.0)
                            : Colors.white.withOpacity(0.0),
                        isDarkMode == true ? Colors.black38 : Colors.white
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Form fields.
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Provider.of<ThemeNotifier>(context).isDarkMode == true
                      ? AppColors.dark_theme.wigdetColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(
                      50), // Burada 10 piksel yuvarlaklık veriliyor.
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(40, 70, 40, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceEvenly, // Butonlar arası eşit boşluk bırakır.
                        children: <Widget>[
                          Expanded(
                            child: AnimatedContainer(
                              duration: Duration(
                                  //tprsoft@gmail.com
                                  milliseconds: 300), // Animasyon süresi
                              decoration: boxDecoration(),
                              child: TextButton(
                                child: Text('Kayıt Ol'),
                                onPressed: () {
                                  setState(() {
                                    _isButtonChecked = false;
                                  });
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Provider.of<ThemeNotifier>(context)
                                                      .isDarkMode ==
                                                  true
                                              ? Colors.white
                                              : Colors.black),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(Colors
                                          .transparent), // Tıklama efektini kaldır
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 20.0),
                          Expanded(
                            child: AnimatedContainer(
                              duration: Duration(
                                  milliseconds: 400), // Animasyon süresi
                              decoration: BoxDecoration(
                                color: _isButtonChecked
                                    ? Color.fromARGB(255, 255, 191, 0)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(80.0),
                              ),

                              child: TextButton(
                                child: Text('Giriş Yap'),
                                onPressed: () {
                                  setState(() {
                                    _isButtonChecked = true;
                                  });
                                },
                                style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Provider.of<ThemeNotifier>(context)
                                                      .isDarkMode ==
                                                  true
                                              ? Colors.white
                                              : Colors.black),
                                  overlayColor:
                                      MaterialStateProperty.all<Color>(Colors
                                          .transparent), // Tıklama efektini kaldır
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      _currentIndex == 0 && _isButtonChecked == false
                          ? Column(
                              children: [
                                SizedBox(height: 16.0),
                                // Name field.
                                TextFormField(
                                  controller: nameSurnameController,
                                  decoration: InputDecoration(
                                    labelText: 'İsim Soyisim',
                                    //labelStyle: TextStyle(color: Colors.black),
                                    prefixIcon: Icon(Icons.person),
                                    enabledBorder: OutlineInputBorder(
                                      // Etkin olmayan durum için kenarlık
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      // Odaklanıldığında kenarlık
                                      borderSide: BorderSide(
                                          color: Colors.yellow, width: 5),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                // Email field.
                                TextFormField(
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    labelText: 'E-Posta',
                                    prefixIcon: Icon(Icons.email),
                                    enabledBorder: OutlineInputBorder(
                                      // Etkin olmayan durum için kenarlık
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      // Odaklanıldığında kenarlık
                                      borderSide: BorderSide(
                                          color: Colors.yellow, width: 5),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: 16.0),
                                // Password field.
                                TextFormField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Şifre',
                                    prefixIcon: Icon(Icons.lock),
                                    enabledBorder: OutlineInputBorder(
                                      // Etkin olmayan durum için kenarlık
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2.0),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      // Odaklanıldığında kenarlık
                                      borderSide: BorderSide(
                                          color: Colors.yellow, width: 5),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                  ),
                                  obscureText: true,
                                ),
                                SizedBox(height: 24.0),
                              ],
                            )
                          : _currentIndex == 1 && _isButtonChecked == false
                              ? Column(
                                  children: [
                                    SizedBox(height: 16.0),
                                    // Password field.
                                    Text(
                                      'Profil Fotoğrafı',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 100,
                                      child: _currentIndex == 1 &&
                                              _isButtonChecked == false
                                          ? _image != null
                                              ? Image.file(_image!,
                                                  fit: BoxFit.cover)
                                              : Image.asset('assets/profil.png')
                                          : null, // Resim sadece belirli bir durumda görüntülenecek
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .center, // Butonları ortala
                                        children: [
                                          IconButton(
                                            onPressed: _takePhotoWithCamera,
                                            icon: Icon(FontAwesomeIcons.camera),
                                          ),
                                          SizedBox(width: 16.0),
                                          IconButton(
                                            onPressed: _pickImageFromGallery,
                                            icon: Icon(FontAwesomeIcons.image),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    // Name field.
                                    TextFormField(
                                      controller: cinsiyetController,
                                      decoration: InputDecoration(
                                        labelText: 'Cinsiyet',
                                        //labelStyle: TextStyle(color: Colors.black),
                                        prefixIcon:
                                            Icon(FontAwesomeIcons.genderless),
                                        enabledBorder: OutlineInputBorder(
                                          // Etkin olmayan durum için kenarlık
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          // Odaklanıldığında kenarlık
                                          borderSide: BorderSide(
                                              color: Colors.yellow, width: 5),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    // Email field.
                                    TextFormField(
                                      controller: yasController,
                                      decoration: InputDecoration(
                                        labelText: 'Yaş',
                                        prefixIcon: Icon(
                                            FontAwesomeIcons.odnoklassniki),
                                        enabledBorder: OutlineInputBorder(
                                          // Etkin olmayan durum için kenarlık
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2.0),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          // Odaklanıldığında kenarlık
                                          borderSide: BorderSide(
                                              color: Colors.yellow, width: 5),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                    SizedBox(height: 24.0),
                                  ],
                                )
                              : _isButtonChecked == true
                                  ? Column(
                                      children: [
                                        SizedBox(height: 16.0),
                                        // Name field.
                                        TextFormField(
                                          controller: emailControllerForLogin,
                                          decoration: InputDecoration(
                                            labelText: 'E-mail',
                                            //labelStyle: TextStyle(color: Colors.black),
                                            prefixIcon: Icon(Icons.email),
                                            enabledBorder: OutlineInputBorder(
                                              // Etkin olmayan durum için kenarlık
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              // Odaklanıldığında kenarlık
                                              borderSide: BorderSide(
                                                  color: Colors.yellow,
                                                  width: 5),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 16.0),
                                        // Email field.
                                        TextFormField(
                                          controller:
                                              passwordControllerForLogin,
                                          decoration: InputDecoration(
                                            labelText: 'Şifre',
                                            prefixIcon:
                                                Icon(Icons.password_outlined),
                                            enabledBorder: OutlineInputBorder(
                                              // Etkin olmayan durum için kenarlık
                                              borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              // Odaklanıldığında kenarlık
                                              borderSide: BorderSide(
                                                  color: Colors.yellow,
                                                  width: 5),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                          ),
                                          textInputAction: TextInputAction
                                              .done, // Klavyede 'Done' butonunu ayarlar
                                          onFieldSubmitted: (value) {
                                            _authUser(
                                                emailControllerForLogin.text,
                                                passwordControllerForLogin
                                                    .text);
                                          },
                                        ),
                                        SizedBox(height: 24.0),
                                      ],
                                    )
                                  : Container(),
                      // Terms and conditions.
                      _currentIndex == 0 || _isButtonChecked == true
                          ? Container()
                          : CheckboxListTile(
                              title: Text('Okudum ve kabul ediyorum.'),
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                });
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                              activeColor: Colors
                                  .amber, // Seçili olduğunda gösterilecek renk
                            ),
                      // Register button.
                      Container(
                        child: ElevatedButton(
                          child: _currentIndex == 1 && _isButtonChecked == false
                              ? Text('Kayıt Ol')
                              : _isButtonChecked == true
                                  ? Text('Giriş Yap')
                                  : Text('Devam Et'),
                          onPressed: () {
                            _currentIndex == 0 && _isButtonChecked == false
                                ? setState(() {
                                    _currentIndex++;
                                  })
                                : _currentIndex == 1
                                    ? _onClickButton()
                                    : _authUser(emailControllerForLogin.text,
                                        passwordControllerForLogin.text);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[700], // Buton rengi
                            textStyle: TextStyle(
                              fontSize: 20,
                            ),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15.0), // Buton yüksekliği.
                            // Renkler ve diğer stil ayarları.
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0), // Butonlar arası boşluk.
                    ],
                  ),
                ),
              ),
            ),
            _currentIndex > 0 && _isButtonChecked == false
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 32.0,
                          //color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Column columnForSignUp(
      TextEditingController controller1,
      TextEditingController controller2,
      TextEditingController controller3,
      String text1,
      String text2,
      String text3) {
    return Column(
      children: [
        SizedBox(height: 16.0),
        // Name field.
        MyTextFormField.textFormField(
          controller1,
          text1,
        ),
        SizedBox(height: 16.0),
        // Email field.
        MyTextFormField.textFormField(
          controller2,
          text2,
          inputType: TextInputType.emailAddress,
        ),
        SizedBox(height: 16.0),
        // Password field.
        MyTextFormField.textFormField(controller3, text3, obsure: true),
        SizedBox(height: 24.0),
      ],
    );
  }

  BoxDecoration boxDecoration() {
    return BoxDecoration(
      color: _isButtonChecked
          ? Colors.transparent
          : Color.fromARGB(255, 255, 191, 0),
      borderRadius: BorderRadius.circular(80.0),
    );
  }
}
