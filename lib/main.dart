import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';


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

// sledovani prepinani motivu
  void toggleTheme(bool isDarkMode) async {
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

// nacteni motivu
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Main UI layer
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24.0),
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
        ],
      ),
    );
  }
}

class OutdoorTrainingScreen extends StatelessWidget {
  const OutdoorTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Without equipment")),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16.0),
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
                            child: const Text("List of exercises"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GymTrainingScreen extends StatelessWidget {
  const GymTrainingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("With equipment")),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16.0),
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
                              Navigator.pushNamed(
                                  context, '/PreMadeGymTraining');
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
                                  context, '/FullListGymTraining');
                            },
                            child: const Text("List of exercises"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
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

class PreMadeOutdoorTraining extends StatefulWidget {
  const PreMadeOutdoorTraining({super.key});

  @override
  _PreMadeOutdoorTrainingState createState() => _PreMadeOutdoorTrainingState();
}

class _PreMadeOutdoorTrainingState extends State<PreMadeOutdoorTraining> {
  Map<String, bool> workoutInProgress = {};
  Map<String, int> workoutElapsedTime = {}; // To track the elapsed time for each workout
  Map<String, Timer?> workoutTimers = {}; // To hold the timers for each workout

  // zapnuti vypnuti treninku
  void _toggleWorkout(WorkoutPlan workout) {
    setState(() {
      if (workoutInProgress[workout.name] == true) {
        // If workout is in progress, stop it
        workoutInProgress[workout.name] = false;
        workoutTimers[workout.name]?.cancel(); // Stop the timer
      } else {
        // If workout is not started, start it
        workoutInProgress[workout.name] = true;
        workoutElapsedTime[workout.name] = 0; // Reset the time
        // Start the timer
        workoutTimers[workout.name] = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            workoutElapsedTime[workout.name] = workoutElapsedTime[workout.name]! + 1; // Increment the time
          });
        });
      }
    });
  }

  String _formatElapsedTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }
  final List<WorkoutPlan> workoutPlans = [
    WorkoutPlan(
      name: "Lower body",
      sections: {
        "Workout": [
          "Warm-up - 10 minutes",
          "Bulgarian squats: 3 sets of 10 reps per leg",
          "Squat jumps: 3 sets of 12 reps (focus on height)",
          "Lunges: 3 sets of 12 reps per leg",
          "Nordic curls: 3 sets of 6 reps",
          "Broad jumps: 3 sets of 8 reps (focus on explosive power)",
          "Plank x 3 sets of 30 seconds",
          "Pigeon pose stretch x 1 minute per side",
          "Seated forward fold x 1 minute",
        ],
      },
    ),
    WorkoutPlan(
      name: "Upper body",
      sections: {
        "Workout": [
          "Push-Ups: 4 sets of 15 reps",
          "Pull-Ups: 3 sets of 8-10 reps",
          "Diamond Push-Ups: 3 sets of 10 reps",
          "Wide Push-Ups: 3 sets of 12 reps",
          "Plank to Push-Up (from forearms to hands): 3 sets of 10 reps",
          "Plank with shoulder taps x 3 sets of 30 seconds",
          "Chest opener stretch x 1 minute per side",
          "Cat-cow stretch x 10 reps",
        ],
      },
    ),
    WorkoutPlan(
      name: "Full-body",
      sections: {
        "Workout": [
          "Push-Ups: 4 sets of 12 reps",
          "Broad jumps: 3 sets of 8 reps (focus on distance)",
          "Bulgarian squats: 3 sets of 10 reps per leg",
          "Squat jumps: 3 sets of 10 reps",
          "Lunges: 3 sets of 12 reps per leg",
          "Plank x 3 sets of 30 seconds",
          "Pigeon pose stretch x 1 minute per side",
          "Forward fold (standing or seated) x 1 minute",
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

// nacteni bookmarku
  Future<void> _loadBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bookmarkedWorkouts = prefs.getStringList('bookmarkedWorkouts')?.toSet() ?? {};
      _sortWorkouts();
    });
  }

// registrace bookmarku
  Future<void> _toggleBookmark(String workoutName) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (bookmarkedWorkouts.contains(workoutName)) {
        bookmarkedWorkouts.remove(workoutName);
      } else {
        bookmarkedWorkouts.add(workoutName);
      }
      prefs.setStringList('bookmarkedWorkouts', bookmarkedWorkouts.toList());
      _sortWorkouts();
    });
  }

// serazeni podle bookmarku
  void _sortWorkouts() {
    workoutPlans.sort((a, b) {
      final aBookmarked = bookmarkedWorkouts.contains(a.name);
      final bBookmarked = bookmarkedWorkouts.contains(b.name);
      if (aBookmarked && !bBookmarked) return -1;
      if (!aBookmarked && bBookmarked) return 1;
      return 0;
    });
  }

