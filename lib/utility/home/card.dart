import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class CustomCard extends StatefulWidget {
  final String title, svgPath;
  final Color color;
  final void Function()? onPressed;

  const CustomCard ({super.key, 
    required this.title, 
    required this.svgPath,
    required this.color,
    required this.onPressed});

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {

  // @override
  // void initState() {
  //   super.initState();
  //   neon = widget.neon;
  // }
  //
  // void changeNeon(){
  //   setState(() {
  //     neon = widget.neon;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Card(
     elevation: 0,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            color: const Color.fromRGBO(32, 31, 37, 1),
            child: CustomPaint(
              painter: BnbCustomPainter(),
            ),
          ),
          SizedBox(
            width: 150,
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  //margin: EdgeInsets.only(bottom: -5),
                  width: 63,
                  height: 63,
                  child: Stack(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: widget.color,
                              blurRadius: 15.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                      ),
                      Container (
                        alignment: Alignment.center,
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(32, 31, 37, 1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 5,
                            color: const Color.fromRGBO(75, 91, 102, 1)
                          )
                        ),
                        child: SvgPicture.asset(widget.svgPath,
                        height: 32,
                        width: 32,
                        ),
                      ),
                    ]
                  ),  
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(widget.title,
                      style: const TextStyle(
                        color: Color.fromRGBO(242, 242, 242, 1),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
              ]
            ),
          ),
          Positioned(
            bottom: -28,
            child: ElevatedButton(
              onPressed: widget.onPressed,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(5),
                backgroundColor: const Color.fromRGBO(32, 31, 37, 1), // <-- Button color
                foregroundColor: const Color.fromRGBO(32, 31, 37, 1), // <-- Splash color
              ),
              child: SvgPicture.asset('assets/icons/circle-dot-regular.svg',
                  height: 45,
                  width: 45,
              ),
            ),
          ),
        ]
      ),
    );
  }
}

class BnbCustomPainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {

    Path path_0 = Path();
    path_0.moveTo(size.width*0.1343214,0);
    path_0.lineTo(size.width*0.8656786,0);
    path_0.cubicTo(size.width*0.9398631,0,size.width,size.height*0.06160366,size.width,size.height*0.1375976);
    path_0.lineTo(size.width,size.height*0.8624024);
    path_0.cubicTo(size.width,size.height*0.9383963,size.width*0.9398631,size.height,size.width*0.8656786,size.height);
    path_0.lineTo(size.width*0.7690476,size.height);
    path_0.cubicTo(size.width*0.6379940,size.height*0.9440671,size.width*0.6502857,size.height*0.8188415,size.width*0.5002143,size.height*0.8090061);
    path_0.cubicTo(size.width*0.3492560,size.height*0.8206280,size.width*0.3676548,size.height*0.9415366,size.width*0.2305833,size.height);
    path_0.lineTo(size.width*0.1343214,size.height);
    path_0.cubicTo(size.width*0.06013690,size.height,0,size.height*0.9383963,0,size.height*0.8624024);
    path_0.lineTo(0,size.height*0.1375976);
    path_0.cubicTo(0,size.height*0.06160366,size.width*0.06013690,0,size.width*0.1343214,0);
    path_0.close();

    Paint paint0Fill = Paint()..
    color = const Color.fromRGBO(41, 39, 48,1)..
    style =PaintingStyle.fill;
    canvas.drawPath(path_0,paint0Fill);
  } 
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}