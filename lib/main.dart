import 'package:flutter/material.dart';
import 'dart:math';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(RandomQuoteApp());
}

class RandomQuoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Quote Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuotePage(),
    );
  }
}

class QuotePage extends StatefulWidget {
  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> with SingleTickerProviderStateMixin {
  final List<String> _quotes = [
    'Do not watch the clock. Do what it does. Keep going. - Sam Levenson',
    'Keep your face always toward the sunshine—and shadows will fall behind you. - Walt Whitman',
    'The best way to predict the future is to create it. - Peter Drucker',
    'You are never too old to set another goal or to dream a new dream. - C.S. Lewis',
    'Success is not the key to happiness. Happiness is the key to success. - Albert Schweitzer',
  ];

  String _currentQuote = 'Click the button to get a random quote!';
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  void _generateRandomQuote() {
    final random = Random();
    setState(() {
      _currentQuote = _quotes[random.nextInt(_quotes.length)];
      _controller.reset();
      _controller.forward();
    });
  }

  void _shareQuote() {
    Share.share(_currentQuote);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Random Quote Generator'),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        color: Colors.lightBlue.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20), // Adds space between app bar and quotes
            FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _currentQuote,
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateRandomQuote,
              child: Text('Generate Quote'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _shareQuote,
              child: Text('Share Quote'),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'This app is developed by Durriya Roha',
                style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
