import 'package:flutter/material.dart';
import 'package:formulario2/src/mascara.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              // interação do usuario no textField validaçao
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text) {
                if (!RegExp(r'^\d{3}\.\d{3}\.\d{3}-\d{2}$')
                    .hasMatch(text ?? '')) {
                  return 'Digite um CPF valido!';
                }
              },
              inputFormatters: [
                //InputMask('###.###.###-##'),cpf
                //InputMask('###.###.###/####-##) cnpj
                CurrencyMask(symbol: r'R$ ', decimal: '.', cents: '.')
              ],
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
                labelText: 'REAL',
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              // quando tiver interação do usuario com a tela
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text) {
                if (!RegExp(r'^[a-z0-9.]+@[a-z0-9]+\.[a-z]+(\.[a-z]+)?$')
                    .hasMatch(text ?? '')) {
                  return 'Digite um Email valido!';
                }
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                  ),
                  labelText: 'Email'),
            ),
          ],
        ),
      ),
    );
  }
}
