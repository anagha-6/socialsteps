import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/* ================= APP ROOT ================= */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

/* ================= SPLASH SCREEN ================= */

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> slideAnim;
  late Animation<double> fadeAnim;
  late Animation<double> scaleAnim;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    fadeAnim = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeIn));

    scaleAnim = Tween<double>(begin: 0.9, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOut));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4CC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: fadeAnim,
              child: SlideTransition(
                position: slideAnim,
                child: ScaleTransition(
                  scale: scaleAnim,
                  child: Image.asset(
                    'assets/images/main_image.png',
                    width: 220,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            FadeTransition(
              opacity: fadeAnim,
              child: const Text(
                "SocialSteps",
                style: TextStyle(
                  fontFamily: 'Aclonica',
                  fontSize: 32,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                padding:
                    const EdgeInsets.symmetric(horizontal: 42, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RoleSelectionScreen(),
                  ),
                );
              },
              child: const Text(
                "Start",
                style: TextStyle(
                  fontFamily: 'Aclonica',
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* ================= ROLE SELECTION (HOME PAGE) ================= */

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EF),
      appBar: AppBar(
        title: const Text("Who is using the app?"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          roleCard(
            context,
            title: "Parent / Mentor",
            subtitle: "Track progress and support learning",
            icon: Icons.person,
            screen: const ParentDashboard(),
          ),
          const SizedBox(height: 20),
          roleCard(
            context,
            title: "Child",
            subtitle: "Start learning and playing",
            icon: Icons.child_care,
            screen: const ChildDashboard(),
          ),
        ],
      ),
    );
  }
}

Widget roleCard(BuildContext context,
    {required String title,
    required String subtitle,
    required IconData icon,
    required Widget screen}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.orange.shade100,
            child: Icon(icon, size: 30, color: Colors.black54),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Text(subtitle, style: const TextStyle(color: Colors.grey)),
            ],
          ),
        ],
      ),
    ),
  );
}

/* ================= CHILD DASHBOARD ================= */

class ChildDashboard extends StatelessWidget {
  const ChildDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EF),
      appBar: AppBar(
        title: const Text("Let's Learn Together!"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            moduleCard(
              context,
              title: "Emotion Recognition",
              icon: Icons.emoji_emotions,
              screen: const EmotionScreen(),
            ),
            const SizedBox(height: 20),
            moduleCard(
              context,
              title: "Focus Training",
              icon: Icons.center_focus_strong,
              screen: const FocusScreen(),
            ),
          ],
        ),
      ),
    );
  }
}

Widget moduleCard(BuildContext context,
    {required String title,
    required IconData icon,
    required Widget screen}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 36, color: Colors.orange),
          const SizedBox(width: 20),
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    ),
  );
}

/* ================= PARENT DASHBOARD ================= */

class ParentDashboard extends StatelessWidget {
  const ParentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EF),
      appBar: AppBar(
        title: const Text("Parent Dashboard"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            ProgressTile(
              title: "Emotion Training",
              percent: 0.75,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            ProgressTile(
              title: "Focus Training",
              percent: 0.6,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}

class ProgressTile extends StatelessWidget {
  final String title;
  final double percent;
  final Color color;

  const ProgressTile(
      {super.key,
      required this.title,
      required this.percent,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: percent,
            color: color,
            backgroundColor: Colors.grey.shade300,
          ),
          const SizedBox(height: 6),
          Text("${(percent * 100).toInt()}% completed"),
        ],
      ),
    );
  }
}

/* ================= EMOTION MODULE ================= */

class EmotionScreen extends StatefulWidget {
  const EmotionScreen({super.key});

  @override
  State<EmotionScreen> createState() => _EmotionScreenState();
}

class _EmotionScreenState extends State<EmotionScreen> {
  String level = "easy";
  int imageIndex = 0;

  final Map<String, List<String>> emotionImages = {
    "easy": [
      "assets/emotions/easy/hpyeasy1.jpg",
      "assets/emotions/easy/sadeasy1.jpg",
      "assets/emotions/easy/angeasy1.jpg",
    ],
    "medium": [
      "assets/emotions/medium/hpymed1.jpg",
      "assets/emotions/medium/sadmed1.jpg",
      "assets/emotions/medium/anghard1.jpg",
    ],
    "hard": [
      "assets/emotions/hard/hpyhard1.jpg",
      "assets/emotions/hard/sadhard1.jpg",
      "assets/emotions/hard/anghard11.jpg",
      "assets/emotions/hard/surprised.jpg",
      "assets/emotions/hard/neutral.jpg",
    ],
  };

