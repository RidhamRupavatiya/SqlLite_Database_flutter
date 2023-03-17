import 'package:crud_operation/DataBase/my_database.dart';
import 'package:flutter/material.dart';

class AddEditDb extends StatefulWidget {
  AddEditDb({super.key,this.map});
  Map? map;

  // const AddEditDb({Key? key}) : super(key: key);

  @override
  State<AddEditDb> createState() => _AddEditDbState();
}

class _AddEditDbState extends State<AddEditDb> {
  var formKey = GlobalKey<FormState>();

  var namecontroller = TextEditingController();

  var citycontroller = TextEditingController();

  var dobcontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller.text = widget.map==null?"":widget.map!["Name"];
    citycontroller.text = widget.map==null?"":widget.map!["CityName"];
    dobcontroller.text = widget.map==null?"":widget.map!["Dob"];
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:Padding(
        padding: const EdgeInsets.only(top: 8.0,),
        child: Form(
          key: formKey,
          child: Card(
            child: Container(
              height: 250,
              child: Column(
                children: [
                  TextFormField(decoration: InputDecoration(hintText: "Enter Name"),controller: namecontroller,validator: (value) {
                    if(value==null && value!.isEmpty){
                      return "Enter Valid Name";
                    }
                  },),
                  TextFormField(decoration: InputDecoration(hintText: "Enter City"),controller: citycontroller,validator: (value) {
                    if(value==null && value!.isEmpty){
                      return "Enter Valid City";
                    }
                  },),
                  TextFormField(decoration: InputDecoration(hintText: "Enter Dob"),controller: dobcontroller,validator: (value) {
                    if(value==null && value!.isEmpty){
                      return "Enter Valid Dob";
                    }
                  },),
                  TextButton(onPressed: () {
                    if(formKey.currentState!.validate()){
                      if(widget.map==null){
                        insertUser().then((value) => Navigator.of(context).pop(true));
                      }
                      else{
                        upadteUser(widget.map!["UserId"]).then((value) => Navigator.of(context).pop(true));
                      }
                    }
                  }, child: Text("Submit")),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<int> insertUser() async {
    Map<String,dynamic> map = {};
    map["Name"] = namecontroller.text;
    map["CityName"] = citycontroller.text;
    map["Dob"] = dobcontroller.text;
    int UserId = await MyDataBase().InsertUser(map);
    return UserId;
  }
  Future<int> upadteUser(id) async {
    Map<String,dynamic> map = {};
    map["Name"] = namecontroller.text;
    map["CityName"] = citycontroller.text;
    map["Dob"] = dobcontroller.text;
    int UserId = await MyDataBase().UpdatetUser(map,id);
    return UserId;
  }
}
