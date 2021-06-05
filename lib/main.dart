import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  var title = "RPMTW 模組翻譯查詢進度器";

  openURL() async {
    const url = 'https://github.com/RPMTW/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  get_mod_list() async {
    // make GET request
    final url = Uri.parse(
        'https://raw.githubusercontent.com/sunny0531/RPMTW-website-data/main/supported_mod.txt');
    Response response = await get(url);
    List<String> respond_ = response.body.split(",");
    final url2 = Uri.parse(
        'https://raw.githubusercontent.com/sunny0531/RPMTW-website-data/main/progress.txt');
    Response response2 = await get(url2);
    Map<String, dynamic> user = await jsonDecode(response2.body);
    return [respond_, user];
  }

  final TextEditingController input_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        theme: ThemeData.dark(),
        home: Scaffold(
          body: Center(
              child: Container(

                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(shrinkWrap: true,children: <Widget>[
                          SizedBox(
                            width: 25,
                            height: 25,
                          ),
                          TextField(
                            controller: input_controller,
                            onChanged: (text) {
                              setState(() {});
                            },
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: new OutlineInputBorder(
                                  borderSide: new BorderSide(color: Colors.blue)),
                              hintText: "請輸入模組映射碼或CurseForge專案ID",
                            ),
                          ),
                          SizedBox(
                            height: 10,
                            width: 10,
                          ),
                          FutureBuilder(
                            future: get_mod_list(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data[0]
                                    .contains(input_controller.text)) {
                                  var data_ =
                                      snapshot.data[1][input_controller.text];
                                  if (data_ == null) {
                                    data_ = 0;
                                  }
                                  return Text(
                                    "模組已經在資料庫內了，目前翻譯進度 " +
                                        data_.toString() +
                                        "% ",
                                    textAlign: TextAlign.center,
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .apply(fontSizeFactor: 1.3)
                                        
                                  );
                                } else if (input_controller.text.isNotEmpty) {
                                  return Text(
                                    "模組不在資料庫內，歡迎協助翻譯，詳請請查看: https://www.rpmtw.ga 或者RPMTW官方Discord伺服器",
                                    textAlign: TextAlign.center,
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .apply(fontSizeFactor: 1.3)
                                        
                                  );
                                } else {
                                  return Text(
                                    "請輸入模組映射碼或CurseForge模組專案ID",
                                    textAlign: TextAlign.center,
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .apply(fontSizeFactor: 1.25)
                                        
                                  );
                                }
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                          ),
                          Text(
                            "每三十分鐘更新資料一次\n" +
                                "此網頁主要由 sunny.ayyl#2932 開發製作，詳情請查看 Github儲存庫。",
                            textAlign: TextAlign.center,
                            style: DefaultTextStyle.of(context)
                                .style
                                
                          ),
                          Builder(
                            builder: (context) {
                              return TextButton(
                                onPressed: () {
                                  showLicensePage(
                                    context: context,
                                  );
                                },
                                child: Text('Show Licenses'),
                              );
                            },
                          ),
                        ]),
                      ),
                    ],
                  ))),
        ));
  }
}
