import 'package:flutter/material.dart';
import 'dart:core';

// دالة لتحليل الجملة والتحقق من صحة الوحدات المعجمية
String analyzeTerm(String input) {
  // تعريف القواعد
  final RegExp constantPattern = RegExp(r"^\d+$|^'.*'$");
  final RegExp variablePattern = RegExp(r"^[a-zA-Z]\w*$");
  final RegExp functionPattern = RegExp(r"^[a-zA-Z]\w*.*$");

  List<String> tokens = input.split(RegExp(r"[(),\s]+"));
  StringBuffer result = StringBuffer();

  for (var token in tokens) {
    if (constantPattern.hasMatch(token)) {
      result.writeln("$token: constante");
    } else if (variablePattern.hasMatch(token)) {
      result.writeln("$token: variable");
    } else if (functionPattern.hasMatch(token)) {
      result.writeln("$token: fonction");
    } else {
      result.writeln("$token: Erreur");
    }
  }

  return result.toString();
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TermAnalyzer(),
    );
  }
}

class TermAnalyzer extends StatefulWidget {
  @override
  _TermAnalyzerState createState() => _TermAnalyzerState();
}

class _TermAnalyzerState extends State<TermAnalyzer> {
  final TextEditingController _controller = TextEditingController();
  String _result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analyse du terme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                
                labelText: 'Saisir un terme',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _result = analyzeTerm(_controller.text);
                });
              },
              child: Text('Vérification'),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
