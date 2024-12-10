import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: Mainwidget(),
    routes: {
      '/outdoorTraining': (context) => OutdoorTrainingScreen(),
      '/gymTraining': (context) => GymTrainingScreen(),
      '/PreMadeOutdoorTraining': (context) => PreMadeOutdoorTraining(),
      '/PreMadeGymTraining': (context) => PreMadeGymTraining(),
      '/FullListOutdoorTraining': (context) => FullListOutdoorTraining(),
      '/FullListGymTraining': (context) => FullListGymTraining(),
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
          child: Column( // Stacks the text and buttons vertically
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add text on top
              Text(
                "Kde budeš trénovat:",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0), // Adds space between text and buttons
              Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centers buttons horizontally
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/outdoorTraining');
                          },
                          child: Text("Venku, doma bez přístupu k posilovacím strojům"),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0), // Adds space between buttons
                    Expanded(
                      child: Container(
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
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
      appBar: AppBar(title: Text("Trénink venku nebo doma")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Trénink venku, doma bez přístupu k posilovacím strojům",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/PreMadeOutdoorTraining');
                        },
                        child: Text("Předpřipravené tréninky"),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/FullListOutdoorTraining');
                        },
                        child: Text("Seznam cviků"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
      appBar: AppBar(title: Text("Trénink v posilovně")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Trénink v posilovně, doma s přístupem k posilovacím strojům",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/PreMadeGymTraining');
                        },
                        child: Text("Předpřipravené tréninky"),
                      ),
                    ),
                  ),
                   SizedBox(width: 8.0),
                  Expanded(
                    child: Container(
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/FullListGymTraining');
                        },
                        child: Text("Seznam cviků"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Advanced Outdoor Training Screen
class PreMadeOutdoorTraining extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Předpřipravené tréninky")),
      body: Stack(
        children: [
          // Back to home button
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                textStyle: TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text("Domů"),
            ),
          ),
        ],
      ),
    );
  }
}


// Advanced Gym Training Screen
class PreMadeGymTraining extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Předpřipravené tréninky")),
      body: Stack(
        children: [
          // Back to home button
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                textStyle: TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text("Domů"),
            ),
          ),
        ],
      ),
    );
  }
}

// Intermediate Outdoor Training Screen
class FullListOutdoorTraining extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seznam cviků")),
      body: Stack(
        children: [
          // Back to home button
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                textStyle: TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text("Domů"),
            ),
          ),
        ],
      ),
    );
  }
}

// Intermediate Gym Training Screen
class FullListGymTraining extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Seznam cviků")),
      body: Stack(
        children: [
          // Back to home button
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                textStyle: TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text("Domů"),
            ),
          ),
        ],
      ),
    );
  }
}