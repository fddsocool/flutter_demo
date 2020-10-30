import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {

  final String errorMsg;

  NotFoundPage({String msg}) :this.errorMsg = msg ?? "该页面不存在";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("页面错误"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(errorMsg),
      ),
    );
  }
}
