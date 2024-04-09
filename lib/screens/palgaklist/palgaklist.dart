import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:note/screens/palgaklist/detailscreen.dart';

// API로부터 데이터 가져오기
Future<List<Content>> fetchContents() async {
  final response = await http.get(Uri.parse('http://ntpalgak.gananet.co.kr/api/content.php'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    List<Content> contents = [];

    for (int i = 0; i < data.length; i++) {
      contents.add(Content.fromJson(data[i] as Map<String, dynamic>));
    }

    return contents;
  } else {
    throw Exception('Failed to load contents');
  }
}

class Content {
  final String coId;
  final String coSubject;

  Content({
    required this.coId,
    required this.coSubject,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    return Content(
      coId: json['co_id'] as String,
      coSubject: json['co_subject'] as String,
    );
  }
}

class ContentListScreen extends StatefulWidget {
  @override
  _ContentListScreenState createState() => _ContentListScreenState();
}

class _ContentListScreenState extends State<ContentListScreen> {
  late Future<List<Content>> _contents;

  @override
  void initState() {
    super.initState();
    _contents = fetchContents();
  }

  void _navigateToDetailScreen(BuildContext context, String coId, String coSubject) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen( coId: coId, coSubject: coSubject,),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('팔각회 목록'),
      ),
      body: FutureBuilder<List<Content>>(
        future: _contents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Content content = snapshot.data![index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey), // 테두리 스타일 지정
                    borderRadius: BorderRadius.circular(10), // 테두리 모양 지정
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10), // 목록 간격 조정
                  child: ListTile(
                    title: Center( // 가운데 정렬
                      child: Text(
                        content.coSubject,
                        textAlign: TextAlign.center, // 텍스트 정렬
                      ),
                    ),
                    onTap: () {
                      _navigateToDetailScreen(context, content.coId, content.coSubject);
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ContentListScreen(),
  ));
}