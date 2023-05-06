import 'package:flutter/material.dart';
import 'package:plantake/ui/home_screen/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          IconButton(
              onPressed: () {
                HomeController.signOut(context);
              },
              icon: const Icon(Icons.logout_rounded))
        ],
      ),
    );
  }
}
