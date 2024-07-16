import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_roof/auth_helper.dart';
import 'package:smart_roof/route/routing_constants.dart';
import 'package:smart_roof/utility/home/card.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late var _sliderValue = 50.0;
  final websiteUrl = Uri.parse('https://github.com/ZeonAyase/Smart-Roof-Flutter-');

  //firestore
  final FirebaseFirestore db = FirebaseFirestore.instance;
  //realtime database
  final rtdb = FirebaseDatabase.instanceFor(app: Firebase.app(),
      databaseURL:
      'https://smart-roof-4cca3-default-rtdb.asia-southeast1.firebasedatabase.app/'
  ).ref();
  /*final DatabaseReference rtdbMode = FirebaseDatabase.instance.ref();*/

  String modeText  = '';
  String stateText = '';
  String modeString = '';
  String stateString = '';
  bool roofState   = false;
  String modeData = '';
  String stateData = '';

  /*void updateSliderValue(double newValue) {
    rtdb.child('slider').set(newValue);
  }*/

  /*void updateModeRtdb(String value) {
    rtdb.child('mode/options').set(value);
  }

  void updateStateRtdb(String value) {
    rtdb.child('state/options').set(value);
  }*/

  currentUser() {
    final User? user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid.toString();
    return uid;
  }

  Future getUserName() async {
    return FirebaseAuth.instance.currentUser;
  }

  /*void openRoof() {
    setState(() {
      roofState = false;
      updateMode('Manual');
    });
  }

  void closeRoof() {
    setState(() {
      roofState = true;
      updateMode('Manual');
    });
  }

  void updateMode(String mode){
    setState(() {
      if(mode == 'Auto'){
        modeText = 'Auto';
        stateText = '';
      }else if(mode == 'Manual'){
        modeText = 'Manual';
        if(roofState){
          stateText = 'Close';
        } else {
          stateText = 'Open';
        }
      }
    });
  }*/

  /*Future<String> getModeValueFromFirebase() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('mode/options').get();
    String modeValue = snapshot.value.toString();
    return modeValue;
  }

  Future<String> getStateValueFromFirebase() async {
    final ref = FirebaseDatabase.instance.ref();
    final snapshot = await ref.child('state/options').get();
    String stateValue = snapshot.value.toString();
    return stateValue;
  }*/

  /*Future<void> modeUpdateString() async{
    DatabaseEvent eventMode  = await rtdb.child('/mode/options').once();
    String modeString = eventMode.toString();
  }

  Future<void> stateUpdateString() async{
    DatabaseEvent eventState  = await rtdb.child('/state/options').once();
    String stateString = eventState.toString();
  }*/

    @override
  Widget build(BuildContext context) {
    void updateSliderValue(double value) async {
      await rtdb.child('/slider').set(value);
    }
    void updateModeValue(String text) async {
      await rtdb.child('/mode/options').set(text);
    }
    void updateStateValue(String text) async {
      await rtdb.child('/state/options').set(text);
    }

    final DatabaseReference rtdbMode = FirebaseDatabase.instanceFor(app: Firebase.app(),
        databaseURL:
        'https://smart-roof-4cca3-default-rtdb.asia-southeast1.firebasedatabase.app/'
    ).ref('/mode/options');
    rtdbMode.onValue.listen((DatabaseEvent event){
      if(event.snapshot.value != null){
        String modeDataValue = event.snapshot.value.toString();
        setState(() {
          modeData = modeDataValue;
        });
      }
    });

    setState(() {
      if(modeData == 'Auto') {
        modeText = 'Auto';
        stateText = '';
      } else if(modeData == 'Manual') {
        modeText = 'Manual';
        if (stateData == 'Close') {
          stateText = 'Close';
        }else if (stateData == 'Open') {
          stateText = 'Open';
        }
      }
    });

    final DatabaseReference rtdbState = FirebaseDatabase.instanceFor(app: Firebase.app(),
        databaseURL:
        'https://smart-roof-4cca3-default-rtdb.asia-southeast1.firebasedatabase.app/'
    ).ref('/state/options');
    rtdbState.onValue.listen((DatabaseEvent event){
      if(event.snapshot.value != null){
        String stateDataValue = event.snapshot.value.toString();
        setState(() {
          stateData = stateDataValue;
        });
      }
    });

    //final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,  
      backgroundColor: const Color.fromRGBO(32, 31, 37, 1),      
      appBar: appBar(),
      drawer: menuBar(context),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 45),
                alignment: Alignment.centerLeft,
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                     const Text(
                      'Mode : ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(242, 242, 242, 1),
                      ),
                    ),
                    Text(
                      modeText,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(242, 242, 242, 1),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomCard(
                      title: 'Auto',
                      svgPath: 'assets/icons/a-solid.svg',
                      color: const Color.fromRGBO(255, 213, 0, 1),
                      onPressed: (){
                        /*modeUpdateString();*/
                        updateModeValue('Auto');
                      },
                    ),
                    CustomCard(
                      title: 'Manual',
                      svgPath: 'assets/icons/m-solid.svg',
                      color: const Color.fromRGBO(60, 213, 244, 1),
                      onPressed: (){
                        /*modeUpdateString();*/
                        updateModeValue('Manual');
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 45),
                alignment: Alignment.centerLeft,
                height: 50,
                width: double.infinity,
                //color: Colors.amber,
                child: Row(
                  children: [
                     const Text(
                      'State : ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(242, 242, 242, 1),
                      ),
                    ),
                    Text(
                      stateText,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(242, 242, 242, 1),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 200,
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomCard(
                      title: 'Open',
                      svgPath: 'assets/icons/Open.svg',
                      color: const Color.fromRGBO(183, 132, 255, 1),
                      onPressed: (){
                        /*modeUpdateString();*/
                        updateStateValue('Open');
                      },
                    ),
                    CustomCard(
                      title: 'Close',
                      svgPath: 'assets/icons/Close.svg',
                      color: const Color.fromRGBO(241, 142, 175, 1),
                      onPressed: (){
                        /*modeUpdateString();*/
                        updateStateValue('Close');
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 45),
                alignment: Alignment.centerLeft,
                height: 50,
                width: double.infinity,
                //color: Colors.amber,
                child: Row(
                  children: [
                    const Text(
                      'Speed : ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(242, 242, 242, 1),
                      ),
                    ),
                    Text(
                      _sliderValue.toStringAsFixed(0),
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(242, 242, 242, 1),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(41, 39, 48, 1),
                  borderRadius: BorderRadius.all(Radius.circular(17)),
                ),
                margin: const EdgeInsets.only(left: 30, right: 30),
                height: 85,
                width: double.infinity,
                child: Center(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      valueIndicatorTextStyle:
                      const TextStyle(color: Color.fromRGBO(32, 31, 37, 1),
                      ),
                      trackHeight: 17,
                      overlayColor: const Color.fromRGBO(32, 31, 37, 1),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 13),
                    ),
                    child: Slider(
                      value: _sliderValue,
                      min: 50,
                      max: 250,
                      divisions: 2,
                      activeColor: const Color.fromRGBO(242, 242, 242, 1),
                      label: _sliderValue.round().toString(),
                      onChanged: (newValue) {
                        _sliderValue = double.parse(newValue.toStringAsFixed(2));
                        setState(() => _sliderValue = newValue);
                      },
                      onChangeEnd: (newValue) {
                        updateSliderValue(newValue);
                      }
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Drawer menuBar(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromRGBO(32, 31, 37, 1),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 20, 0, 0),
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Color.fromRGBO(51, 131, 152, 1)
              ),
                currentAccountPicture: const Icon(
                  CupertinoIcons.person_alt_circle_fill,
                  color: Color.fromRGBO(242, 242, 242, 1),
                  size: 65,
                ),
                accountName: const Text(
                  'Welcome User',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Color.fromRGBO(242, 242, 242, 1),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  '${FirebaseAuth.instance.currentUser?.email}',
                  style: const TextStyle(
                    color: Color.fromRGBO(242, 242, 242, 1),
                    fontSize: 18,
                  ),
                ),
            ),

            ListTile(
              leading: const Icon(Icons.home,
                  color: Color.fromRGBO(242, 242, 242, 1)
              ),
              title: const Text('Home',
                style: TextStyle(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.monitor_rounded,
                  color: Color.fromRGBO(242, 242, 242, 1)
              ),
              title: const Text('Monitor',
                style: TextStyle(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                Navigator.pushNamed(context, monitorPageRoute);
              },
            ),
            ListTile(
              leading: const Icon(Icons.terminal_rounded,
                  color: Color.fromRGBO(242, 242, 242, 1)
              ),
              title: const Text('Source Code',
                style: TextStyle(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  fontSize: 22,
                ),
              ),
              onTap: () => setState(() {
                Navigator.pop(context);
                launchUrl(websiteUrl, mode: LaunchMode.externalApplication);
              })
            ),
            ListTile(
              leading: const Icon(Icons.logout_rounded,
                  color: Color.fromRGBO(242, 242, 242, 1)
              ),
              title: const Text('Log out',
                style: TextStyle(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  fontSize: 22,
                ),
              ),
              onTap: () async {
                Navigator.pop(context);
                Navigator.pushNamed(context, splashPageRoute);
                await AuthHelper.signOut();
              },
            ),
            const Divider(
              thickness: 1.5,
              color: Color.fromRGBO(75, 91, 102, 1),
            ),
             Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20, 80, 0, 0),
              child: RichText(
                text: const TextSpan(
                  text: 'This app was developed by ',
                    style: TextStyle(
                      color: Color.fromRGBO(242, 242, 242, 1),
                      fontSize: 18,
                    ),
                  children: <TextSpan>[
                    TextSpan(text: 'Muhammad Luthfi Guntur Putra',
                      style: TextStyle(
                        color: Color.fromRGBO(242, 242, 242, 1),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ]
                )
              ),
            ),
          ],
        ),
      )
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color.fromRGBO(32, 31, 37, 1),
      elevation: 0.0,
      centerTitle: true,
      title: const Text('Smart Roof',
        style: TextStyle(
          color: Color.fromRGBO(242, 242, 242, 1),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: GestureDetector(
        onTap: () => {
        _scaffoldKey.currentState!.openDrawer()
        },
        child: Container(
          width: 35,
          height: 35,
          margin: const EdgeInsets.fromLTRB(30, 5, 5, 5),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(32, 31, 37, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/bars-solid.svg',
              height: 35,
              width: 35,
            ),
          )
        )
      ),
    );
  }
}
