import 'dart:math';
import 'package:smilelines/data/quotes.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smilelines/theme/themes.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({Key? key}) : super(key: key);

  @override
  _QuotesPageState createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  bool isLoading = false;
  final themeClass = ThemeClass(); // Get an instance of your ThemeClass

  @override
  void initState() {
    super.initState();
    initialise();
  }

  initialise() {
    setState(() {
      isLoading = true;
      fetchData();
    });
  }

  Future<List<dynamic>> getRandomQuotes() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate delay

    final random = Random();
    final List<dynamic> selectedQuotes = [];

    while (selectedQuotes.length < 10) {
      final randomIndex = random.nextInt(quotes.length);
      final selectedQuote = quotes[randomIndex];

      if (!selectedQuotes.contains(selectedQuote)) {
        selectedQuotes.add(selectedQuote);
      }
    }

    return selectedQuotes;
  }

  late List<dynamic> itemList = [];
  Future<void> fetchData() async {
    List<dynamic> quotesList = await getRandomQuotes();
    setState(() {
      itemList = quotesList;
      isLoading = false;
    });
  }

  Future<void> fetchMoreData() async {
    List<dynamic> jsonData = await getRandomQuotes();

    setState(() {
      for (var i = 0; i < jsonData.length; i++) {
        if (!itemList.contains(jsonData[i])) {
          itemList.insert(0, jsonData[i]);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            ) // Display loading indicator
          : LiquidPullToRefresh(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              color: Theme.of(context).primaryColor,
              animSpeedFactor: 8,
              height: screenSize.height * 0.2,
              onRefresh: fetchMoreData,
              child: ListView(
                  children: itemList.map((item) {
                return quotesCard(context,
                    title: item["type"], description: item["quote"]);
              }).toList()),
            ),
    );
  }

  Widget quotesCard(BuildContext context,
      {String title = "", String description = ""}) {
    final screenSize = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: screenSize.width,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Text(title.toUpperCase(),
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Container(
            padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Text(
              description,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                MaterialButton(
                  onPressed: (() {
                    Share.share(description);
                  }),
                  color: isDarkMode
                      ? themeClass.darkCardButtonColor
                      : themeClass.lightCardButtonColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 2), // Customize the border color and width
                    borderRadius: BorderRadius.circular(
                        20), // Customize the border radius
                  ),
                  child: Text(
                    'Share',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall, // Set the text color
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                MaterialButton(
                  color: isDarkMode
                      ? themeClass.darkCardButtonColor
                      : themeClass.lightCardButtonColor,
                  onPressed: (() {
                    Clipboard.setData(new ClipboardData(text: description))
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        'Copied to your clipboard !',
                        style: Theme.of(context).textTheme.titleSmall,
                      )));
                    });
                  }),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 2), // Customize the border color and width
                    borderRadius: BorderRadius.circular(
                        20), // Customize the border radius
                  ),
                  child: Text(
                    'Copy',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall, // Set the text color
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
