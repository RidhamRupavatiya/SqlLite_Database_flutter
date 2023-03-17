import 'package:crud_operation/DataBase/add_edit_db.dart';
import 'package:crud_operation/DataBase/my_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DataBaseCall extends StatefulWidget {
  const DataBaseCall({Key? key}) : super(key: key);

  @override
  State<DataBaseCall> createState() => _DataBaseCallState();
}

class _DataBaseCallState extends State<DataBaseCall> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MyDataBase().copyPasteAssetFileToRoot();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Database"),actions: [TextButton(onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return AddEditDb(map: null,);
        },)).then((value) {
          setState(() {
          });
        },);
      }, child: Icon(Icons.add,color: Colors.white,))],),
      body: FutureBuilder(builder: (context, snapshot1) {
        if(snapshot1.hasData){
          return  FutureBuilder<List<Map<String, Object?>>>(
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  return ListView.builder(itemBuilder: (context, index) {
                    return Card(
                      elevation: 9,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text((snapshot.data![index]["Name"]).toString(),style: TextStyle(fontSize: 16),),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text((snapshot.data![index]["CityName"]).toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text((snapshot.data![index]["Dob"]).toString()),
                              ),
                            ],
                          ),
                          Expanded(child: Container()),
                          Column(children: [
                            TextButton(onPressed: () {
                              deleteUser((snapshot.data![index]["UserId"]).toString()).then((value) {
                                setState(() {
                                });
                              },);
                            }, child: Icon(Icons.delete,color: Colors.red,)),
                            TextButton(onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                return AddEditDb(map: snapshot.data![index],);
                              },)).then((value) {
                                setState(() {
                                });
                              },);
                            }, child: Icon(Icons.edit)),
                          ],),
                        ],
                      ),
                    );
                  },itemCount: snapshot.data!.length,);
                }
                else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },
              future: MyDataBase().getUserListFromTable());
        }
        else {
          return Center(child: CircularProgressIndicator(),);
        }
      },future: MyDataBase().copyPasteAssetFileToRoot(),),
    );
  }
  Future<int> deleteUser(id) async {
    int UserId = await MyDataBase().deleteUser(id);
    return UserId;
  }
}
