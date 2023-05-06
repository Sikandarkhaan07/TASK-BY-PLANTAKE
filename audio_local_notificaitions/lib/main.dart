import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'audio.dart';

// void main() async {
// WidgetsFlutterBinding.ensureInitialized();

// AwesomeNotifications().initialize(null, [
//   // notification icon
//   NotificationChannel(
//     channelGroupKey: 'basic_test',
//     channelKey: 'basic',
//     channelName: 'Basic notifications',
//     channelDescription: 'Notification channel for basic tests',
//     channelShowBadge: true,
//     importance: NotificationImportance.High,
//     enableVibration: true,
//   ),
// ]);

//   runApp(MyApp()); //run your app.
// }

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'MainActivity',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomeScreen());
  }
}
//
// class Home extends StatefulWidget {
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Local Notification in Flutter"),
//         backgroundColor: Colors.deepOrangeAccent,
//       ),
//       body: Container(
//         alignment: Alignment.topCenter,
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           children: [
//             // ElevatedButton(
//             //     onPressed: () async {
//             //       bool isallowed =
//             //           await AwesomeNotifications().isNotificationAllowed();
//             //       if (!isallowed) {
//             //         //no permission of local notification
//             //         AwesomeNotifications()
//             //             .requestPermissionToSendNotifications();
//             //       } else {
//             //         //show notification
//             //         AwesomeNotifications().createNotification(
//             //             content: NotificationContent(
//             //               //simgple notification
//             //               id: 123,
//             //               channelKey:
//             //                   'basic', //set configuration wuth key "basic"
//             //               title: 'Welcome to FlutterCampus.com',
//             //               body:
//             //                   'This simple notification with action buttons in Flutter App',
//             //               payload: {"name": "FlutterCampus"},
//             //               autoDismissible: false,
//             //             ),
//             //             actionButtons: [
//             //               NotificationActionButton(
//             //                 key: "open",
//             //                 label: "Open File",
//             //               ),
//             //               NotificationActionButton(
//             //                 key: "delete",
//             //                 label: "Delete File",
//             //               )
//             //             ]);
//             //       }
//             //     },
//             //     child: const Text("Show Notification With Button")),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
//
//
// // import 'package:awesome_notifications/awesome_notifications.dart';
// // import 'package:flutter/material.dart';
// // import 'package:just_audio/just_audio.dart';
//
// // import 'audio.dart';
//
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   // Initialize the package
// //   await AwesomeNotifications().initialize(
// //     // Set the icon for the notification
// //     null,
// //     [
// //       NotificationChannel(
// //         // Set the channel id and name
// //         channelKey: 'basic_channel',
// //         channelName: 'Basic notifications',
// //         channelDescription: 'Notification channel for basic notifications',
// //         // Set the importance level for the channel
// //         importance: NotificationImportance.High,
// //         defaultColor: const Color(0xFF9D50DD),
// //       ),
// //     ],
// //     debug: false,
// //   );
// //   runApp(const MyApp());
// // }
//
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Audio Local Noti',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       home: const HomeScreen(),
// //     );
// //   }
// // }
