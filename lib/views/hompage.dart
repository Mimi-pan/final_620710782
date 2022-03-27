import 'dart:convert';
import 'dart:math';
import 'package:final_620710782/models/api_result.dart';
import 'package:final_620710782/models/AnimalThing.dart';
import 'package:final_620710782/page/views/Animal_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Animal_data.dart';

class WordsPage extends StatefulWidget {
  const WordsPage({Key? key}) : super(key: key);

  @override
  State<WordsPage> createState() => _WordsPageState();
}

class _WordsPageState extends State<WordsPage> {
  int wrong = 0;
  var isCorrect = false;

  @override
  void initState() {
    super.initState();
    _loadWord();
  }

  @override
  Widget build(BuildContext context) {
    var num = Random().nextInt(AnimalData.list.length);
    var item = AnimalData.list[num];
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(item.image),
              ),
            ],
          ),
          for(int i = 0; i < item.choices.length; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () => _handleClickItem(i, item),
                        child: Text(
                          item.choices[i], style: TextStyle(fontSize: 20),)),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }


  _loadWord() async {
    final url = Uri.parse('https://cpsu-test-api.herokuapp.com/quizzes');
    var result = await http.get(url,
        headers: {'id': '620710782'}); //await คือ การแปลงเป็น result.then()ให้
    var json = jsonDecode(result
        .body); // decode เพื่อแปลงออกมาเป็นโครงสร้างในภาษา dart จะได้ List ของ Map
    /*String status = jj['status']; //jj['ชื่อ key'] ,String ห้าม null
    String? msg = jj['message'];*/
    var api_re = ApiResult.fromJson(json);
    print(api_re.data);
    setState(() {
      AnimalData.list =
          api_re.data.map((e) => AnimalThing.fromJson(e)).toList();
    });
    print(AnimalData.list.length);
    //result.then((response) => print(response.body)); //(response) => print(response.body) คือ นิพจน์ฟังก์ชัน
    //result.then(_handleResponse); //(response) => print(response.body) คือ นิพจน์ฟังก์ชัน

    //var i =0;
    //Above code is 'Asynchronous programming'
    /*   EX. โปรแกรมเรียกฟังก์ชัน A(); และ B();
    โปรแกรมจะรันฟังก์ชัน A(); และ B(); ตามลำดับ
    โดยไม่สนใจว่าฟังก์ชัน A(); จะทำงานเสร็จรึยัง
    จะไปเรียกฟังก์ชัน B(); ต่อเลยทันที*/
  }

  void _handleClickItem(int index, AnimalThing anm) {
    if (index == anm.answer) {
      showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Awesome'),
              content: Text("It's correct"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
      /*Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WordsPage()),
      );*/

    } else {
      setState(() {
        wrong++;
        showDialog(context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Wrong'),
                content: Text('Try again '),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            });
      });
    }
  }
}