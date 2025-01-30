import 'package:flappy_bird_flutter/game_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

final log = Logger('main.dart');

void main() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      if (kDebugMode) {
        print('${record.level.name}: ${record.time}: ${record.message}');
      }
    });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    log.info('test');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flappy Bird"),),
      body: Center(child: ElevatedButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const GameScreen()));
      }, child: Text("Start Game")),),
     floatingActionButton: FloatingActionButton(onPressed: (){},),
    );
  }
}
