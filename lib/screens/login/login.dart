import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
import 'dart:convert';
import 'package:note/screens/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Android Device ID: ${androidInfo.id}');
  }

  final info = await deviceInfo.deviceInfo;
  print('General Device Info: ${info.toMap()}');

  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _userMobile = '';

  Future<Map<String, dynamic>> checkMobileInApi(String mobile) async {
    // 기기 정보 가져오기
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String device_info = '${androidInfo.id}';
    final apiUrl =
        'http://ntpalgak.gananet.co.kr/api/login.php?mobile=$mobile&device_info=$device_info&check=PC';

    try {
      final response = await http.get(Uri.parse(apiUrl));
        print('$apiUrl');
      if (response.statusCode == 200) {
        print('요청: ${response.body}');
        return Map<String, dynamic>.from(json.decode(response.body));
      } else {
        print('API 요청 실패: ${response.statusCode}');
        return {'result': 'failure'};
      }
    } catch (e) {
      print('API 요청 중 예외 발생: $e');
      return {'result': 'failure'};
    }
  }

//등록된 기기가 있을 때 다시 api 주고 받기
  void device_update(String mobile) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    String device_info = '${androidInfo.id}';

    final apiUrl =
        'http://ntpalgak.gananet.co.kr/api/login.php?mobile=$mobile&device_info=$device_info&check=PA';
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print('요청: ${response.body}');
        _navigateToWebView();
      } else {
        print('API 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('API 요청 중 예외 발생: $e');
    }
  }
  void _navigateToWebView() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _showLoginResult(Map<String, dynamic> result) async {
    if (result['mobile'] == 'success') {
      if (result['already'] == 'Y') {
        // 이미 등록된 기기가 있을 때 처리
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("경고"),
              content: Text("해당 번호로 이미 등록된 기기가 있습니다. 관리자에게 문의해주세요."),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                    _navigateToWebView(); // 웹 뷰로 이동
                  },
                  child: Text("확인"),
                ),
              ],
            );
          },
        );
      } else {
        // 등록 성공 알림 표시
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("등록 성공"),
              content: Text("등록되었습니다."),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 다이얼로그 닫기
                    _navigateToHomeScreen(); // 홈 화면으로 이동
                  },
                  child: Text("확인"),
                ),
              ],
            );
          },
        );
      }
    } else {
      // 로그인 실패 시 처리
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("로그인 실패"),
            content: Text("등록되지 않은 회원의 연락처입니다."),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 다이얼로그 닫기
                },
                child: Text("확인"),
              ),
            ],
          );
        },
      );
    }
  }

  void _navigateToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView( // Wrap your Column with SingleChildScrollView
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/17_logo.png",
                  height: 100,
                ),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _userMobile = value;
                      });
                    },
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: '휴대폰 번호를 - 없이 입력하세요',
                      fillColor: Colors.white,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    final result = await checkMobileInApi(_userMobile);
                    _showLoginResult(result);
                  },
                  child: Text('로그인'),
                ),
                SizedBox(height: 30),
                Image.asset(
                  "images/gana_w2.png",
                  height: 20,
                  width: 200,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

