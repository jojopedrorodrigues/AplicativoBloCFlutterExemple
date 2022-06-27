import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contador usando BloC',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Contador usando BloC'),
    );
  }
}

class ContadorBloc {
  StreamController<int> valor = StreamController();
  Stream<int> get streamer => valor.stream;
  ContadorBloc() {
    valor.add(0);
  }
  fechar() {
    valor.close();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  ContadorBloc bloc = ContadorBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: bloc.streamer,
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Bloc exemplo Flutter - Dart !',
                  ),
                  Text(
                    snapshot.data.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
               if(snapshot.data! % 2 == 0){
                bloc.valor.add(snapshot.data! + 1);
               }
               else{
                bloc.valor.add(snapshot.data! + 3);
               }
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ), // This trailing comma makes auto-formatting nicer for build methods.
          );
        });
  }
}
