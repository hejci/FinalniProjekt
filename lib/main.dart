import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

var parser = EmojiParser();
var home = Emoji('home', '🏠︎');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    ChangeNotifierProvider(
      create: (_) => themeProvider,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      home: const Mainwidget(),
      routes: {
        '/outdoorTraining': (context) => const OutdoorTrainingScreen(),
        '/gymTraining': (context) => const GymTrainingScreen(),
        '/PreMadeOutdoorTraining': (context) => const PreMadeOutdoorTraining(),
        '/PreMadeGymTraining': (context) => const PreMadeGymTraining(),
        '/FullListOutdoorTraining': (context) => const FullListOutdoorTraining(),
        '/FullListGymTraining': (context) => const FullListGymTraining(),
      },
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<void> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class Mainwidget extends StatefulWidget {
  const Mainwidget({super.key});

  @override
  MainPage createState() => MainPage();
}

class MainPage extends State<Mainwidget> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Training Mode"),
        actions: [
          Switch(
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Where will you train:",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
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
                            Navigator.pushNamed(context, '/outdoorTraining');
                          },
                          child: const Text("Without gym equipment"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/gymTraining');
                          },
                          child: const Text("With gym equipment"),
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
      appBar: AppBar(title: const Text("Without equipment")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Training without equipment",
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
                          Navigator.pushNamed(
                              context, '/PreMadeOutdoorTraining');
                        },
                        child: const Text("Premade trainings"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: SizedBox(
                      height: 100,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/FullListOutdoorTraining');
                        },
                        child: const Text("List of excercises"),
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
      appBar: AppBar(title: const Text("With equipment")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Training with gym equipment",
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
                        child: const Text("Premade trainings"),
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
                        child: const Text("List of excercises"),
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

class WorkoutPlan {
  final String name;
  final Map<String, List<String>> sections;

  WorkoutPlan({
    required this.name,
    required this.sections,
  });
}

// Advanced Outdoor Training Screen
class PreMadeOutdoorTraining extends StatefulWidget {
  const PreMadeOutdoorTraining({super.key});

  @override
  _PreMadeOutdoorTrainingState createState() => _PreMadeOutdoorTrainingState();
}

class _PreMadeOutdoorTrainingState extends State<PreMadeOutdoorTraining> {
  final List<WorkoutPlan> workoutPlans = [
    WorkoutPlan(
      name: "Random 1",
      sections: {
        "Workout": [
          "Warm-up - 10 minutes",
          "Push-Ups - 3 sets of 12 reps",
          "Bodyweight Squats - 3 sets of 15 reps",
          "Plank - 3 sets of 30 seconds",
        ],
      },
    ),
    WorkoutPlan(
      name: "Random 2",
      sections: {
        "Workout": [
          "Warm-up - 10 minutes",
          "Mountain Climbers - 4 sets of 30 seconds",
          "Burpees - 3 sets of 10 reps",
          "Jump Squats - 3 sets of 12 reps",
        ],
      },
    ),
  ];

  late Set<String> bookmarkedWorkouts;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bookmarkedWorkouts =
          prefs.getStringList('bookmarkedWorkouts')?.toSet() ?? {};
    });
  }

  Future<void> _toggleBookmark(String workoutName) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (bookmarkedWorkouts.contains(workoutName)) {
        bookmarkedWorkouts.remove(workoutName);
      } else {
        bookmarkedWorkouts.add(workoutName);
      }
      prefs.setStringList('bookmarkedWorkouts', bookmarkedWorkouts.toList());
    });
  }

  void _navigateToFullList(BuildContext context, String exerciseName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullListOutdoorTraining(initialExercise: exerciseName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pre-Made Outdoor Training"),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.pushNamed(context, '/'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: workoutPlans.length,
        itemBuilder: (context, index) {
          final workout = workoutPlans[index];
          return _buildWorkoutCard(context, workout);
        },
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, WorkoutPlan workout) {
    final isBookmarked = bookmarkedWorkouts.contains(workout.name);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ExpansionTile(
        leading: IconButton(
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
            color: isBookmarked ? Colors.blue : null,
          ),
          onPressed: () => _toggleBookmark(workout.name),
        ),
        title: Text(
          workout.name,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        children: [
          Column(
            children: workout.sections.entries.map((entry) {
              return ListTile(
                title: Text(entry.key,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: entry.value
                      .map((exercise) => GestureDetector(
                            onTap: () {
                              _navigateToFullList(context, exercise.split(" - ").first); // Send exercise name
                            },
                            child: Text("- $exercise"),
                          ))
                      .toList(),
                ),
              );
            }).toList(),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Start workout logic
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text("Start Workout"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// Advanced Gym Training Screen
class PreMadeGymTraining extends StatefulWidget {
  const PreMadeGymTraining({super.key});

  @override
  _PreMadeGymTrainingState createState() => _PreMadeGymTrainingState();
}

class _PreMadeGymTrainingState extends State<PreMadeGymTraining> {
  final List<WorkoutPlan> workoutPlans = [
    WorkoutPlan(
      name: "Neco 1",
      sections: {
        "Workout": [
          "Warm-up - 10 minutes",
          "Bench Press - 3 sets of 10 reps",
          "Leg Press - 3 sets of 12 reps",
          "Seated Rows - 3 sets of 15 reps",
        ],
      },
    ),
    WorkoutPlan(
      name: "Neco 2",
      sections: {
        "Workout": [
          "Warm-up - 10 minutes",
          "Deadlifts - 3 sets of 8 reps",
          "Squats - 3 sets of 10 reps",
          "Overhead Press - 3 sets of 12 reps",
        ],
      },
    ),
  ];

  late Set<String> bookmarkedWorkouts;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bookmarkedWorkouts =
          prefs.getStringList('bookmarkedWorkouts')?.toSet() ?? {};
    });
  }

  Future<void> _toggleBookmark(String workoutName) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (bookmarkedWorkouts.contains(workoutName)) {
        bookmarkedWorkouts.remove(workoutName);
      } else {
        bookmarkedWorkouts.add(workoutName);
      }
      prefs.setStringList('bookmarkedWorkouts', bookmarkedWorkouts.toList());
    });
  }

  void _navigateToFullList(BuildContext context, String exerciseName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullListGymTraining(initialExercise: exerciseName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pre-Made Gym Training"),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.pushNamed(context, '/'),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: workoutPlans.length,
        itemBuilder: (context, index) {
          final workout = workoutPlans[index];
          return _buildWorkoutCard(context, workout);
        },
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, WorkoutPlan workout) {
    final isBookmarked = bookmarkedWorkouts.contains(workout.name);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: ExpansionTile(
        leading: IconButton(
          icon: Icon(
            isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
            color: isBookmarked ? Colors.blue : null,
          ),
          onPressed: () => _toggleBookmark(workout.name),
        ),
        title: Text(
          workout.name,
          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        children: [
          Column(
            children: workout.sections.entries.map((entry) {
              return ListTile(
                title: Text(entry.key,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: entry.value
                      .map((exercise) => GestureDetector(
                            onTap: () {
                              _navigateToFullList(context, exercise.split(" - ").first); // Send exercise name
                            },
                            child: Text("- $exercise"),
                          ))
                      .toList(),
                ),
              );
            }).toList(),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Start workout logic
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text("Start Workout"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FullListOutdoorTraining extends StatefulWidget {
  final String? initialExercise;

  const FullListOutdoorTraining({super.key, this.initialExercise});

  @override
  _FullListOutdoorTrainingState createState() => _FullListOutdoorTrainingState();
}

class _FullListOutdoorTrainingState extends State<FullListOutdoorTraining> {
  List<ExerciseTile> exercises = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadExercises();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialExercise != null) {
        _scrollToExercise(widget.initialExercise!);
      }
    });
  }

  Future<void> _loadExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('outdoor_exercises');
    if (savedData != null) {
      final List<dynamic> decodedData = jsonDecode(savedData);
      setState(() {
        exercises =
            decodedData.map((data) => ExerciseTile.fromJson(data)).toList();
      });
    } else {
      _setDefaultExercises();
    }
  }

  void _setDefaultExercises() {
    setState(() {
      exercises = [
        const ExerciseTile(
          exercise: "Push-Ups",
          description: "A bodyweight exercise to strengthen the chest and triceps.",
          form: "",
        ),
        const ExerciseTile(
          exercise: "Mountain Climbers",
          description: "A cardio exercise for overall conditioning.",
          form: "",
        ),
        const ExerciseTile(
          exercise: "Burpees",
          description: "A full-body exercise for explosive power.",
          form: "",
        ),
      ];
    });
    _saveExercises();
  }

  Future<void> _saveExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> data =
        exercises.map((exercise) => exercise.toJson()).toList();
    await prefs.setString('outdoor_exercises', jsonEncode(data));
  }

  void _scrollToExercise(String exerciseName) {
    final index = exercises.indexWhere((exercise) => exercise.exercise == exerciseName);
    if (index != -1) {
      _scrollController.animateTo(
        index * 80.0, // Approximate height of each exercise tile
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Full list")),
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return Card(
                color: widget.initialExercise == exercise.exercise
                    ? Colors.yellow.shade100
                    : null, // Highlight the matched exercise
                child: exercise,
              );
            },
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
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

class FullListGymTraining extends StatefulWidget {
  final String? initialExercise;

  const FullListGymTraining({super.key, this.initialExercise});

  @override
  _FullListGymTrainingState createState() => _FullListGymTrainingState();
}

class _FullListGymTrainingState extends State<FullListGymTraining> {
  List<ExerciseTile> exercises = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadExercises();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialExercise != null) {
        _scrollToExercise(widget.initialExercise!);
      }
    });
  }

  Future<void> _loadExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final savedData = prefs.getString('gym_exercises');
    if (savedData != null) {
      final List<dynamic> decodedData = jsonDecode(savedData);
      setState(() {
        exercises =
            decodedData.map((data) => ExerciseTile.fromJson(data)).toList();
      });
    } else {
      _setDefaultExercises();
    }
  }

  void _setDefaultExercises() {
    setState(() {
      exercises = [
        const ExerciseTile(
          exercise: "Bench Press",
          description:
              "A compound upper-body exercise for chest, shoulders, and triceps.",
          form: "",
        ),
        const ExerciseTile(
          exercise: "Deadlifts",
          description: "A full-body exercise that targets the posterior chain.",
          form: "",
        ),
        const ExerciseTile(
          exercise: "Lat Pulldown",
          description: "An exercise for building back strength and width.",
          form: "",
        ),
      ];
    });
    _saveExercises();
  }

  Future<void> _saveExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> data =
        exercises.map((exercise) => exercise.toJson()).toList();
    await prefs.setString('gym_exercises', jsonEncode(data));
  }

  void _scrollToExercise(String exerciseName) {
    final index = exercises.indexWhere((exercise) => exercise.exercise == exerciseName);
    if (index != -1) {
      _scrollController.animateTo(
        index * 80.0, // Approximate height of each exercise tile
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Full list")),
      body: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemCount: exercises.length,
            itemBuilder: (context, index) {
              final exercise = exercises[index];
              return Card(
                color: widget.initialExercise == exercise.exercise
                    ? Colors.yellow.shade100
                    : null, // Highlight the matched exercise
                child: exercise,
              );
            },
          ),
          Positioned(
            top: 16.0,
            right: 16.0,
            child: ElevatedButton(
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
  final String form;

  const ExerciseTile({
    required this.exercise,
    required this.description,
    required this.form,
    super.key,
  });

  factory ExerciseTile.fromJson(Map<String, dynamic> json) {
    return ExerciseTile(
      exercise: json['exercise'],
      description: json['description'],
      form: json['form'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise': exercise,
      'description': description,
      'form': form,
    };
  }

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
                Text("Form: $form"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AddExerciseDialog extends StatefulWidget {
  final Function(String, String, String) onAdd;

  const AddExerciseDialog({required this.onAdd, super.key});

  @override
  _AddExerciseDialogState createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _formController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Exercise'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _exerciseController,
            decoration: const InputDecoration(labelText: 'Exercise Name'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: _formController,
            decoration: const InputDecoration(labelText: 'Correct Form'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onAdd(
              _exerciseController.text,
              _descriptionController.text,
              _formController.text,
            );
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
