import 'package:flutter/material.dart';

class CouncilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('협의회'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              '전화',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '052)202-5824, 233-4301',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '팩스',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22.0,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '052)233-4300',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
