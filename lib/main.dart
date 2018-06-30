import 'package:flutter/material.dart';
import 'package:flutter_fractal/fractal_painter.dart';

void main() => runApp(new FractalApp());

class FractalApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Fractal',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new FractalHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class FractalHomePage extends StatefulWidget {
  FractalHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _FractalPageState createState() => new _FractalPageState();
}

class _FractalPageState extends State<FractalHomePage> {
  int _counter = 3;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Fractal depth: $_counter'),
      ),
      body: new Center(
          child: new AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                  padding: EdgeInsets.all(32.0),
                  child: new Fractal(_counter.toDouble())
              )
          )
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment Depth',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
