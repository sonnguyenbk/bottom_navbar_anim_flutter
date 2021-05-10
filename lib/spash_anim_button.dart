import 'package:flutter/material.dart';

class SpashAnimButton extends StatefulWidget {
  @override
  _SpashAnimButtonState createState() => _SpashAnimButtonState();
}

class _SpashAnimButtonState extends State<SpashAnimButton>
    with TickerProviderStateMixin {
  static const DURATION = 500;
  bool selected = false;
  late final AnimationController controller;
  late final Animation<double> animation;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween<double>(begin: .3, end: .28).animate(
      CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn),
    );

    controller.addListener(() {
      setState(() {});
    });

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: animation.value,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(240),
          onTap: () {
            controller.forward();
            setState(() {
              selected = !selected;
            });
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(240),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                color: selected ? Colors.black : Colors.white,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: -200,
                    top: -50,
                    child: Opacity(
                      opacity: selected ? 1 : 0,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: DURATION),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(selected ? 0 : 1000),
                        ),
                        width: selected
                            ? MediaQuery.of(context).size.width + 200
                            : 1,
                        height: 300,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -200,
                    top: -50,
                    child: Opacity(
                      opacity: selected ? 0 : 1,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: DURATION),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.circular(!selected ? 0 : 1000),
                        ),
                        width: !selected
                            ? MediaQuery.of(context).size.width + 200
                            : 1,
                        height: 300,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 60,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 60,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
