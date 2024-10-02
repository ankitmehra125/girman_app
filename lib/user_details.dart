import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserDetailsDialog extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserDetailsDialog({required this.user});

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 7,
            spreadRadius: 0,
            offset: Offset(0, 0), // Shadow position
          ),
        ],
      ),
      padding: EdgeInsets.all(16), // Padding around the content
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: mQuery.size.height * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Fetch Details",
                style: TextStyle(
                  color: Color(0xff09090B),
                  fontSize: 22,
                  fontFamily: 'InterBold',
                ),
              ),
              IconButton(
                onPressed: ()
                {
                  Navigator.pop(context);
                },
                icon : Icon(
                  CupertinoIcons.clear,
                  color: Color(0xff000000),
                ),
              )
            ],
          ),
          SizedBox(height: mQuery.size.height * 0.005),
          Text(
            "Here are the details of the following employee.",
            style: TextStyle(
              fontSize: 12.96,
              color: Color(0xff71717A),
              fontFamily: 'InterMedium',
            ),
          ),
          SizedBox(height: mQuery.size.height * 0.01),
          Text(
            'Name: ${user['first_name']} ${user['last_name']}',
            style: TextStyle(
              fontSize: 12.96,
              fontFamily: 'InterMedium',
              color: Color(0xff09090B),
            ),
          ),
          Text(
            'Location: ${user['city']}',
            style: TextStyle(
              fontSize: 12.96,
              fontFamily: 'InterMedium',
              color: Color(0xff09090B),
            ),
          ),
          Text(
            'Contact Number: ${user['contact_number']}',
            style: TextStyle(
              fontSize: 12.96,
              fontFamily: 'InterMedium',
              color: Color(0xff09090B),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Profile Image:',
            style: TextStyle(
              fontSize: 12.96,
              fontFamily: 'InterMedium',
              color: Color(0xff09090B),
            ),
          ),
          SizedBox(height: 16),
          Container(
            width: mQuery.size.width * 0.5,
            height: mQuery.size.height * 0.23,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
          ),
          SizedBox(height: mQuery.size.height * 0.036),
        ],
      ),
    );
  }
}


//

void showUserDetails(BuildContext context, Map<String, dynamic> user) {
  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black54,
    transitionDuration: Duration(milliseconds: 500),
    pageBuilder: (BuildContext buildContext, Animation<double> animation, Animation<double> secondaryAnimation) {
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 1, // Optional: set a width for the dialog
          child: Dialog(
            backgroundColor: Colors.transparent, // Makes the background transparent
            child: UserDetailsDialog(user: user),
          ),
        ),
      );
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation.drive(Tween<double>(begin: 0.5, end: 1.0).chain(CurveTween(curve: Curves.easeInOut))),
          child: child,
        ),
      );
    },
  );
}