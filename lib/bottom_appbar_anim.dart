import 'dart:math';

import 'package:flutter/material.dart';

class BottomAppBarAnim extends StatefulWidget {
  @override
  _BottomAppBarAnimState createState() => _BottomAppBarAnimState();
}

class _BottomAppBarAnimState extends State<BottomAppBarAnim>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> paddingAnim;
  late final Animation<double> paddingAnim01;
  late final Animation<double> godownAnim;
  late final Animation<double> rotateAnim;
  late final Animation<double> goupAnim;
  static const ICON_COLOR = Color(0xffAEB3D9);
  static const ICON_SIZE = 34.0;
  bool onClick = false;
  bool show = false;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000));

    rotateAnim = Tween<double>(begin: 0, end: pi / 2).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.1,
          0.3,
          curve: Curves.easeIn,
        )));
    godownAnim = Tween<double>(begin: 0, end: 40).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.1,
          0.3,
          curve: Curves.fastOutSlowIn,
        )));

    goupAnim = Tween<double>(begin: 0, end: -45).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.3,
          0.5,
          curve: Curves.elasticOut,
        )));

    paddingAnim = Tween<double>(begin: 0, end: 20).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.1,
          0.3,
          curve: Curves.fastOutSlowIn,
        )));

    paddingAnim01 = Tween<double>(begin: 0, end: 20).animate(CurvedAnimation(
        parent: controller,
        curve: Interval(
          0.3,
          0.5,
          curve: Curves.fastOutSlowIn,
        )));
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AnimatedPositioned(
            duration: Duration(milliseconds: 1000),
            left: 0,
            right: 0,
            curve: Curves.elasticInOut,
            bottom: show ? 160 : 80,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.camera_alt,
                color: Colors.black,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
            ),
            child: Container(
              height: 160,
              width: MediaQuery.of(context).size.width,
              child: CustomPaint(
                painter: SpringAnimBorderCustomPainter(
                  denta: godownAnim.value + goupAnim.value,
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(
                      horizontal: paddingAnim.value - paddingAnim01.value),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.home,
                        color: ICON_COLOR,
                        size: ICON_SIZE,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: paddingAnim.value - paddingAnim01.value),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {
                              controller.reset();
                              controller.forward();
                              setState(() {
                                onClick = true;
                                show = !show;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Transform.rotate(
                                angle: rotateAnim.value,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.purple,
                                  size: ICON_SIZE,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.settings,
                        color: ICON_COLOR,
                        size: ICON_SIZE,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SpringAnimBorderCustomPainter extends CustomPainter {
  final double denta;
  final double radius;
  SpringAnimBorderCustomPainter({this.denta = 0, this.radius = 10});
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    path.moveTo(30, 20);
    path.quadraticBezierTo(size.width / 2, 20 + denta, size.width - 30, 20);
    path.quadraticBezierTo(size.width, 20, size.width, 10 + 20);

    path.lineTo(size.width, size.height + 20);
    path.lineTo(0, size.height);
    path.lineTo(0, 10 + 20);
    path.quadraticBezierTo(0, 20, 30, 20);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
