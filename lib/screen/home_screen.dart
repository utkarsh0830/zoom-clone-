import 'package:flutter/material.dart';
import 'package:zoom/resources/auth_method.dart';
import 'package:zoom/screen/history_meeting_screen.dart';
import 'package:zoom/utils/colors.dart';
import 'package:zoom/widgets/custom_button.dart';
import 'meeting_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _page = 0;
  onPageChanged(int selectedIndex){
    setState(() {
      _page = selectedIndex;
    });
  }
  List<Widget> pages = [
     MeetingScreen(),
     const HistoryMeetingScreen(),
     const Text('Contacts'),
     CustomButton(text: 'Log Out', onPressed: AuthMethods().signOut),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
          title: const Text('Meet & chat'),
        centerTitle: true,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: footerColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: onPageChanged,
        currentIndex: _page,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 14,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.comment_bank),
            label: 'Meet & Chat'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.lock_clock),
              label: 'Meetings'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Contacts'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings'
          ),

        ],
      ),
    );
  }
}
