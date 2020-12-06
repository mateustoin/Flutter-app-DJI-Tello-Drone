import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tello/tello.dart';
import 'package:control_pad/control_pad.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Obriga o app a rodar no celular em modo landscape (horizontal)
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello World Demo Application',
      theme: ThemeData(
        //primarySwatch: Colors.red,
        brightness: Brightness.dark,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key}) : super(key: key);

  // Cria objeto de tello para conectar com o Drone
  final tello = new ConnectTello();
  final List rc_control = [0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          JoystickLeft(rc_control, tello),
          const SizedBox(height: 100, width: 100),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ButtonNormal('takeoff', '       TakeOff      ', tello),
              const SizedBox(height: 30),
              //ButtonPressed(),
              ButtonNormal('land', '         Land         ', tello),
              const SizedBox(height: 30),
              ButtonNormal('command', '     KeepAlive    ', tello),
              const SizedBox(height: 30),
              ButtonNormal('speed 10', 'Increase Speed', tello),
              const SizedBox(height: 30),
              ButtonNormal('speed 50', 'Decrease Speed', tello),
            ],
          ),
          const SizedBox(height: 100, width: 100),
          JoystickRight(rc_control, tello)
        ],
      ),
    );
  }
}

class ButtonNormal extends StatelessWidget {
  final String texto;
  final String buttonName;
  final ConnectTello droneConnection;

  ButtonNormal(this.texto, this.buttonName, this.droneConnection);

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      textColor: Color(0xFFFFFFFF),
      color: Color(0xFF6200EE),
      onPressed: () {
        // Respond to button press
        print('Texto: $texto');
        droneConnection.sendCommand(texto);
      },
      icon: Icon(Icons.add, size: 18),
      label: Text(buttonName),
    );
  }
}

class ButtonPressed extends StatefulWidget {
  @override
  _ButtonPressedState createState() => _ButtonPressedState();
}

class _ButtonPressedState extends State<ButtonPressed> {
  int _counter = 0;

  bool _buttonPressed = false;
  bool _loopActive = false;

  void _increaseCounterWhilePressed() async {
    // make sure that only one loop is active
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      // do your thing
      setState(() {
        _counter++;
      });

      print('Contador já vai em: $_counter');

      // wait a bit
      await Future.delayed(Duration(milliseconds: 200));
    }

    _loopActive = false;
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (details) {
        _buttonPressed = true;
        _increaseCounterWhilePressed();
      },
      onPointerUp: (details) {
        _buttonPressed = false;
      },
      child: RaisedButton.icon(
        textColor: Color(0xFFFFFFFF),
        color: Color(0xFF6200EE),
        onPressed: () {
          // Respond to button press
          print('On pressed tio');
        },
        icon: Icon(Icons.add, size: 20),
        label: Text("Button Pressed"),
      ),
    );
  }
}

class JoystickLeft extends StatelessWidget {
  final List rc_control;
  final ConnectTello droneConnection;

  JoystickLeft(this.rc_control, this.droneConnection);

  static const double pi = 3.1415926535897932;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: JoystickView(
        onDirectionChanged: (degrees, distance) {
          //print('Grau JoystickLeft: $degrees');
          //print('Distancia JoystickLeft: $distance');
          double radian = degrees*(pi/180);
          //print('Radianos: $radian');
          var x_left_right = ((sin(radian)*distance)*100).toInt();
          var y_forward_backward = ((cos(radian)*distance)*100).toInt();
          rc_control[0] = x_left_right;
          rc_control[1] = y_forward_backward;
          
          droneConnection.sendCommand('rc ' 
                                     + rc_control[0].toString() + ' ' 
                                     + rc_control[1].toString() + ' ' 
                                     + rc_control[2].toString() + ' ' 
                                     + rc_control[3].toString());
        },
      ),
    );
  }
}

class JoystickRight extends StatelessWidget {
  final List rc_control;
  final ConnectTello droneConnection;

  JoystickRight(this.rc_control, this.droneConnection);

  static const double pi = 3.1415926535897932;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: JoystickView(
        onDirectionChanged: (degrees, distance) {
          //print('Grau JoystickRight: $degrees');
          //print('Distancia JoystickRight: $distance');
          double radian = degrees*(pi/180);
          //print('Radianos: $radian');
          var x_yaw = ((sin(radian)*distance)*100).toInt();
          var y_up_down = ((cos(radian)*distance)*100).toInt();
          rc_control[2] = y_up_down;
          rc_control[3] = x_yaw;
          
          droneConnection.sendCommand('rc ' 
                                     + rc_control[0].toString() + ' ' 
                                     + rc_control[1].toString() + ' ' 
                                     + rc_control[2].toString() + ' ' 
                                     + rc_control[3].toString());
        },
      ),
    );
  }
}

/*
Container(
        child: JoystickView(
          onDirectionChanged: (degrees, distance) {
            print('Grau: $degrees');
            print('Distancia: $distance');
          },
        ),
      ),
*/

/*
class ProductBox extends StatelessWidget {
  ProductBox({Key key, this.name, this.description, this.price, this.image})
      : super(key: key);

  final String name;
  final String description;
  final double price;
  final String image;

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 120,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.network(this.image),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(this.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(this.description),
                  Text("Price: " + this.price.toString()),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de produtos"),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
        children: <Widget>[
          ProductBox(
            name: "iPhone",
            description: "iPhone is the most expensive phone ever",
            price: 8000.01,
            image: "https://cdn.pixabay.com/photo/2014/08/05/10/30/iphone-410324_960_720.jpg",
          ),
          ProductBox(
            name: "Notebook",
            description: "A good notebook",
            price: 4679.99,
            image: "https://cdn.pixabay.com/photo/2016/03/27/07/12/apple-1282241_960_720.jpg",
          ),
          ProductBox(
            name: "iPhone",
            description: "iPhone is the most expensive phone ever",
            price: 8000.01,
            image: "https://cdn.pixabay.com/photo/2014/08/05/10/30/iphone-410324_960_720.jpg",
          ),
          ProductBox(
            name: "Notebook",
            description: "A good notebook",
            price: 4679.99,
            image: "https://cdn.pixabay.com/photo/2016/03/27/07/12/apple-1282241_960_720.jpg",
          ),
          ProductBox(
            name: "iPhone",
            description: "iPhone is the most expensive phone ever",
            price: 8000.01,
            image: "https://cdn.pixabay.com/photo/2014/08/05/10/30/iphone-410324_960_720.jpg",
          ),
          ProductBox(
            name: "Notebook",
            description: "A good notebook",
            price: 4679.99,
            image: "https://cdn.pixabay.com/photo/2016/03/27/07/12/apple-1282241_960_720.jpg",
          ),
        ],
      ),
    );
  }
}
*/