// proklik na full list
  void _navigateToFullList(BuildContext context, String exerciseName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullListOutdoorTraining(initialExercise: exerciseName),
      ),
    );
  }

// vzhled aplikace
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pre-Made No Equip"),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.pushNamed(context, '/'),
          ),
        ],
      ),
     body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: workoutPlans.length,
              itemBuilder: (context, index) {
                final workout = workoutPlans[index];
                return _buildWorkoutCard(context, workout);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, WorkoutPlan workout) {
    final isBookmarked = bookmarkedWorkouts.contains(workout.name);
    final isWorkoutInProgress = workoutInProgress[workout.name] ?? false;
    final elapsedTime = workoutElapsedTime[workout.name] ?? 0;
    final formattedTime = _formatElapsedTime(elapsedTime);

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
                title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: entry.value.map((exercise) {
                    return GestureDetector(
                      onTap: () {
                        _navigateToFullList(context, exercise.split(" - ").first);
                      },
                      child: Text("- $exercise"),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ),
          const Divider(),
          // zobrazuje bud start workout nebo stop workout
          if (!isWorkoutInProgress) 
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _toggleWorkout(workout),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Start Workout"),
                ),
              ],
            ),
          if (isWorkoutInProgress) 
            Positioned(
              bottom: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _toggleWorkout(workout),
                    icon: const Icon(Icons.stop),
                    label: const Text("Stop Workout"),
                  ),
                  const SizedBox(width: 16),
                  // zobrazuje cas
                  Text(
                    'Time: $formattedTime',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
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
  Map<String, bool> workoutInProgress = {};
  Map<String, int> workoutElapsedTime = {}; // trackuje na pozdejsi vyuziti
  Map<String, Timer?> workoutTimers = {}; // kazdy trenink ma svuj timer

void _toggleWorkout(WorkoutPlan workout) {
    setState(() {
      if (workoutInProgress[workout.name] == true) {
        // vypnuti treninku
        workoutInProgress[workout.name] = false;
        workoutTimers[workout.name]?.cancel(); // zastaveni casu
      } else {
        // spousteni casu
        workoutInProgress[workout.name] = true;
        workoutElapsedTime[workout.name] = 0; // resetnuti casu
        // Start the timer
        workoutTimers[workout.name] = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            workoutElapsedTime[workout.name] = workoutElapsedTime[workout.name]! + 1; // inkrementace casu
          });
        });
      }
    });
  }

  String _formatElapsedTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  final List<WorkoutPlan> workoutPlans = [
    WorkoutPlan(
      name: "Upper body",
      sections: {
        "Workout": [
          "Warm-up - 10 minutes",
          "Dumbbell Bench Press: 4 sets of 8 reps",
          "Pull-Ups: 3 sets of 8 reps",
          "Medicine ball slams: 3 sets of 12 reps (focus on speed and power)",
          "Single-arm dumbbell rows: 3 sets of 10 reps per side",
          "Cable hip rotations: 3 sets of 12 per side",
          "Plank x 3 sets of 30 seconds",
          "Chest opener stretch against a wall x 1 minute per side",
          "Cat-cow stretch x 10 reps",
        ],
      },
    ),
    WorkoutPlan(
      name: "Lower body",
      sections: {
        "Workout": [
          "Warm-up - 10 minutes",
          "Deadlifts: 4 sets of 5 reps (focus on explosive lift from the ground)",
          "Bulgarian squats: 3 sets of 8 reps per leg",
          "Broad jumps: 3 sets of 6 reps (maximize distance)",
          "Nordic curls: 3 sets of 6 reps",
          "Sled pushes: 3 sets of 20 meters",
          "Plank with shoulder taps x 3 sets of 30 seconds",
          "Pigeon pose stretch x 1 minute per side",
          "Seated forward fold x 1 minute",
        ],
      },
    ),
    WorkoutPlan(
      name: "Full-body",
      sections: {
        "Workout": [
          "Warm-up - 10 minutes",
          "Back squats: 4 sets of 6 reps",
          "Dumbbell box step-ups: 3 sets of 8 per leg",
          "Squat jumps: 3 sets of 10 reps (land softly)",
          "Push-Ups: 3 sets of 12 reps",
          "Calf raises: 3 sets of 15 reps",
          "Plank: 3 sets of 30 seconds",
          "Couch stretch x 1 minute per leg",
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
      bookmarkedWorkouts = prefs.getStringList('bookmarkedWorkouts')?.toSet() ?? {};
      _sortWorkouts();
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
      _sortWorkouts();
    });
  }

  void _sortWorkouts() {
    workoutPlans.sort((a, b) {
      final aBookmarked = bookmarkedWorkouts.contains(a.name);
      final bBookmarked = bookmarkedWorkouts.contains(b.name);
      if (aBookmarked && !bBookmarked) return -1;
      if (!aBookmarked && bBookmarked) return 1;
      return 0;
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
        title: const Text("Pre-Made Gym"),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.pushNamed(context, '/'),
          ),
        ],
      ),
     body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1,
              child: Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: workoutPlans.length,
              itemBuilder: (context, index) {
                final workout = workoutPlans[index];
                return _buildWorkoutCard(context, workout);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutCard(BuildContext context, WorkoutPlan workout) {
    final isBookmarked = bookmarkedWorkouts.contains(workout.name);
    final isWorkoutInProgress = workoutInProgress[workout.name] ?? false;
    final elapsedTime = workoutElapsedTime[workout.name] ?? 0;
    final formattedTime = _formatElapsedTime(elapsedTime);

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
                title: Text(entry.key, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: entry.value.map((exercise) {
                    return GestureDetector(
                      onTap: () {
                        _navigateToFullList(context, exercise.split(" - ").first);
                      },
                      child: Text("- $exercise"),
                    );
                  }).toList(),
                ),
              );
            }).toList(),
          ),
          const Divider(),
          // Display Start Workout or Stop Workout Button
          if (!isWorkoutInProgress) 
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _toggleWorkout(workout),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Start Workout"),
                ),
              ],
            ),
          if (isWorkoutInProgress) 
            Positioned(
              bottom: 16,
              right: 16,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _toggleWorkout(workout),
                    icon: const Icon(Icons.stop),
                    label: const Text("Stop Workout"),
                  ),
                  const SizedBox(width: 16),
                  // Display elapsed time while the workout is in progress
                  Text(
                    'Time: $formattedTime',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
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
  _FullListOutdoorTrainingState createState() =>
      _FullListOutdoorTrainingState();
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

// nacteni cviku
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

// zakladni cviky aplikace
  void _setDefaultExercises() {
    setState(() {
      exercises = [
        const ExerciseTile(
          exercise: "Push-Ups",
          description: "Biceps, triceps, upper back, chest, shoulders, core",
          form: "https://www.youtube.com/watch?v=WDIpL0pjun0",
        ),
        const ExerciseTile(
          exercise: "Lunges",
          description: "Gluteals, quadriceps, and hamstrings (can be done with dumbbells)",
          form: "https://www.youtube.com/watch?v=MxfTNXSFiYI",
        ),
        const ExerciseTile(
          exercise: "Squat jumps",
          description: "Pretty much every lower body muscle and your explosiveness (can be done with a barbell)",
          form: "https://www.youtube.com/watch?v=YGGq0AE5Uyc",
        ),
        const ExerciseTile(
          exercise: "Nordic curls",
          description: "Hamstrings, knee flexion, hip extension",
          form: "https://www.youtube.com/watch?v=3-4pKUhkzoQ",
        ),
        const ExerciseTile(
          exercise: "Broad jumps",
          description: "Lower body power, coordination, agility, core",
          form: "https://www.youtube.com/watch?v=96zJo3nlmHI",
        ),
        const ExerciseTile(
          exercise: "Pull-Ups",
          description: "The largest back muscles, biceps, delts",
          form: "https://www.youtube.com/watch?v=eGo4IYlbE5g",
        ),
        const ExerciseTile(
          exercise: "Plank",
          description: "Core muscles, abdominals, lower back",
          form: "https://www.youtube.com/watch?v=B296mZDhrP4",
        ),
      ];
    });
    _saveExercises();
  }

// ukladani vytvoreneho cviku
  Future<void> _saveExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> data =
        exercises.map((exercise) => exercise.toJson()).toList();
    await prefs.setString('outdoor_exercises', jsonEncode(data));
  }

