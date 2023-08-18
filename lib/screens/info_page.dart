import 'package:flutter/material.dart';
import 'package:smilelines/theme/themes.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  bool isLoading = false;
  int index = 0;
  final themeClass = ThemeClass(); // Get an instance of your ThemeClass

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            ) // Display loading indicator
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      'Welcome to the App!',
                      style: TextStyle(
                          fontSize: 20, color: Theme.of(context).cardColor),
                    ),
                    SizedBox(height: 40),
                    UserInfoWidget(context),
                    SizedBox(height: 40),
                    Text(
                      "Note: Pull Down to Load More",
                      style: Theme.of(context).textTheme.labelLarge,
                    )
                  ],
                ),
              ),
            ),
    );
  }

  Widget UserInfoWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(45),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/pandalogo.png',
            height: 140,
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 50, left: 50),
            child: Text(
              'Laughter is timeless, and quotes are boundless. Here every tap brings a smile, a chuckle, or a moment of reflection.',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }
}
