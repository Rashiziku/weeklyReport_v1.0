import 'package:com.firebase_test/main.dart';
import 'package:com.firebase_test/menu/account.dart';
import 'package:com.firebase_test/menu/lihat_laporan.dart';
import 'package:com.firebase_test/menu/setting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';


import 'menu/buat_laporan.dart';

const kPrimaryColor = Color(0xFF6061FA);
const kBackgroundColor = Color(0xFFFFFFFF);
const kErrorColor = Color(0xFFFE5350);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Material listMenu(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0x802196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        heading,
                        style: TextStyle(
                          color: new Color(color),
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  // final _auth = FirebaseAuth.instance;
  // User loggedInUser;
  //
  // void getCurrentUser() async {
  //   try {
  //     final User user = _auth.currentUser;
  //     loggedInUser = user;
  //     print(loggedInUser.email);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Text(
              'Weekly Report Menu',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          flexibleSpace: Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.lightBlueAccent],
        )
      ),
    ),
        ),

        body: StaggeredGridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          children: <Widget>[
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => buatLaporan()));
              },
              child: listMenu(Icons.sticky_note_2, "Buat Report", 0xffed622b),
            ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context, MaterialPageRoute(builder: (context) => pengaturan()));
            //   },
            //   child: listMenu(Icons.settings, "Setting", 0xff26cb3c),
            // ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (context) => lihatLaporan()));
            //   },
            //   child: listMenu(Icons.graphic_eq, "Lihat Report", 0xffff3266),
            // ),
            // InkWell(
            //   onTap: () {
            //     Navigator.push(
            //         context, MaterialPageRoute(builder: (context) => account()));
            //   },
            //   child: listMenu(Icons.account_circle, "Account", 0xff0288d1),
            // ),
            Builder(builder: (context) {
              return InkWell(
                  child:
                      listMenu(Icons.arrow_back_outlined, "Keluar", 0xff4527a0),
                  onTap: () async {
                    try {
                      await _auth.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (c) => MyLoginPage()),
                          (r) => false);
                    } catch (e) {
                      Get.snackbar('Error occured!', e.toString(),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: kPrimaryColor,
                          colorText: kBackgroundColor);
                    }
                  });
            }),
          ],
          staggeredTiles: [
            StaggeredTile.extent(2, 200.0),
            StaggeredTile.extent(2, 250.0),
            StaggeredTile.extent(1, 250.0),
            StaggeredTile.extent(1, 250.0),
            StaggeredTile.extent(1, 150.0),
          ],
        ),

      ),
    );
  }
}
