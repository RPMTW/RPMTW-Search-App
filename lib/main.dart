import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  var title = "RPMTW";

  get_mod_list() async {
    // make GET request
    final url = Uri.parse(
        'https://raw.githubusercontent.com/sunny0531/RPMTW-website-data/main/supported_mod.txt');
    Response response = await get(url);
    List<String> respond_ = response.body.split(",");
    final url2 = Uri.parse(
        'https://raw.githubusercontent.com/sunny0531/RPMTW-website-data/main/progress.txt');
    Response response2 = await get(url2);
    Map<String, dynamic> user =await jsonDecode(response2.body);
    return [respond_,user];
  }

  final TextEditingController input_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: title,
        home: Scaffold(
          body: Center(
              child: ListView(children: <Widget>[
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Mod name'),
              controller: input_controller,
              onChanged: (text) {
                setState(() {
                });;
              },
            ),
            FutureBuilder(
              future: get_mod_list(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data[0].contains(input_controller.text)) {
                    var data_=snapshot.data[1][input_controller.text];
                    if (data_==null){
                      data_=0;
                    }
                    return Text("This mod is inclued in RPMTW, translated "+data_.toString()+"% of it.");
                  } else if(input_controller.text.isNotEmpty) {
                    return Text(
                        "This mod is not inclued in RPMTW, but you can change that!");
                  }else{
                    return Text(
                        "Please type in mod name");
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
                Text("Update ever 30 minutes")
          ])),
        ));
  }
}
