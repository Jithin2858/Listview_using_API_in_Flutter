import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> users = [];
  Future<List<User>> _getUsers() async {
    late List<User> list;
    String url ="https://reqres.in/api/users?page=2";
    //String url =("http://www.json-generator.com/api/json/get/cfwZmvEBbC?indent=2");
    var data =await http.get(Uri.parse(url));
    //var url = Uri.parse("http://www.json-generator.com/api/json/get/cfwZmvEBbC?indent=2");
   // print(data.body);
    //var data = await http.get(url);
   // print('Data before decoding ---->${data}');
    var jsonData = json.decode(data.body);
    var jsonDataData = jsonData['data'];
    print('---->${jsonData['data']}');
    print('hello');
   /* if (jsonData.statusCode == 200) {
      final json = "[" + jsonData.body + "]";
      List users = (jsonDecode(json) as List<dynamic>);
    }*/
    //List<User>? rest=[];
   // Iterable l = json.decode(data.body);
   // List<User> posts = List<User>.from(l.map((model)=> User.fromJson(model)));
    /*if (jsonData.statusCode == 200) {
          rest = jsonData[data]    as List;
      print(rest);
     // list = rest.map<User>((json) => User.fromJson(json)).toList();
    }*/
    //print("List Size: ${list.length}");
   // return list;
  //  return rest;
  //}

   //List user= (jsonData as List).map((e) => User.fromJson(e)).toList();

     for(var u in jsonDataData){
       print(u);
       print('im inside the loop');
       User user = User(u["id"], u["email"], u["first_name"], u["avatar"]);
      users.add(user);

     }
    //print('hello');
    //print('user length is ${users.length}');

    return users;

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            print(_getUsers());
            if(snapshot.data == null){
              return Container(
                  child: Center(
                      child: Text("Loading...")
                  )
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          snapshot.data[index].avatar
                      ),
                    ),
                    title: Text(snapshot.data[index].first_name),
                    subtitle: Text(snapshot.data[index].email),
                    onTap: (){

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                      );

                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {

  final User user;

  DetailPage(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(user.first_name),
        )
    );
  }
}


class User {
  final int id;
  final String first_name;
  final String email;
  final String avatar;

  User(this.id, this.first_name, this.email, this.avatar);


  /*static fromJson(json): User {
  User p = User(json['id'], json['about'], json['first_name'], json['email'], json['avatar']);

  return p;*/

}
//Give accordingly!
  /*factory fromJson(json) :  User {
User p = User(json['id'] as , json['about'] as, json['first_name'], json['email'], json['avatar']);

return p;
  }
}*/
