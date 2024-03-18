import 'dart:convert';
import 'package:note/screens/login/login.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'membernote',
      theme: ThemeData(
        // Your theme settings here
      ),
      home: MainScreen(), // LoginScreen으로 변경
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late String _deviceSerialNumber = '';

  @override
  void initState() {
    super.initState();
    _getDeviceSerialNumber();
  }

  Future<void> _getDeviceSerialNumber() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    late String serialNumber;

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      serialNumber = androidInfo.serialNumber;
    }

    setState(() {
      _deviceSerialNumber = serialNumber;
    });

    // API 호출
    _sendSerialNumberToApi(serialNumber);
  }

  Future<void> _sendSerialNumberToApi(String serialNumber) async {
    final apiUrl = 'https://hhicm.gananet.co.kr/build/api/device_check.php?device_info=$serialNumber';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // API 호출 성공
        print('Serial number sent successfully');
        print('요청: ${response.body}');
        // 성공 시 메인 페이지로 이동
        // JSON 응답 파싱
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        // 'device' 값을 읽어오기
        String deviceValue = jsonResponse['device'];

        // 결과 출력
        print('요청: $deviceValue');

        if (deviceValue == 'true') {
          // 로그인 성공: 웹뷰 화면으로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WebViewScreen()),
          );
        } else {
          // 로그인 실패: 로그인 페이지로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }
      } else {
        // API 호출 실패
        print('Failed to send serial number. Status code: ${response
            .statusCode}');
      }
    } catch (e) {
      print('Exception occurred while sending serial number: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: null, // 제목을 null로 설정하여 빈 공간을 만듭니다.
        backgroundColor: Colors.transparent, // 배경색 투명하게 설정
        elevation: 0, // 그림자 제거
      ),
      body: Center(
        child: Image.asset(
          'images/logo.png', // 로고 이미지 파일 경로
          height: 40, // 로고 높이 설정
        ),
      ),
    );
  }
}