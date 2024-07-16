import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_roof/pages/home/home.dart';
import 'package:smart_roof/utility/monitor/sensor_card.dart';
import 'package:smart_roof/utility/monitor/sensor_define/sensor_define.dart';

class MonitorPage extends StatefulWidget {
  const MonitorPage({super.key});
    @override
  State<MonitorPage> createState() => _MonitorPage();
}

class _MonitorPage extends State<MonitorPage>{
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();

  List<double>? ldrList;
  List<double>? rainList;

  static String sensorCollection = 'sensorData';

  final db = FirebaseFirestore.instance.collection(sensorCollection)
      .withConverter<Sensor>(
      fromFirestore: (snapshots, _) => Sensor.fromJson(snapshots.data()!),
    toFirestore: (movie, _) => movie.toJson(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,  
      backgroundColor: const Color.fromRGBO(32, 31, 37, 1),      
      appBar: appBar(context),
      //drawer: menuBar(context),
      body: StreamBuilder<QuerySnapshot<Sensor>>(
        stream: db.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          if (ldrList == null) {
            ldrList = List.filled(5, data.docs.first.data().ldr.toDouble(),
                growable: true);
          } else {
            ldrList!.add(data.docs.first.data().ldr.toDouble());
            ldrList!.removeAt(0);
          }

          if (rainList == null) {
            rainList =
                List.filled(5, data.docs.first.data().rain.toDouble(), growable: true);
          } else {
            rainList!.add(data.docs.first.data().rain.toDouble());
            rainList!.removeAt(0);
          }
          return Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(30, 20, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SensorCard(
                    value: data.docs.first.data().ldr.toDouble(),
                    unit: '%',
                    name: 'LDR',
                    assetIcon: 'assets/icons/sun-solid.svg',
                    trendData: ldrList!,
                    linePoint: const Color.fromRGBO(51, 131, 152, 1),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SensorCard(
                    value: data.docs.first.data().rain.toDouble(),
                    unit: '%',
                    name: 'Rain',
                    assetIcon: 'assets/icons/droplet-solid.svg',
                    trendData: rainList!,
                    linePoint: const Color.fromRGBO(51, 131, 152, 1),
                  ),
                  const SizedBox(
                    height: 150,
                  ),
                ],
              ),
          );
        }
      ),
    );
  }

 /* Drawer menuBar(BuildContext context) {
    return Drawer(
      child: Container(color: const Color.fromRGBO(32, 31, 37, 1),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home',
                style: TextStyle(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, 
                MaterialPageRoute(builder: (context) => 
                HomePage(),));// Close the drawer
              },
            ),
            ListTile(
              leading: const Icon(Icons.monitor_rounded,),
              title: const Text('Monitor',
                style: TextStyle(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  fontSize: 22,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.terminal_rounded),
              title: const Text('Source Code',
                style: TextStyle(
                  color: Color.fromRGBO(242, 242, 242, 1),
                  fontSize: 22,
                ),
              ),
              onTap: () {
                
                },
            ),
          ],
        ),
      ),
    );
  } */

  AppBar appBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color.fromRGBO(32, 31, 37, 1),
      elevation: 0.0,
      centerTitle: true,
      title: const Text('Monitor',
        style: TextStyle(
          color: Color.fromRGBO(242, 242, 242, 1),
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: GestureDetector(
        onTap: () => {
          Navigator.push(context, 
          MaterialPageRoute(builder: (context) => 
          const HomePage(),))
        },
        child: Container(
          width: 30,
          height: 30,
          margin: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(32, 31, 37, 1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/angle-left-solid.svg',
              height: 28,
              width: 28,
            ),
          )
        )
      ),
    );
  }
}