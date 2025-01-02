import 'package:expressions/expressions.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  final String limpar = 'Limpar';
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
      resultado = avaliarexpressao(expressao).toString();
    } catch (e) {
      resultado = 'Não é possível calcular';
    }
  }

  double avaliarexpressao(String expressao) {
    // Substituir 'x' por '*' para multiplicação
    expressao = expressao.replaceAll('x', '*');
    // Substituir '÷' por '/' para divisão
    expressao = expressao.replaceAll('÷', '/');
    // Avaliar a expressão com a biblioteca expressions
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    double resultado = avaliador.eval(Expression.parse(expressao), {});
    return resultado;
  }

  Widget botao(String valor) {
    return TextButton(
      child: Text(
        valor,
        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      onPressed: () => _pressionarBotao(valor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Text(
            expressao,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        Expanded(
          child: Text(
            resultado,
            style: const TextStyle(fontSize: 24),
          ),
        ),
        Expanded(
          flex: 3,
          child: GridView.count(
            crossAxisCount: 4,
            childAspectRatio: 2,
            children: [
              botao('7'),
              botao('8'),
              botao('9'),
              botao('÷'),
              botao('4'),
              botao('5'),
              botao('6'),
              botao('x'),
              botao('1'),
              botao('2'),
              botao('3'),
              botao('-'),
              botao('0'),
              botao('.'),
              botao('='),
              botao('+'),
              botao('('),
              botao(')'),
            ],
          ),
        ),
        Expanded(child: botao('Limpar')),
      ],
    );
  }
}
