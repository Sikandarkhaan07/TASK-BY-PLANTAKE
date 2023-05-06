import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantake/ui/page1/page1_controller.dart';

class Page1Screen extends StatefulWidget {
  const Page1Screen({super.key});

  @override
  State<Page1Screen> createState() => _Page1ScreenState();
}

class _Page1ScreenState extends State<Page1Screen> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    test();
    super.initState();
  }

  void test() async {
    await Page1Controller.backgroudImage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        if (Page1Controller.imageLink.isNotEmpty) ...[
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Image.network(
              fit: BoxFit.fill,
              Page1Controller.imageLink,
            ),
          ),
          const Center(
            child: Text(
              'The human who move a mountain \nBegin by carrying away small stones',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: mq.width * 0.4,
            top: mq.height * 0.55,
            child: const Text(
              'CONFUCIUS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: mq.height * 0.05,
            right: mq.width * 0.15,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.heart_solid,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: mq.height * 0.05,
            right: mq.width * 0.03,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.arrow_circle_right_sharp,
                color: Colors.white,
              ),
            ),
          ),
        ],
        if (Page1Controller.imageLink.isEmpty) ...[
          const Center(
            child: CircularProgressIndicator(),
          )
        ]
      ],
    ));
  }
}
