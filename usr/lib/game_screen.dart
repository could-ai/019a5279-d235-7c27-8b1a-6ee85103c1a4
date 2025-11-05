import 'dart:math';
import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late int _targetNumber;
  final TextEditingController _controller = TextEditingController();
  String _message = 'Guess a number between 1 and 100';
  int _guessCount = 0;
  bool _gameOver = false;

  @override
  void initState() {
    super.initState();
    _resetGame();
  }

  void _resetGame() {
    setState(() {
      _targetNumber = Random().nextInt(100) + 1;
      _message = 'Guess a number between 1 and 100';
      _controller.clear();
      _guessCount = 0;
      _gameOver = false;
    });
  }

  void _checkGuess() {
    if (_gameOver) return;

    final int? guess = int.tryParse(_controller.text);
    if (guess == null) {
      setState(() {
        _message = 'Please enter a valid number.';
      });
      return;
    }

    setState(() {
      _guessCount++;
      if (guess < _targetNumber) {
        _message = 'Too low! Try again.';
      } else if (guess > _targetNumber) {
        _message = 'Too high! Try again.';
      } else {
        _message = 'You guessed it in $_guessCount guesses!';
        _gameOver = true;
      }
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guess the Number'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  _message,
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your guess',
                  ),
                  onSubmitted: (_) => _checkGuess(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _checkGuess,
                  child: const Text('Guess'),
                ),
                const SizedBox(height: 20),
                if (_gameOver)
                  ElevatedButton(
                    onPressed: _resetGame,
                    child: const Text('Play Again'),
                  ),
                const SizedBox(height: 20),
                Text('Guesses: $_guessCount'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
