import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'add_edit_page.dart';

class DataDisplay extends StatefulWidget {
  DataDisplay({Key? key}) : super(key: key);

  @override
  State<DataDisplay> createState() => _DataDisplayState();
}

class _DataDisplayState extends State<DataDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Data',
        ),
        backgroundColor: Colors.lightBlueAccent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return AddEditPage(
                      map: null,
                    );
                  },
                )).then((value) {
                  if (value == true) {
                    setState(() {});
                  }
                });
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<http.Response>(
          builder: (context, snapshot) {
            dynamic jsondata = jsonDecode(snapshot.data!.body.toString());
            if (snapshot.hasData) {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 9,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('name : ${jsondata[index]["name"]}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text('Roll No: ${jsondata[index]["roll_no"]}',
                                  style: TextStyle(fontSize: 16)),
                              Text('City : ${jsondata[index]["city"]}',
                                  style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          Expanded(child: Container()),
                          Column(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      //print(shopingApi[index]);
                                      return AddEditPage(map: jsondata[index]);
                                    },),).then((value) {
                                      setState(() {

                                      });
                                    },);
                                  }, child: Icon(Icons.edit)),
                              TextButton(
                                  onPressed: () {
                                    showDeleteAlert(jsondata[index]["id"]);
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: jsondata.length);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
          future: getDataFromApi()),
    );
  }

  Future<http.Response> getDataFromApi() async {
    http.Response res = await http
        .get(Uri.parse("https://63ef2b5d4d5eb64db0c4414a.mockapi.io/student"));
    return res;
  }

  Future<dynamic> deleteById(id) async {
    final response2 = await http.delete(
        Uri.parse("https://63ef2b5d4d5eb64db0c4414a.mockapi.io/student/$id"));
    return response2;
  }

  // showDeleteAlertBox
  void showDeleteAlert(id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Are you sure"),
          content: Text("it will be delete parmanetaly"),
          actions: [
            TextButton(
                onPressed: () {
                  deleteById(id).then((value) {
                    setState(() {
                    });
                  },);
                  Navigator.of(context).pop();
                },
                child: Text("yes")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("no")),
          ],
        );
      },
    );
  }
}
