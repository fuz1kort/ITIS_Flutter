import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _firstValue = TextEditingController();
  final TextEditingController _secondValue = TextEditingController();
  double _result = 0;
  String _errorMessage = "";

  void _calculate(Function operation) {
    setState(() {
      try {
        _errorMessage = "";
        _result = operation(
          double.parse(_firstValue.text),
          double.parse(_secondValue.text),
        );
      } catch (e) {
        _result = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          ResultDisplay(result: _result, errorMessage: _errorMessage),
          _numberInput(_firstValue, "Enter first number"),
          _numberInput(_secondValue, "Enter second number"),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOperationButton("+", (a, b) => a + b),
              _buildOperationButton("-", (a, b) => a - b),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildOperationButton("*", (a, b) => a * b),
              _buildOperationButton(
                "/",
                (a, b) =>
                    b == 0 ? _errorMessage = "На 0 делить нельзя" : a / b,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _numberInput(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Enter second number",
        filled: true,
      ),
    );
  }

  Widget _buildOperationButton(String label, Function operation) {
    return ElevatedButton(
      onPressed: () => _calculate(operation),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Colors.deepPurple,
        elevation: 4,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ResultDisplay extends StatelessWidget {
  const ResultDisplay({
    super.key,
    required this.result,
    required this.errorMessage,
  });

  final double result;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      color: Colors.black,
      child: Text(
        errorMessage == "" ? result.toString() : errorMessage,
        style: TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }
}