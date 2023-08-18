import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smilelines/screens/info_page.dart';
import 'package:smilelines/screens/jokes_page.dart';
import 'package:smilelines/screens/quotes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int index = 0;
  bool isVisible = false;
  final padding = EdgeInsets.symmetric(horizontal: 25, vertical: 12);

  final screens = const <Widget>[JokesPage(), QuotesPage(), InfoPage()];

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: IndexedStack(
        index: index,
        children: screens,
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.zero),
            color: Theme.of(context).primaryColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 4),
            child: GNav(
              tabs: [
                GButton(
                  gap: 10,
                  iconActiveColor: Colors.white,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  backgroundColor: Colors.white.withOpacity(.05),
                  iconSize: 25,
                  padding: padding,
                  icon: Icons.emoji_emotions,
                  text: 'Jokes',
                ),
                GButton(
                  gap: 10,
                  iconActiveColor: Colors.white,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  backgroundColor: Colors.white.withOpacity(.05),
                  iconSize: 25,
                  padding: padding,
                  icon: Icons.format_quote,
                  text: 'Quotes',
                ),
                GButton(
                  gap: 10,
                  iconActiveColor: Colors.white,
                  iconColor: Colors.white,
                  textColor: Colors.white,
                  backgroundColor: Colors.white.withOpacity(.05),
                  iconSize: 25,
                  padding: padding,
                  icon: Icons.info,
                  text: 'Info',
                )
              ],
              selectedIndex: index,
              onTabChange: (value) {
                setState(() {
                  index = value;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
