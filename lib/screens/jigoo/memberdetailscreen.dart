import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:note/screens/jigoo/jigoo.dart';
import 'package:url_launcher/url_launcher.dart';

// 새로운 화면 클래스 정의



class MemberDetailScreen extends StatelessWidget {
  final Member member;

  MemberDetailScreen({required this.member});




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('멤버 상세 정보'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 이미지 표시
              if (member.imgUrl != null) // 이미지 URL이 존재하는 경우에만 표시
                SizedBox(
                  width: 300,
                  height: 400,
                  child: Image.network(
                    member.imgUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      // 이미지 로드 중 오류 발생 시 기본 이미지 표시
                      return Image.asset(
                        '/images/memberimage.png',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              SizedBox(height: 16), // 이미지와 텍스트 간 간격 조정
              // 기존 텍스트 정보들
              SizedBox(height: 16), // 이미지와 텍스트 간 간격 조정


              Text(
                '지구직책: ${member.zonePosition}',
                style: TextStyle(fontSize: 25), // 글자 크기 조정
              ),
              Text(
                '이름: ${member.mberName}',
                style: TextStyle(fontSize: 20), // 글자 크기 조정
              ),
              Text(
                '소속: ${member.groupNm}',
                style: TextStyle(fontSize: 20), // 글자 크기 조정
              ),
              Text(
                '업체명: ${member.companyNm}',
                style: TextStyle(fontSize: 20), // 글자 크기 조정
              ),

              Text(
                '주소: ${member.Addr}',
                style: TextStyle(fontSize: 20), // 글자 크기 조정
              ),

              GestureDetector(
                onTap: () {
                  _launchCaller(member.mobile); // 전화 걸기 함수 호출
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '휴대전화번호: ',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black, // 번호 이외의 텍스트 색상
                      ),
                    ),
                    Text(
                      '${member.mobile}',
                      style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.underline,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchCaller(String phoneNumber) async {
    final url = '$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
