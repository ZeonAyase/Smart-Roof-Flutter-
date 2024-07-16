import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SensorCard extends StatelessWidget {
  const SensorCard({
    super.key,
    required this.value,
    required this.name,
    required this.unit,
    required this.trendData,
    required this.linePoint,
    required this.assetIcon,
  });

  final double value;
  final String name;
  final String unit;
  final List<double> trendData;
  final Color linePoint;
  final String assetIcon;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
      ),
      color: const Color.fromRGBO(41, 39, 48, 1),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 200,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(assetIcon,
                    height: 50,
                    width: 50,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    name, 
                    style: const TextStyle(
                      color: Color.fromRGBO(242, 242, 242, 1),
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '$value$unit',
                    style: const TextStyle(
                      color: Color.fromRGBO(242, 242, 242, 1),
                      fontSize: 18,
                    ),
                  ),
                ],
              )
            ),
            const VerticalDivider(
              width: 5,
              thickness: 3.5,
              color: Color.fromRGBO(32, 31, 37, 1),
            ),
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 12
                ),
                child: Sparkline(
                  data: trendData,
                  lineWidth: 10.0,
                  lineColor: const Color.fromRGBO(242, 242, 242, 1),
                  averageLine: true,
                  fillMode: FillMode.above,
                  sharpCorners: false,
                  pointsMode: PointsMode.last,
                  pointSize: 18,
                  pointColor: linePoint,
                  useCubicSmoothing: true,
                  cubicSmoothingFactor: 0.2,
                  fillColor: Colors.transparent,
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}