import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:girman_app/user_details.dart';

import 'models/user.dart';

class UsersList extends StatefulWidget {
  final List<User> users;

  // Constructor to accept users list
  const UsersList({Key? key, required this.users}) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> filteredUsers = [];
  late final Function(User) onFetchDetails;

  @override
  void initState() {
    super.initState();
    fetchUsers().then((fetchedUsers) {
      setState(() {
        users = fetchedUsers;
        filteredUsers = fetchedUsers; // Initially show all users
      });
    });
  }

  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
    final QuerySnapshot snapshot = await usersCollection.get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  void _filterUsers(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredUsers = users; // Reset filtered users if the query is empty
      });
    } else {
      setState(() {
        filteredUsers = users.where((user) {
          final fullName = '${user['first_name']} ${user['last_name']}'.toLowerCase();
          return fullName.contains(query.toLowerCase());
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffB1CBFF).withOpacity(0.2),
              Color(0xffB1CBFF).withOpacity(0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: kIsWeb ? mQuery.size.height*0.032 : 0) ,
            // Search Bar
            Container(
              width: kIsWeb ? mQuery.size.width*0.9 :double.infinity,
              height: 51,
              margin: EdgeInsets.symmetric(
                  horizontal: mQuery.size.width * 0.05
              ),
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                border: Border.all(color: Color(0xffD7D7EA)),
              ),
              child: Row(
                children: [
                  SvgPicture.asset("assets/images/searchIcon.svg"),
                  SizedBox(width: mQuery.size.width * 0.032),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: _filterUsers,
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        color: Color(0xff71717A),
                      ),
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'PoppinsRegular',
                          color: Color(0xff71717A),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // User List
            Expanded(
              child: filteredUsers.isNotEmpty
                  ? ListView.builder(
                itemCount: filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = filteredUsers[index];
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: kIsWeb ? 60 : 16,
                        vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          spreadRadius: 0,
                          offset: Offset(0, 0),
                        ),
                      ],
                      border: Border.all(color: Color(0xffE1E1E1)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 106,
                          height: 106,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Color(0xffF3F3F3)),
                          ),
                          child: Center(
                            child: CircleAvatar(
                              radius: 43,
                            ),
                          ),
                        ),
                        SizedBox(height: mQuery.size.height * 0.006),
                        Text(
                          '${user['first_name']} ${user['last_name']}',
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xff09090B),
                            fontFamily: 'InterBold',
                          ),
                        ),
                        SizedBox(height: mQuery.size.height * 0.01),
                        Row(
                          children: [
                            SvgPicture.asset("assets/images/location.svg"),
                            SizedBox(width: mQuery.size.width * 0.016),
                            Text(
                              user['city'],
                              style: TextStyle(
                                color: Color(0xff425763),
                                fontSize: 8,
                                fontFamily: 'InterMedium',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: mQuery.size.height * 0.02),
                        Divider(color: Color(0xffF3F3F3)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset("assets/images/phoneIcon.svg"),
                                    SizedBox(width: mQuery.size.width * 0.016),
                                    Text(
                                      user['contact_number'],
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontFamily: 'InterBold',
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: mQuery.size.height * 0.007),
                                Text(
                                  "Available on phone",
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Color(0xffAFAFAF),
                                    fontFamily: 'InterMedium',
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: ()
                              {
                                showUserDetails(context,user);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Color(0xff18181B),
                                  borderRadius: BorderRadius.circular(6.92),
                                ),
                                child: Center(
                                  child: Text(
                                    "Fetch Details",
                                    style: TextStyle(
                                      fontSize: 12.11,
                                      color: Color(0xffFAFAFA),
                                      fontFamily: 'InterBold',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              )
                  : Center(
                child: Image.asset("assets/images/empty.png",)
              ),
            ),
          ],
        ),
      ),
    );
  }
}



