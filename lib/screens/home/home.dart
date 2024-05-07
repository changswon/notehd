import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/constants.dart';
import 'package:note/screens/jigoo/jigoo.dart';
import 'package:note/screens/palgaklist/palgaklist.dart';
import 'package:note/screens/home/searchresultscreen.dart';
import 'package:note/screens/home/councilscreen.dart';
import 'package:note/screens/rules/RulesScreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: RefreshIndicator(
        // 당겨서 새로고침이 발생할 때 수행할 작업을 정의
        onRefresh: () async {
          // 당겨서 새로고침 시 수행할 비동기 작업을 여기에 작성
          await Future.delayed(Duration(seconds: 1)); // 예시로 1초 지연 추가
        },
        child: BodyScreen(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // 선택되지 않은 아이템의 색상 모두 출력
        selectedItemColor: Colors.black, // 선택된 아이템의 아이콘 및 텍스트 색상
        unselectedItemColor: Colors.black, // 선택되지 않은 아이템의 아이콘 및 텍스트 색상
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: '협의회',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '회칙',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle),
            label: '규정&규약',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context, // 위젯의 위치, 즉 홈스크린을 가리킴
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CouncilScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RulesScreen()),
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
                  'images/17_logo2.png',
                  height: 50.0,
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

final TextEditingController _searchController = TextEditingController();

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
          SizedBox(height: 20,),
          Column(
            children: [
              TextField(
                controller: _searchController, // _searchController 설정
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
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.grey),
                    onPressed: () {
                      String searchWord = _searchController.text.trim();
                      if (searchWord.isNotEmpty) {
                        searchMember(context, searchWord);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => JigooScreen()),
                          );
                        },
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '역대 연합회장 연혁',
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
                            MaterialPageRoute(builder: (context) => ContentListScreen()),
                          );
                        },
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '공조회 회칙',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // Handle the tap for '회원명부'
                        },
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '회원명부',
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
                            MaterialPageRoute(builder: (context) => ContentListScreen()),
                          );
                        },
                        child: Container(
                          height: 120,
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '조선사업부',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),

              Image.asset(
                'images/gana.jpg',
                height: 150.0,
                width: 410.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// 검색을 수행하는 함수
Future<void> searchMember(BuildContext context,String searchWord) async {
  var endpoint = 'http://ntpalgak.gananet.co.kr/api/member.php';
  var queryParameters = {
    'search_type': 'mber_name',
    'search_word': searchWord,
  };

  var uri = Uri.parse(endpoint).replace(queryParameters: queryParameters);

  try {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print('Search API Response: $jsonData'); // API 응답 로그 출력
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchResultScreen(searchResults: jsonData, searchWord:searchWord,)),
      );

    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}