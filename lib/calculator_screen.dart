import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = '0';
  String _input = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _displayText = '0';
        _input = '';
      } else if (buttonText == '=') {
        // Perform calculation
        try {
          final result = _calculate(_input);
          _displayText = result.toString();
          _input = result.toString();
        } catch (e) {
          _displayText = 'Error';
        }
      } else {
        // Append the pressed button value to the input string
        _input += buttonText;
        _displayText = _input;
      }
    });
  }

  dynamic _calculate(String input) {
    // Simple calculation implementation
    // Split the input string by operators (+, -, *, /)
    List<String> parts = input.split(RegExp(r'([\+\-\*\/])'));
    List<String> operators = input.split(RegExp(r'[\d\.]+')).where((e) => e.isNotEmpty).toList();
    double result = double.parse(parts[0]);

    for (int i = 0; i < operators.length; i++) {
      double value = double.parse(parts[i + 1]);

      // Perform the operation based on the operator
      if (operators[i] == '+') {
        result += value;
      } else if (operators[i] == '-') {
        result -= value;
      } else if (operators[i] == '*') {
        result *= value;
      } else if (operators[i] == '/') {
        result /= value;
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16),
                child: Text(
                  _displayText,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ),
              Wrap(
                children: [
                  ..._buildButtonRows([
                    '7', '8', '9', '/',
                  ]),
                  ..._buildButtonRows([
                    '4', '5', '6', '*',
                  ]),
                  ..._buildButtonRows([
                    '1', '2', '3', '-',
                  ]),
                  ..._buildButtonRows([
                    '0', '.', '=', '+',
                  ]),
                  ..._buildButtonRows([
                    'C', '%',
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildButtonRows(List<String> rowValues) {
    return rowValues
        .map(
          (value) => SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.width / 5,
            child: TextButton(
              onPressed: () => _onButtonPressed(value),
              child: Text(
                value,
                style: const TextStyle(fontSize: 24),
              ),
            ),
          ),
        )
        .toList();
  }
}

void main() {
  runApp(MaterialApp(
    home: CalculatorScreen(),
  ));
}