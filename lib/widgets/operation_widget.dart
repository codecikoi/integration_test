import 'package:flutter/material.dart';
import 'package:integration_test/service/number_api_service.dart';
import '../utilities/calculator.dart';
import '../utilities/operation.dart';
import 'package:http/http.dart' as http;

class OperationWidget extends StatefulWidget {
  final Operation operation;
  final Calculator calculator;
  const OperationWidget({
    Key? key,
    required this.operation,
    required this.calculator,
  }) : super(key: key);

  @override
  State<OperationWidget> createState() => _OperationWidgetState();
}

class _OperationWidgetState extends State<OperationWidget> {
  late NumberApiService _numberApiService;

  final _topTextController = TextEditingController();
  final _bottomTextController = TextEditingController();

  String _operationResult = '';
  String numberInfo = '';

  @override
  void initState() {
    _numberApiService = NumberApiService(client: http.Client());
    _topTextController.addListener(_getResult);
    _bottomTextController.addListener(_getResult);
    super.initState();
  }

  @override
  void dispose() {
    _topTextController.dispose();
    _bottomTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.operation.descriptionOperation,
        style: TextStyle(fontSize: 20.0),
      ),
      leading: widget.operation.iconOperation,
      subtitle: Column(
        children: [
          TextField(
            key: Key('textField_top_${widget.operation.descriptionOperation}'),
            controller: _topTextController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'enter number'),
          ),
          TextField(
            key: Key(
                'textField_bottom_${widget.operation.descriptionOperation}'),
            controller: _bottomTextController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'enter number'),
          ),
          SizedBox(height: 20.0),
          Text(
            'result: $_operationResult',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Divider(),
          Text(
            numberInfo,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          ElevatedButton(
            key:
                Key('elevated_button_${widget.operation.descriptionOperation}'),
            onPressed: () async {
              if (_operationResult.isNotEmpty) {
                var value = await _numberApiService.getNumberFact(
                  (double.parse(_operationResult)).round(),
                );
                setState(() {
                  numberInfo = value.text;
                });
              }
            },
            child: Text('number info'),
          ),
        ],
      ),
    );
  }

  void _getResult() {
    try {
      final result = _calculate(
        double.tryParse(_topTextController.text)!,
        double.tryParse(_bottomTextController.text)!,
      );
      setState(() {
        _operationResult = result.toString();
      });
    } catch (_) {
      setState(() {
        _operationResult = '';
      });
    }
  }

  double _calculate(double top, double bottom) {
    double result;
    switch (widget.operation) {
      case Operation.add:
        result = widget.calculator.add(top, bottom);
        break;
      case Operation.subtract:
        result = widget.calculator.subtract(top, bottom);

        break;
      case Operation.multiply:
        result = widget.calculator.multiply(top, bottom);

        break;
      case Operation.divide:
        result = widget.calculator.divide(top, bottom);

        break;
    }
    return result;
  }
}
