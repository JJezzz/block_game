import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playy',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override

  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  
  List<int> cardNumbers = [1, 2, 3, 4, 1, 2, 3, 4];

  List<bool> isCardFlipped = [];
  
  List<int> flippedCardIndices = [];
 
  int score = 0;
  
  bool isChecking = false;

  @override
  void initState() {
    super.initState();
    startNewGame();
  }

  void startNewGame() {
    setState(() {
      
      cardNumbers.shuffle();

      isCardFlipped = List.filled(cardNumbers.length, false);
      
      flippedCardIndices.clear();
    
      score = 0;
      isChecking = false;
    });
  }

  void flipCard(int index) {

    if (isCardFlipped[index] && flippedCardIndices.length == 2 && isChecking) {
      return;
    }

    setState(() {
     
      isCardFlipped[index] = true;
      
      flippedCardIndices.add(index);
    });

    if (flippedCardIndices.length == 2) {
      isChecking = true;
      Future.delayed(const Duration(milliseconds: 1000), () {
        checkForMatch();
      });
    }
  }

  void checkForMatch() {
    setState(() {
      int firstIndex = flippedCardIndices[0];
      int secondIndex = flippedCardIndices[1];

      if (cardNumbers[firstIndex] == cardNumbers[secondIndex]) {
       
        score++;
        
        flippedCardIndices.clear();
        isChecking = false;

       
        if (score == 4) {
          _showGameOverDialog();
        }
      } else {
        
        isCardFlipped[firstIndex] = false;
        isCardFlipped[secondIndex] = false;
        
        flippedCardIndices.clear();
        isChecking = false;
      }
    });
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Вітаємо!'),
          content: Text('Ви знайшли всі пари! Ваш рахунок: $score'),
          actions: <Widget>[
            TextButton(
              child: const Text('Грати знову'),
              onPressed: () {
                Navigator.of(context).pop();
                startNewGame();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Playy'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: startNewGame,
          ),
        ],
      ),
      body: Column(
        children: [
          
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Рахунок: $score',
              style: const TextStyle(fontSize: 24),
            ),
          ),
          
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, 
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.0, 
              ),
              itemCount: cardNumbers.length, 
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => flipCard(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      color: isCardFlipped[index] ? Colors.white : Colors.pink,
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: isCardFlipped[index]
                            ? Text(
                                '${cardNumbers[index]}',
                                key: ValueKey<int>(cardNumbers[index]),
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              )
                            : const Text('?'), 
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}