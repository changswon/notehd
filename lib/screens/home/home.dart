import 'package:flutter/material.dart';
import 'package:note/constants.dart';
import 'package:note/screens/memberlist/memberlist.dart';
import 'package:note/screens/jigoo/jigoo.dart';
import 'package:note/screens/palgaklist/palgaklist.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          Divider(
            color: Colors.grey,
            thickness: 1.0,
          ),
          Expanded(
            child: SingleChildScrollView(
              child: BodyScreen(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '전체 연락처',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '개인정보처리방침',
          ),
        ],
        onTap: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MemberListScreen()),
            );
          }
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.blue,
      toolbarHeight: 60.0,
      title: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Image.asset(
                  'images/18_logo.png',
                  height: 60.0,
                  width: 270.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BodyScreen extends StatelessWidget {
  const BodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'images/mnote.jpg',
            height: 200.0,
            width: 410.0,
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  style: TextStyle(fontSize: 15.0),
                  decoration: InputDecoration(
                    hintText: '회원명 검색',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40.0)),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 3,
                      ),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 15.0,
                      horizontal: 20.0,
                    ),
                    suffixIcon: Icon(Icons.search, color: Colors.grey),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => JigooScreen()),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.4,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '지구임원단',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PalgakScreen()),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.4,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '팔각회 목록',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              Image.asset(
                'images/gana.jpg',
                height: 130.0,
                width: 410.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

