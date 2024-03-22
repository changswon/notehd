import 'package:flutter/material.dart';

class PalgakScreen extends StatelessWidget {
  const PalgakScreen({Key? key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('팔각회 목록'),
      ),
      body: ListView.builder(
        itemCount: 22, // 22개의 항목
        itemBuilder: (BuildContext context, int index) {
          // 각 아이템을 만듭니다.
          return ListTile(
            title: Text('항목 ${index + 1}'),
            onTap: () {
              // 각 항목을 클릭했을 때의 동작을 정의할 수 있습니다.
              // 예를 들어 해당 항목에 대한 세부 정보 페이지로 이동하는 등의 작업이 가능합니다.
            },
          );
        },
      ),
    );
  }
}
