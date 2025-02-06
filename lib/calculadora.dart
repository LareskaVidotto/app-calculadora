import 'dart:math';
import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String expressao = '';
  String resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == 'Limpar') {
        expressao = '';
        resultado = '';
      } else if (valor == '=') {
        calcularResultado();
      } else {
        expressao += valor;
      }
    });
  }

  void calcularResultado() {
    try {
      resultado = avaliarExpressao(expressao).toString();
    } catch (e) {
      resultado = 'Erro';
    }
  }

  double avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*').replaceAll('÷', '/');
    
    Expression exp = Expression.parse(expressao);
    final evaluator = const ExpressionEvaluator();

    return evaluator.eval(exp, {
      'sin': (num x) => sin(x),
      'cos': (num x) => cos(x),
      'tan': (num x) => tan(x),
      'log': (num x) => log(x) / log(10),
      'ln': (num x) => log(x),
      'fact': (num x) => factorial(x.toInt()),
      'pow': (num x, num y) => pow(x, y),
    }) as double;
  }

  int factorial(int n) {
    if (n < 0) return 0;
    return n == 0 ? 1 : n * factorial(n - 1);
  }

  Widget botao(String valor, {Color? cor}) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: cor ?? Colors.blueGrey,
        padding: const EdgeInsets.all(16),
      ),
      child: Text(
        valor,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _pressionarBotao(valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                expressao,
                style: const TextStyle(fontSize: 32, color: Colors.white),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Text(
                resultado,
                style: const TextStyle(fontSize: 40, color: Colors.green),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 1.5,
              padding: const EdgeInsets.all(8),
              children: [
                botao('7'), botao('8'), botao('9'), botao('÷', cor: Colors.orange),
                botao('4'), botao('5'), botao('6'), botao('x', cor: Colors.orange),
                botao('1'), botao('2'), botao('3'), botao('-', cor: Colors.orange),
                botao('0'), botao('.'), botao('=', cor: Colors.green), botao('+', cor: Colors.orange),
                botao('sin('), botao('cos('), botao('tan('), botao('log(', cor: Colors.purple),
                botao('ln('), botao('fact('), botao('^'), botao('(', cor: Colors.blueGrey),
                botao(')'), botao('Limpar', cor: Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
