
import 'package:bloc_application/app/home/search_cep_bloc.dart';
import 'package:bloc_application/app/home/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController textController = TextEditingController();

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
              onPressed: () =>  GetIt.instance<SearchCepBloc>().searchCep(textController.text), 
              child: Text('Obter CEP')  
            ),
            BlocBuilder<SearchCepBloc, SearchCepState>(
              bloc: GetIt.instance<SearchCepBloc>(),
              builder: (context, state) {
                if(state is SearchCepError) {
                  return Text(state.message, style: TextStyle(color: Colors.red),);
                }
              
                if(state is SearchCepLoading) {
                  return Expanded(child: Center(child: CircularProgressIndicator()),);
                }

                state = state as SearchCepSuccess;

                if(state.data.isEmpty) {
                  return Container();
                }

                return Text('Cidade: ${state.data['localidade']}');
              }
            )
          ],
        ),
      ),
    );
  }
}