// najeti na cvik po prokliknuti
  void _scrollToExercise(String exerciseName) {
    final index = exercises.indexWhere((exercise) => exercise.exercise == exerciseName);
    if (index != -1) {
      _scrollController.animateTo(
        index * 80.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

// vytvareni noveho cviku
  void _addNewExercise(String exercise, String description, String form) {
    setState(() {
      exercises.add(ExerciseTile(
        exercise: exercise,
        description: description,
        form: form,
      ));
    });
    _saveExercises();
  }

// vzhled stranky
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Full Outdoor Training List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.pushNamed(context, '/'),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1, 
              child: Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  controller: _scrollController,
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return Card(
                      color: widget.initialExercise == exercise.exercise
                          ? Colors.yellow.shade100
                          : null,
                      child: exercise,
                    );
                  },
                ),
                Positioned(
                  bottom: 16.0,
                  right: 16.0,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddExerciseDialog(onAdd: _addNewExercise);
                        },
                      );
                    },
                    child: const Text("+"),
                  ),
                ),
              ],
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

// nacteni cviku
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

// zakladni cviky pouzity v aplikaci
  void _setDefaultExercises() {
    setState(() {
      exercises = [
        const ExerciseTile(
          exercise: "Bench press",
          description:
              "Arms, shoulders, pec majors, anterior deltoid, triceps, core",
          form: "https://www.youtube.com/watch?v=hWbUlkb5Ms4",
        ),
        const ExerciseTile(
          exercise: "Deadlifts",
          description: "Glutes, hamstrings, core, back, and trapezius muscles",
          form: "https://www.youtube.com/watch?v=op9kVnSso6Q",
        ),
        const ExerciseTile(
          exercise: "Back squats",
          description: "Pretty much every lower body muscle",
          form: "https://www.youtube.com/watch?v=QmZAiBqPvZw",
        ),
        const ExerciseTile(
          exercise: "Bulgarian squats",
          description: "Quadriceps and glutes (can be done without any added weights)",
          form: "https://www.youtube.com/watch?v=9p5e2BSvoLs",
        ),
        const ExerciseTile(
          exercise: "Calf raises",
          description: "Calves",
          form: "https://www.youtube.com/watch?v=Zep-wKHWkNM&t=1s",
        ),
        const ExerciseTile(
          exercise: "Medicine ball slams",
          description: "Legs, glutes, abs, shoulders, arms, several back muscles",
          form: "https://www.youtube.com/watch?v=QxYhFwMd1Ks",
        ),
        const ExerciseTile(
          exercise: "Single-arm dumbbell rows",
          description: "Lats, trapezius, rhomboids, delts, core, biceps",
          form: "https://www.youtube.com/watch?v=A5YxsxCuZ7Y",
        ),
        const ExerciseTile(
          exercise: "Dumbbell bench press",
          description: "Arms, shoulders, pec majors, anterior deltoid, triceps, core (same as regular bench)",
          form: "https://www.youtube.com/watch?v=VmB1G1K7v94",
        ),
        const ExerciseTile(
          exercise: "Cable hip rotations",
          description: "Glutes",
          form: "https://www.youtube.com/watch?v=EhXxfGMggB8",
        ),
        const ExerciseTile(
          exercise: "Dumbbell box step-ups",
          description: "Whole legs",
          form: "https://www.youtube.com/watch?v=DxUNi119Qzs",
        ),
        const ExerciseTile(
          exercise: "Sled pushes",
          description: "Whole legs, hip flexors, core, tricep, chest, shoulders ",
          form: "https://www.youtube.com/watch?v=9XRRXaUpnLk",
        ),
      ];
    });
    _saveExercises();
  }

