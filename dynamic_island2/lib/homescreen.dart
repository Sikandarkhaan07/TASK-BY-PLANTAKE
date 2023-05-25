import 'package:flutter/material.dart';
import 'package:system_alert_window/system_alert_window.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void reqPermission() {
    SystemAlertWindow.checkPermissions(prefMode: SystemWindowPrefMode.OVERLAY)
        .then((value) {
      print("Permission value: $value");
      if (value == true) {
        return;
      }
      SystemAlertWindow.requestPermissions(
          prefMode: SystemWindowPrefMode.OVERLAY);
    });
  }

  @override
  void initState() {
    reqPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                print("Clicked");
                SystemAlertWindow.showSystemWindow(
                  backgroundColor: Colors.black,
                  height: 50,
                  width: 390,
                  header: SystemWindowHeader(
                    padding: SystemWindowPadding.setSymmetricPadding(10, 10),
                    decoration: SystemWindowDecoration(
                      startColor: Colors.black,
                      borderRadius: 10,
                      borderWidth: 2,
                      borderColor: Colors.orange,
                    ),
                    subTitle: SystemWindowText(
                      text: "22",
                      fontSize: 20,
                      textColor: Colors.blueAccent,
                      fontWeight: FontWeight.BOLD,
                    ),
                    title: SystemWindowText(
                      text: "Day",
                      textColor: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  margin: SystemWindowMargin(
                      left: 8, right: 8, top: 10, bottom: 10),
                  gravity: SystemWindowGravity.TOP,
                  prefMode: SystemWindowPrefMode.OVERLAY,
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              child: const Text("Show Overlay"),
            ),
            ElevatedButton(
              onPressed: () {
                SystemAlertWindow.closeSystemWindow(
                    prefMode: SystemWindowPrefMode.OVERLAY);
              },
              child: const Text("Close Overlay"),
            ),
          ],
        ),
      ),
    );
  }
}
