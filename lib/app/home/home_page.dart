
import 'package:bloc_application/app/home/search_cep_bloc.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

  final searchCepBloc = SearchCepBloc();

  @override
  void dispose() {
    super.dispose();
    searchCepBloc.dispose();
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
              onPressed: () => searchCepBloc.searchCep.add(textController.text), 
              child: Text('Obter CEP')  
            ),
            StreamBuilder<SearchCepState>(
              stream: searchCepBloc.cepResult,
              builder: (context, snapshot) {

                if(!snapshot.hasData) {
                  return Container();
                }

                var state = snapshot.data!;

                if(state is SearchCepError) {
                  return Text('${snapshot.error}', style: TextStyle(color: Colors.red),);
                }
              
                if(state is SearchCepLoading) {
                  return Expanded(child: Center(child: CircularProgressIndicator()),);
                }

                state = state as SearchCepSuccess;
                return Text('Cidade: ${state.data['localidade']}');
              },
            )
          ],
        ),
      ),
    );
  }
}