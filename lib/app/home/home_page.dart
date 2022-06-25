import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  var isLoading = false;
  String? error;

  var cepResult = {};

  Future<void> searchCep(String cep) async {
    try {
      cepResult = {};
      error = null;
      setState(() {
        isLoading = true;
      });

      final response = await Dio().get('https://viacep.com.br/ws/$cep/json/');

      setState(() {
        cepResult = response.data;
      });

    } catch(e) {
      error = 'Erro ao buscar CEP :|';
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'),),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CEP'
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () => searchCep(textController.text), 
              child: Text('Obter CEP')  
            ),
            if (isLoading) Expanded(child: Center(child: CircularProgressIndicator(),),),
            if (error != null) Text(error!, style: TextStyle(color: Colors.red),),
            if (!isLoading && cepResult.isNotEmpty) Text('Cidade: ${cepResult['localidade']}')
          ],
        ),
      ),
    );
  }
}