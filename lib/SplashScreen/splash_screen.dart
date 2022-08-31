import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration:const Duration(seconds: 5),
      vsync: this)..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5),
        () => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>const HomePage())));
  }

  @override
  void dispose(){
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black38,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:
          [
            AnimatedBuilder(
              child: const Center(
                child: Image(image: AssetImage('images/virus.png'),),
              ),
                animation: _controller,
                builder: (BuildContext context, Widget? child)
                {
                  return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                    child: child,
                  );
                }
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),

            const Align(
              alignment: Alignment.center,
                child: Text("Covid-19\nTracker App", textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)
            ),
          ],
        ),
      ),
    );
  }
}
