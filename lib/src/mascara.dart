// ignore: implementation_imports
import 'package:characters/src/extensions.dart';
import 'package:flutter/services.dart';

class InputMask extends TextInputFormatter {
//Criando apropria mascara

  final String mask;

  InputMask(this.mask);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = newValue.text.replaceAll(RegExp(r'\D'), '');

    var formatted = mask;
    for (var i = 0; i < value.length; i++) {
      formatted = formatted.replaceFirst('#', value[i]);
    }

    final lastHash = formatted.indexOf('#');

    if (lastHash == -1) {
      formatted = formatted.characters.getRange(0, lastHash).join();
      if (RegExp(r'\D$').hasMatch(formatted)) {
        formatted =
            formatted.split('').getRange(0, formatted.length - 1).join();
      }
    }

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.fromPosition(
        TextPosition(offset: formatted.length),
      ),
    );
  }
}

class CurrencyMask extends TextInputFormatter {
  final String symbol;
  final String decimal;
  final String cents;

  CurrencyMask({
    this.symbol = r'R$ ',
    this.decimal = '.',
    this.cents = ',',
  });
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var value = newValue.text.replaceAll(RegExp(r'\D'), '');

// tranforma em inteiro e depois transforma para string que vai adicionar
// mais um  zero
    value = (int.tryParse(value) ?? 0).toString();

    if (value.length < 3) {
      value = value.padLeft(3, '0');
    }

// pegando do ultimo ao primeiro'
    value = value.split('').reversed.join();
    final listCharacters = [];
    var decimalCount = 0;
    for (var i = 0; i < value.length; i++) {
      if (i == 2) {
        listCharacters.insert(0, cents);
      }

      if (i > 2) {
        decimalCount++;
      }
      if (decimalCount == 3) {
        listCharacters.insert(0, decimal);
        decimalCount = 0;
      }
      listCharacters.insert(0, value[i]);
    }
    listCharacters.insert(0, symbol);

    var formatted = listCharacters.join();

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.fromPosition(
        TextPosition(offset: formatted.length),
      ),
    );
  }
}





//       TextEditingValue oldValue, TextEditingValue newValue) {
//     // esse if nao vou precisar mais pois eu ja verifico tudo que nao for numero vai virar vazio \D
//     // para ficar mais legivel crio uma variavel cpf e substituo o newValue.text []
//     var cpf = newValue.text;
//     if (cpf.length > 14) {
//       return oldValue;
//     }
//     // if (cpf.length > 14 || !RegExp(r'^([\d-.]+)?$').hasMatch(cpf)) {
//     //   return oldValue;
//     // }

//     // pegar  o text digitado(newValue.text)

//     // na hora de colocar o cpf o ponto é contado, temos que zerar usando regex
//     // com o replaceAll (substituir)
//     // tudo que nao for numero que seria o \D (maiusculo)
//     cpf = cpf.replaceAll(RegExp(r'\D'), '');
//     // primeira forma de fazzer com split vai ser colocado na lista tudo que é digitado e sera quebrado com um [], entao cada nuemro digitado vai para 1 array
//     //final characters = cpf.split('');

//     final characteres = cpf.characters.toList();
//     var formatted = '';
//     for (var i = 0; i < characteres.length; i++) {
//       if ([3, 6, 9].contains(i)) {
//         // validação com ternario
//         // se meu ir for igual a 9 ele coloca o traco senao ele coloca o ponto
//         formatted += i == 9 ? '-' : '.';
//       }
//       formatted += characteres[i];

//       /// adicionar(+=)
//       // uma forma de fazer a sequencia do cpf
//       // if (i == 3) {
//       //   formatted +='.';
//       //   formatted += characteres[i];
//       // } else if (i == 6) {
//       //   formatted += '.';
//       //   formatted += characteres[i];
//       // } else if (i == 9) {
//       //   formatted += '-';
//       //   formatted += characteres[i];

//     }

// // copyWith = Cria uma cópia desse valor, mas com os campos fornecidos substituídos pelos novos valores.
//     return newValue.copyWith(
//       // para que o focus do curso fica atras do numero eça pega pela position
//       text: formatted,
//       selection: TextSelection.fromPosition(
//         TextPosition(
//           offset: formatted.length,
//         ),
//       ),
//     );
 