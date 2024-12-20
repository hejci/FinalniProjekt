import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

var parser = EmojiParser();
var home = Emoji('home', '🏠︎');

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    home: const Mainwidget(),
    routes: {
      '/outdoorTraining': (context) => const OutdoorTrainingScreen(),
      '/gymTraining': (context) => const GymTrainingScreen(),
      '/PreMadeOutdoorTraining': (context) => const PreMadeOutdoorTraining(),
      '/PreMadeGymTraining': (context) => const PreMadeGymTraining(),
      '/FullListOutdoorTraining': (context) => const FullListOutdoorTraining(),
      '/FullListGymTraining': (context) => const FullListGymTraining(),
    },
  ));
}

class Mainwidget extends StatefulWidget {
  const Mainwidget({super.key});

  @override
  MainPage createState() => MainPage();
}

class MainPage extends State<Mainwidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column( // Stacks the text and buttons vertically
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Add text on top
              const Text(
                "Kde budeš trénovat:",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0), // Adds space between text and buttons
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centers buttons horizontally
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/outdoorTraining');
                          },
                          child: const Text("Venku, doma bez přístupu k posilovacím strojům"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0), // Adds space between buttons
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/gymTraining');
                          },
                          child: const Text("V posilovně, doma s přístupem k posilovacím strojům"),
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
  const OutdoorTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trénink venku nebo doma")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Trénink venku, doma bez přístupu k posilovacím strojům",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/PreMadeOutdoorTraining');
                        },
                        child: const Text("Předpřipravené tréninky"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/FullListOutdoorTraining');
                        },
                        child: const Text("Seznam cviků"),
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
  const GymTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Trénink v posilovně")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Trénink v posilovně, doma s přístupem k posilovacím strojům",
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/PreMadeGymTraining');
                        },
                        child: const Text("Předpřipravené tréninky"),
                      ),
                    ),
                  ),
                   const SizedBox(width: 8.0),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/FullListGymTraining');
                        },
                        child: const Text("Seznam cviků"),
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
  const PreMadeOutdoorTraining({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Předpřipravené tréninky")),
      body: Stack(
        children: [
          // Back to home button
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                textStyle: const TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text("⌂"),
            ),
          ),
        ],
      ),
    );

  }
}


// Advanced Gym Training Screen
class PreMadeGymTraining extends StatelessWidget {
  const PreMadeGymTraining({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Předpřipravené tréninky")),
      body: Stack(
        children: [
          // Back to home button
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                textStyle: const TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text("⌂"),
            ),
          ),
        ],
      ),
    );
  }
}

// Intermediate Outdoor Training Screen
class FullListOutdoorTraining extends StatelessWidget {
  const FullListOutdoorTraining({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seznam cviků - Venku")),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(8.0),
            children: [
              ExerciseTile(
                exercise: "Push-Ups",
                description: "A basic upper-body strength exercise. Targets chest, shoulders, and triceps.",
                tips: "Keep your body straight and don't let your hips sag.",
              ),
              ExerciseTile(
                exercise: "Planks",
                description: "Core strengthening exercise. Engage your abs to hold the position.",
                tips: "Keep your body in a straight line from head to heels.",
              ),
              ExerciseTile(
                exercise: "Bodyweight Squats",
                description: "A lower-body exercise focusing on quads, hamstrings, and glutes.",
                tips: "Keep your knees tracking over your toes and maintain an upright posture.",
              ),
            ],
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                textStyle: const TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text("⌂"),
            ),
          ),
        ],
      ),
    );
  }
}

// Intermediate Gym Training Screen
class FullListGymTraining extends StatelessWidget {
  const FullListGymTraining({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Seznam cviků - Posilovna")),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(8.0),
            children: const [
              ExerciseTile(
                exercise: "Bench Press",
                description: "A compound upper-body exercise for chest, shoulders, and triceps.",
                tips: "Keep your wrists straight and lower the bar to your chest in control.",
              ),
              ExerciseTile(
                exercise: "Deadlifts",
                description: "A full-body exercise that targets the posterior chain.",
                tips: "Maintain a neutral spine and engage your core throughout the lift.",
              ),
              ExerciseTile(
                exercise: "Lat Pulldown",
                description: "An exercise for building back strength and width.",
                tips: "Avoid pulling with your arms; focus on using your back muscles.",
              ),
            ],
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                textStyle: const TextStyle(fontSize: 12.0),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: const Text("⌂"),
            ),
          ),
        ],
      ),
    );
  }
}

class ExerciseTile extends StatelessWidget {
  final String exercise;
  final String description;
  final String tips;

  const ExerciseTile({
    required this.exercise,
    required this.description,
    required this.tips,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          exercise,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: const Icon(Icons.fitness_center),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Description: $description"),
                const SizedBox(height: 4.0),
                Text("Tips: $tips"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}