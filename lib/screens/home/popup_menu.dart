import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../blocs/popupmenu/popup_menu_bloc.dart';
import '../../blocs/popupmenu/popup_menu_event.dart';
import '../../blocs/popupmenu/popup_menu_state.dart';

void showItemMenu(BuildContext context) {
  var mQuery = MediaQuery.of(context);
  final popupMenuBloc = BlocProvider.of<PopupMenuBloc>(context);

  showMenu(
    context: context,
    color: Colors.white,
    position: RelativeRect.fromLTRB(100, 90, 30, 0),
    items: [
      PopupMenuItem<String>(
        onTap: () {
          popupMenuBloc.add(SelectedMenuItem('Search'));
        },
        value: 'Search',
        child: BlocBuilder<PopupMenuBloc, PopupMenuState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'SEARCH',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'PoppinsRegular',
                      color: state.selectedItem == "Search"
                          ? Color(0xff3063E6)
                          : Color(0xff111111),
                    ),
                  ),
                  if (state.selectedItem == "Search")
                    Container(
                      width: mQuery.size.width * 0.135,
                      height: 1.5,
                      color: Color(0xff3063E6),
                    ),
                ],
              ),
            );
          },
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          popupMenuBloc.add(SelectedMenuItem('Website'));
          _launchURL("https://www.girmantech.com/");
        },
        value: 'Website',
        child: BlocBuilder<PopupMenuBloc, PopupMenuState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'WEBSITE',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: state.selectedItem == "Website" ? 'PoppinsBold' :'PoppinsRegular',
                      color: state.selectedItem == "Website"
                          ? Color(0xff3063E6)
                          : Color(0xff111111),
                    ),
                  ),
                  if (state.selectedItem == "Website")
                    Container(
                      width: mQuery.size.width * 0.135,
                      height: 1.5,
                      color: Color(0xff3063E6),
                    ),
                ],
              ),
            );
          },
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          popupMenuBloc.add(SelectedMenuItem('Linkedin'));
          _launchURL("https://www.linkedin.com/company/girmantech/posts/?feedView=all");
        },
        value: 'Linkedin',
        child: BlocBuilder<PopupMenuBloc, PopupMenuState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'LINKEDIN',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: state.selectedItem == "Linkedin" ? 'PoppinsBold' :'PoppinsRegular',
                      color: state.selectedItem == "Linkedin"
                          ? Color(0xff3063E6)
                          : Color(0xff111111),
                    ),
                  ),
                  if (state.selectedItem == "Linkedin")
                    Container(
                      width: mQuery.size.width * 0.135,
                      height: 1.5,
                      color: Color(0xff3063E6),
                    ),
                ],
              ),
            );
          },
        ),
      ),
      PopupMenuItem<String>(
        onTap: () {
          popupMenuBloc.add(SelectedMenuItem('Contact'));
          _launchEmail("contact@girmantech.com");
        },
        value: 'Contact',
        child: BlocBuilder<PopupMenuBloc, PopupMenuState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'CONTACT',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: state.selectedItem == "Contact" ? 'PoppinsBold' : 'PoppinsRegular',
                      color: state.selectedItem == "Contact"
                          ? Color(0xff3063E6)
                          : Color(0xff111111),
                    ),
                  ),
                  if (state.selectedItem == "Contact")
                    Container(
                      width: mQuery.size.width * 0.135,
                      height: 1.5,
                      color: Color(0xff3063E6),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    ],
  ).then((value) {
    if (value != null) {
      print(value);
    }
  });
}



void _launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

void _launchEmail(String email) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
    query: 'subject=Contact Inquiry', // Optional: Add a subject
  );

  if (await canLaunchUrl(emailLaunchUri)) {
    await launchUrl(emailLaunchUri);
  } else {
    throw 'Could not launch $email';
  }
}