// ukladani cviku
  Future<void> _saveExercises() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> data =
        exercises.map((exercise) => exercise.toJson()).toList();
    await prefs.setString('gym_exercises', jsonEncode(data));
  }

// hledani cviku po prokliku
  void _scrollToExercise(String exerciseName) {
    final index = exercises.indexWhere((exercise) => exercise.exercise == exerciseName);
    if (index != -1) {
      _scrollController.animateTo(
        index * 80.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

// pridani cviku
  void _addNewExercise(String exercise, String description, String form) {
    setState(() {
      exercises.add(ExerciseTile(
        exercise: exercise,
        description: description,
        form: form,
      ));
    });
    _saveExercises();
  }

// vzhled stranky
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Full Gym Training List"),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => Navigator.pushNamed(context, '/'),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1, 
              child: Image.asset(
                'assets/images/logo.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                ListView.builder(
                  controller: _scrollController,
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return Card(
                      color: widget.initialExercise == exercise.exercise
                          ? Colors.yellow.shade100
                          : null,
                      child: exercise,
                    );
                  },
                ),
                Positioned(
                  bottom: 16.0,
                  right: 16.0,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddExerciseDialog(onAdd: _addNewExercise);
                        },
                      );
                    },
                    child: const Text("+"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// kontrola zadanych udaju pri vytvoreni cviku
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

// kontroluje jestli je video link
  bool _isVideoLink(String url) {
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }


// otevirani linku
  void _openVideoLink(BuildContext context, String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the video link')),
      );
    }
  }

// tvorba cviku v aplikaci
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
                _isVideoLink(form)
                    ? GestureDetector(
                        onTap: () => _openVideoLink(context, form),
                        child: Text(
                          "Watch Form Video",
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    : Text("Form: $form"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// formular ktery se vyplnuje pro pridani cviku
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