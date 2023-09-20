import 'package:flutter/material.dart';
import 'package:imc_flutter/classes/registro.dart';
import 'package:imc_flutter/classes/classificacao.dart';
import 'package:imc_flutter/pages/resultado.dart';

class Calculadora extends StatelessWidget {
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController alturaController = TextEditingController();
  final List<Registro> diario = [];

  Calculadora({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Meu IMC'),
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: pesoController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Peso (kg)'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: alturaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Altura (m)'),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                adicionarRegistro();
              },
              child: const Text('Adicionar ao Diário'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: diario.length,
                itemBuilder: (ctx, index) {
                  final registro = diario[index];
                  final imc =
                      (registro.peso / (registro.altura * registro.altura))
                          .toStringAsFixed(2);
                  final classificacao = classificarPeso(double.parse(imc));

                  return ListTile(
                    title: Text('Data: ${registro.data.toString()}'),
                    subtitle: Text(
                        'Peso: ${registro.peso} kg, Altura: ${registro.altura} m, IMC: $imc (${classificacao.toUpperCase()})'),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ResultadoScreen(diario)),
                );
              },
              child: const Text('Ver Resultados'),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  void adicionarRegistro() {
    final peso = double.tryParse(pesoController.text);
    final altura = double.tryParse(alturaController.text);

    if (peso == null || altura == null) {
      return;
    }

    final registro = Registro(DateTime.now(), peso, altura);
    diario.add(registro);

    pesoController.clear();
    alturaController.clear();
  }
}
