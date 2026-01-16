import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

/* ---------------- APP ROOT ---------------- */

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // 👈 STARTS HERE
    );
  }
}

/* ---------------- SPLASH SCREEN ---------------- */

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
                  MaterialPageRoute(builder: (_) => const HomePage()),
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

/* ---------------- HOME PAGE ---------------- */

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF4CC),
      appBar: AppBar(title: const Text("Learning Modules",style: TextStyle(fontFamily: 'Aclonica-Regular',fontWeight: FontWeight.bold,fontSize: 22,),)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text("Emotion Recognition",style: TextStyle(fontFamily: 'Aclonica-Regular',fontWeight: FontWeight.bold,),),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EmotionScreen()),
              );
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
             style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC107),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
              ),
            child: const Text("Focus Training",style: TextStyle(fontFamily: 'Aclonica-Regular',fontWeight: FontWeight.bold,),),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FocusScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}


/* ---------------- EMOTION MODULE ---------------- */

class EmotionScreen extends StatefulWidget {
  const EmotionScreen({super.key});

  @override
  State<EmotionScreen> createState() => _EmotionScreenState();
}

class _EmotionScreenState extends State<EmotionScreen> {
  String level = "easy";
  int imageIndex = 0;
  String feedback = "";

  /* ---------- IMAGE LIST ---------- */

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

  /* ---------- LOGIC ---------- */

  void checkAnswer(String selectedEmotion) {
    final currentImage = emotionImages[level]![imageIndex];

    setState(() {
      if (correctAnswers[currentImage] == selectedEmotion) {
        feedback = "Correct ✅";
        imageIndex++;

        if (imageIndex >= emotionImages[level]!.length) {
          imageIndex = 0;

          if (level == "easy") {
            level = "medium";
            feedback = "Easy Level Completed 🎉";
          } else if (level == "medium") {
            level = "hard";
            feedback = "Medium Level Completed 🎉";
          } else {
            feedback = "All Levels Completed 🌟";
          }
        }
      } else {
        feedback = "Try Again ❌";
      }
    });
  }

  /* ---------- UI ---------- */

  @override
  Widget build(BuildContext context) {
    final currentImage = emotionImages[level]![imageIndex];

    return Scaffold(
      appBar: AppBar(title: const Text("Emotion Recognition")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Level: ${level.toUpperCase()}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          Image.asset(
              currentImage,
              width: 260,
              height: 260,
              fit: BoxFit.contain,
            ),

          const SizedBox(height: 30),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              emotionButton("Happy", "😊"),
              emotionButton("Sad", "😢"),
              emotionButton("Angry", "😠"),
              emotionButton("Surprised", "😲"),
            ],
          ),

          const SizedBox(height: 25),

          Text(
            feedback,
            style: const TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }

  Widget emotionButton(String emotion, String emoji) {
    return ElevatedButton(
      onPressed: () => checkAnswer(emotion),
      child: Text(emoji, style: const TextStyle(fontSize: 22)),
    );
  }
}
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
    // EASY
    if (level == "easy") {
      starsToShow = 1;
    }

    // MEDIUM
    else if (level == "medium") {
      starsToShow = 1;
    }

    // HARD
    else {
      starsToShow = round == 1 ? 1 : 2;
    }

    // Generate stars
    for (int i = 0; i < starsToShow; i++) {
      starPositions.add(randomPosition());
    }

    // Generate distractors ONLY for hard
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
              "Level: ${level.toUpperCase()}  |  Round: $round",
              style: const TextStyle(fontSize: 18),
            ),
          ),

          if (showObjects) ...[
            // Stars
            for (final pos in starPositions)
              Positioned(
                left: pos.dx,
                top: pos.dy,
                child: GestureDetector(
                  onTap: onStarTap,
                  child: const Icon(Icons.star, size: 40, color: Colors.amber),
                ),
              ),

            // Distractors (hard only)
            for (final pos in distractorPositions)
              Positioned(
                left: pos.dx,
                top: pos.dy,
                child: const Icon(Icons.circle, size: 30, color: Colors.grey),
              ),
          ],
        ],
      ),
    );
  }
}

