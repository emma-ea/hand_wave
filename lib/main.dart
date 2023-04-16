import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    const MaterialApp(
      title: 'Wave',
      home:  MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatefulWidget {
  
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  late AnimationController _waveController;
  late Animation<double> _waveAnim;
  late Tween<double> _waveTween;

  int waveDuration = 150;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(vsync: this, duration: Duration(milliseconds: waveDuration));
    _waveTween = Tween<double>(begin: -5.0, end: 30.0);
    _waveAnim = _waveTween.animate(_waveController);
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox.shrink(),
          _buildWaveHand(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Tap to wave'),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: const Text('Hello', style: TextStyle(color: Colors.black)), //_buildWaveHand(),
      actions: const [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12), 
          child: Icon(Icons.widgets, color: Colors.black,),
        ),
      ],
    );
  }

  Widget _buildWaveHand() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Hello there ',
          style: GoogleFonts.lexend(fontSize: 24),
        ),
        AnimatedBuilder(
          animation: _waveAnim, 
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()..rotateZ(_waveAnim.value.toRad),
              alignment: Alignment.bottomRight,
              child: child,
            );
          },
          child: GestureDetector(onTap: _startWaveAnim ,child: const Text('👋', style: TextStyle(fontSize: 24),)),
        ),
      ],
    );
  }

  void _startWaveAnim() {
    final ticker = _waveController.repeat(reverse: true);
    ticker.timeout(Duration(milliseconds: waveDuration * 6), onTimeout: () {
      _waveController.stop();
      _waveController.animateTo(0.0);
    });
  }

}

extension on double {
  double get toRad => this * ( pi / 180 );
}
