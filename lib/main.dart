import 'package:flutter/material.dart';
import 'package:integration_test/utilities/operation.dart';
import 'package:integration_test/widgets/operation_widget.dart';
import 'utilities/calculator.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    final calculator = Calculator();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.indigo[300],
          title: Text('Calculator'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                OperationWidget(
                  operation: Operation.add,
                  calculator: calculator,
                ),
                Divider(),
                OperationWidget(
                  operation: Operation.subtract,
                  calculator: calculator,
                ),
                Divider(),
                OperationWidget(
                  operation: Operation.multiply,
                  calculator: calculator,
                ),
                Divider(),
                OperationWidget(
                  operation: Operation.divide,
                  calculator: calculator,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