  final Map<String, String> correctAnswers = {
    "assets/emotions/easy/hpyeasy1.jpg": "Happy",
    "assets/emotions/easy/sadeasy1.jpg": "Sad",
    "assets/emotions/easy/angeasy1.jpg": "Angry",
    "assets/emotions/medium/hpymed1.jpg": "Happy",
    "assets/emotions/medium/sadmed1.jpg": "Sad",
    "assets/emotions/medium/anghard1.jpg": "Angry",
    "assets/emotions/hard/hpyhard1.jpg": "Happy",
    "assets/emotions/hard/sadhard1.jpg": "Sad",
    "assets/emotions/hard/anghard11.jpg": "Angry",
    "assets/emotions/hard/surprised.jpg": "Surprised",
    "assets/emotions/hard/neutral.jpg": "Neutral",
  };

  void checkAnswer(String selectedEmotion) {
    final currentImage = emotionImages[level]![imageIndex];

    if (correctAnswers[currentImage] == selectedEmotion) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const RewardScreen(
            message: "You identified the emotion correctly!",
          ),
        ),
      );

      setState(() {
        imageIndex++;
        if (imageIndex >= emotionImages[level]!.length) {
          imageIndex = 0;
          if (level == "easy") {
            level = "medium";
          } else if (level == "medium") {
            level = "hard";
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentImage = emotionImages[level]![imageIndex];

    return Scaffold(
      appBar: AppBar(title: const Text("Emotion Recognition")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Level: ${level.toUpperCase()}",
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          Image.asset(currentImage, width: 240, height: 240),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              emotionBtn("Happy", "😊"),
              emotionBtn("Sad", "😢"),
              emotionBtn("Angry", "😠"),
              emotionBtn("Surprised", "😲"),
            ],
          ),
        ],
      ),
    );
  }

  Widget emotionBtn(String emotion, String emoji) {
    return ElevatedButton(
      onPressed: () => checkAnswer(emotion),
      child: Text(emoji, style: const TextStyle(fontSize: 22)),
    );
  }
}

/* ================= FOCUS MODULE ================= */

class FocusScreen extends StatefulWidget {
  const FocusScreen({super.key});

  @override
  State<FocusScreen> createState() => _FocusScreenState();
}

class _FocusScreenState extends State<FocusScreen> {
  final Random random = Random();

  String level = "easy";
  int round = 1;

  bool showObjects = false;
  int starsToShow = 1;
  int starsTapped = 0;

  List<Offset> starPositions = [];
  List<Offset> distractorPositions = [];

  @override
  void initState() {
    super.initState();
    startRound();
  }

  Future<void> startRound() async {
    setState(() {
      showObjects = false;
      starsTapped = 0;
      starPositions.clear();
      distractorPositions.clear();
    });

    await Future.delayed(const Duration(seconds: 1));

    generateObjects();

    setState(() {
      showObjects = true;
    });
  }

  void generateObjects() {
    if (level == "easy") {
      starsToShow = 1;
    } else if (level == "medium") {
      starsToShow = 1;
    } else {
      starsToShow = round == 1 ? 1 : 2;
    }

    for (int i = 0; i < starsToShow; i++) {
      starPositions.add(randomPosition());
    }

    if (level == "hard") {
      for (int i = 0; i < 6; i++) {
        distractorPositions.add(randomPosition());
      }
    }
  }

  Offset randomPosition() {
    return Offset(
      random.nextDouble() * 250 + 20,
      random.nextDouble() * 350 + 20,
    );
  }

  void onStarTap() {
    starsTapped++;

    if (starsTapped >= starsToShow) {
      nextStep();
    }
  }

  void nextStep() {
    if (round < 3) {
      round++;
      startRound();
    } else {
      round = 1;
      if (level == "easy") {
        level = "medium";
      } else if (level == "medium") {
        level = "hard";
      } else {
        showCompletionDialog();
        return;
      }
      startRound();
    }
  }

  void showCompletionDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Great Job 🌟"),
        content: const Text("Focus Training Completed"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Focus Training")),
      body: Stack(
        children: [
          Center(
            child: Text(
              "Level: ${level.toUpperCase()} | Round: $round",
              style: const TextStyle(fontSize: 18),
            ),
          ),
          if (showObjects) ...[
            for (final pos in starPositions)
              Positioned(
                left: pos.dx,
                top: pos.dy,
                child: GestureDetector(
                  onTap: onStarTap,
                  child: const Icon(Icons.star,
                      size: 40, color: Colors.amber),
                ),
              ),
            for (final pos in distractorPositions)
              Positioned(
                left: pos.dx,
                top: pos.dy,
                child: const Icon(Icons.circle,
                    size: 30, color: Colors.grey),
              ),
          ],
        ],
      ),
    );
  }
}

/* ================= REWARD SCREEN ================= */

class RewardScreen extends StatelessWidget {
  final String message;

  const RewardScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4EF),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.emoji_events,
                size: 120, color: Colors.amber),
            const SizedBox(height: 20),
            const Text(
              "Great Job!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(message,
                style: const TextStyle(fontSize: 18, color: Colors.grey)),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
  