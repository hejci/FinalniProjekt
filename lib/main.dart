import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: Mainwidget(),
    routes: {
      '/outdoorTraining': (context) => OutdoorTrainingScreen(),
      '/gymTraining': (context) => GymTrainingScreen(),
    },
  ));
}

class Mainwidget extends StatefulWidget {
  const Mainwidget({Key? key}) : super(key: key);

  @override
  _MainwidgetState createState() => _MainwidgetState();
}

class _MainwidgetState extends State<Mainwidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(  // Stacks the text and buttons vertically
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add text on top
              Text(
                "Kde budeš trénovat:",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),  // Adds space between text and buttons
              Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,  // Centers buttons horizontally
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the outdoor training screen
                            Navigator.pushNamed(context, '/outdoorTraining');
                          },
                          child: Text("Venku, doma bez přístupu k posilovacím strojům"),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),  // Adds space between buttons
                    Expanded(
                      child: Container(
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigate to the gym training screen
                            Navigator.pushNamed(context, '/gymTraining');
                          },
                          child: Text("V posilovně, doma s přístupem k posilovacím strojům"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Screen for outdoor/home training without machines
class OutdoorTrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trénink - vlastní tělo")),
      body: Center(
        child: Text(
          "Trénink venku, doma bez přístupu k posilovacím strojům",
          style: TextStyle(fontSize: 24.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

// Screen for gym/home training with machines
class GymTrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Trénink - váhy")),
      body: Center(
        child: Text(
          "Trénink v posilovně, doma s přístupem k posilovacím strojům",
          style: TextStyle(fontSize: 24.0),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
