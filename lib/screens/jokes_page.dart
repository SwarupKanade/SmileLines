import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:smilelines/theme/themes.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:share_plus/share_plus.dart';

class JokesPage extends StatefulWidget {
  const JokesPage({Key? key}) : super(key: key);

  @override
  _JokesPageState createState() => _JokesPageState();
}

class _JokesPageState extends State<JokesPage> {
  bool isLoading = false;
  int index = 0;
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

  late List<dynamic> itemList = [];
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://hindi-jokes-api.onrender.com/jokes/5/?api_key=5a7b32b44725b9a69f271b79c763'));

    if (response.statusCode == 200) {
      // Data was fetched successfully
      Map<String, dynamic> jsonData = json.decode(response.body);
      if (jsonData["status"] == "Success") {
        setState(() {
          itemList = jsonData["data"];
          isLoading = false;
        });
      }
      // Process jsonData as needed
    } else {
      // Error handling
      print('Failed to fetch data: ${response.body}');
    }
  }

  Future<void> fetchMoreData() async {
    final response = await http.get(Uri.parse(
        'https://hindi-jokes-api.onrender.com/jokes/5/?api_key=5a7b32b44725b9a69f271b79c763'));

    if (response.statusCode == 200) {
      // Data was fetched successfully
      Map<String, dynamic> jsonData = json.decode(response.body);
      if (jsonData["status"] == "Success") {
        setState(() {
          for (var i = 0; i < jsonData["data"].length; i++) {
            itemList.insert(0, jsonData["data"][i]);
          }
        });
      }
      // Process jsonData as needed
    } else {
      // Error handling
      print('Failed to fetch data: ${response.statusCode}');
    }
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
                return jokeCard(context,
                    title: item["jokeNo"].toString(),
                    description: item["jokeContent"]);
              }).toList()),
            ),
    );
  }

  Widget jokeCard(BuildContext context,
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
          Text("Joke No $title",
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
