import 'dart:async';
import 'package:block_game/main.dart';
import 'package:flutter/material.dart';
import 'game_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _startLoading();
  }

  void _startLoading() {
    const totalDuration = 10; // 10 секунд
    const updateInterval = 100; // оновлювати кожні 100 мс
    
    int elapsed = 0;
    
    Timer.periodic(Duration(milliseconds: updateInterval), (timer) {
      elapsed += updateInterval;
      setState(() {
        _progress = elapsed / (totalDuration * 1000);
      });
      
      if (elapsed >= totalDuration * 1000) {
        timer.cancel();
        _navigateToMain();
      }
    });
  }

  void _navigateToMain() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => GameScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 85, 15, 154),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 120),
                      Text(
                        'Pixel Quest',
                        style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 50, 1, 76),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // Смуга завантаження внизу
              Padding(
                padding: EdgeInsets.only(bottom: 100, left: 40, right: 40),
                child: Column(
                  children: [
                    // Смуга завантаження
                    Container(
                      height: 12,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: _progress,
                          backgroundColor: Color.fromARGB(255, 50, 1, 76),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Color.fromARGB(255, 226, 195, 255),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    
                    // Відсотки завантаження
                    Text(
                      '${(_progress * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 226, 195, 255),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    
                    // Текст завантаження
                    Text(
                      _getLoadingText(_progress),
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
  
  String _getLoadingText(double progress) {
    if (progress < 0.3) return 'Завантаження ресурсів...';
    return 'Майже готово...';
  }
}