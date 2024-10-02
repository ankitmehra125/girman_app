
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:girman_app/models/user.dart';
import 'package:girman_app/screens/home/popup_menu.dart';
import 'package:girman_app/user_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();

  List<User> users = [];
  List<User> filteredUsers = [];

  bool isSearching = false; // New variable to track search state

  @override
  void initState() {
    super.initState();
    loadUsers().then((loadedUsers) {
      setState(() {
        users = loadedUsers;
        filteredUsers = loadedUsers; // Initially show all users
      });
    });
  }

  Future<List<User>> loadUsers() async {
    final String response = await rootBundle.loadString('lib/data/user.json');
    final List<dynamic> data = json.decode(response);
    return data.map((user) => User.fromJson(user)).toList();
  }

  void _filterUsers(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredUsers = users; // Show all users if the search query is empty
      });
    } else {
      setState(() {
        filteredUsers = users.where((user) {
          final fullName = '${user.firstName} ${user.lastName}'.toLowerCase();
          return fullName.contains(query.toLowerCase()); // Filter users based on the query
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Background image with gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                colors: [
                  Color(0xffffffff).withOpacity(0.7),
                  Color(0xffB1CBFF).withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // SafeArea with UI elements
          SafeArea(
            child: Column(
              children: [
                // Row for logo and menu icon
                if (!isSearching) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffF5F5F5),
                          blurRadius: 7,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/Logo.svg",
                        ),
                        SizedBox(width: mQuery.width * 0.02),
                        SvgPicture.asset(
                          "assets/images/gt.svg",
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showItemMenu(context);
                              isSearching = !isSearching; // Toggle search state
                              searchController.clear(); // Clear the search field
                              filteredUsers = users; // Reset filtered users
                            });
                          },
                          child: SvgPicture.asset(
                            "assets/images/menu.svg",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10), // Adjusted height for better UI
                  // Default title if not searching
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/gtLogo.svg",
                        width: kIsWeb ? 60 : null,
                      ),
                      Text(
                        "Girman",
                        style: TextStyle(
                          fontSize: kIsWeb ? 40 : 57,
                          color: Color(0xff111111),
                          fontFamily: 'PoppinsBold',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: mQuery.height * 0.023), // Space after title
                ],
                // Search bar container
                if (isSearching) ...[
                  // Show search container when in search mode
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xffF5F5F5),
                          blurRadius: 7,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "assets/images/Logo.svg",
                        ),
                        SizedBox(width: mQuery.width * 0.02),
                        SvgPicture.asset(
                          "assets/images/gt.svg",
                        ),
                        Expanded(child: SizedBox()),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              showItemMenu(context);
                            });
                          },
                          child: SvgPicture.asset(
                            "assets/images/menu.svg",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20), // Space after search bar
                ],
                // List of filtered users
                Expanded(
                  child: UsersList(users: filteredUsers), // Pass filtered users to the list
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}