import 'package:com.firebase_test/HomeScreen.dart';
import 'package:com.firebase_test/splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'HomeScreen.dart';
import 'package:com.firebase_test/globals.dart';

String email;
String password;
String errorMessage;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final _key = GlobalKey();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

const kTextFieldDecoration = InputDecoration(
  hintStyle: TextStyle(fontSize: 20.0, color: Colors.white),
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
  filled: true,
  fillColor: Colors.white30,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30)),
    borderSide: BorderSide.none,
  ),
);

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState
    extends State<MyLoginPage> // with TickerProviderStateMixin
{
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // double _opacity = 0.0;
  // double _opacity2 = 0.0;
  // AnimationController controller;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   controller = AnimationController(
  //     vsync: this,
  //     duration: Duration(seconds: 2),
  //   );
  //   controller.repeat();
  //   Future.delayed(Duration(milliseconds: 1), () {
  //     _opacity2 = 1;
  //   });
  //   Future.delayed(Duration(milliseconds: 1), () {
  //     _opacity = 1;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blueAccent, Colors.blue, Colors.lightBlue],
            ),

            // image: DecorationImage(
            //   image: AssetImage('images/background.jpg'),
            //   fit: BoxFit.cover,
            // ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'RDS\nWeekly Report',
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          child: Lottie.asset('images/lightBulb.json',
                              height: 100),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 40, right: 140),
                      child: Text(
                        'Silahkan Login!',
                        style: TextStyle(
                          fontSize: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: TextField(
                          onChanged: (value) {
                            email = value;
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(color: Colors.white, fontSize: 23),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Email',
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 15),
                        child: TextField(
                          onChanged: (value) {
                            password = value;
                          },
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          style: TextStyle(color: Colors.white, fontSize: 23),
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Password',
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Text(
                      //     'Lupa Password?',
                      //     style: TextStyle(
                      //       fontSize: 18,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // User user = FirebaseAuth.instance.currentUser;
                          try {
                            await _auth.signInWithEmailAndPassword(
                                email: email, password: password);


                            if (_auth != null) {
                              // Singleton().emailnya = email;
                              showDialog(
                                  builder: (context) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 40, vertical: 250),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(40)),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Lottie.asset(
                                                  'images/79952-successful.json',
                                                  height: 150),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Material(
                                                  child: Text("Welcome!"),
                                                  color: Colors.white,
                                                  type: MaterialType.card,
                                                  textStyle: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  context: context);
                              Future.delayed(Duration(seconds: 1), () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              });
                            }
                          } catch (error) {
                            switch (error.toString()) {
                              case "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.":
                                errorMessage = "Email atau Password Salah!";
                                break;
                              case "[firebase_auth/invalid-email] The email address is badly formatted.":
                                errorMessage = "Format Email Salah";
                                break;
                              case "[firebase_auth/unknown] Given String is empty or null":
                                errorMessage =
                                    "Silahkan masukan Email/Password";
                                break;

                              case "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.":
                                errorMessage = "Email atau Password Salah!";
                                break;

                              default:
                                errorMessage =
                                    "Login gagal, Silahkan coba lagi.";
                                break;
                            }
                            print(error.toString());

                            showDialog(
                                builder: (context) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 40, vertical: 250),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40)),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Lottie.asset(
                                                'images/58412-cross-close-cancel-icon-animation.json',
                                                height: 150),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Material(
                                                child: Text(errorMessage),
                                                color: Colors.white,
                                                type: MaterialType.card,
                                                textStyle: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                context: context);
                          }
                          if (errorMessage != null) {
                            return Future.error(errorMessage);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 6),
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 55, vertical: 15),
                            child: Text(
                              'Sign in',
                              style: TextStyle(
                                  fontSize: 23, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Lottie.asset('images/w_background.json',
                            alignment: Alignment.center, height: 200),
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
