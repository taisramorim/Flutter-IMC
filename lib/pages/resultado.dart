
import 'package:imc_flutter/classes/registro.dart';
import 'package:imc_flutter/classes/classificacao.dart';

import 'package:flutter/material.dart';

class ResultadoScreen extends StatelessWidget {
  final List<Registro> registros;

  ResultadoScreen(this.registros);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados'),
      ),
      body: ListView.builder(
        itemCount: registros.length,
        itemBuilder: (ctx, index) {
          final registro = registros[index];
          final imc = (registro.peso / (registro.altura * registro.altura)).toStringAsFixed(2);
          final classificacao = classificarPeso(double.parse(imc));

          return ListTile(
            title: Text('Data: ${registro.data.toString()}'),
            subtitle: Text('Peso: ${registro.peso} kg, Altura: ${registro.altura} m, IMC: $imc (${classificacao.toUpperCase()})'),
          );
        },
      ),
    );
  }
}
