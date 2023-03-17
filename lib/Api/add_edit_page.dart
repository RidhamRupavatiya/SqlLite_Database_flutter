import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddEditPage extends StatefulWidget {

  Map? map;

  AddEditPage({super.key, this.map});

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  var formKey = GlobalKey<FormState>();

  var namecontroller = TextEditingController();

  var rollnocontroller = TextEditingController();

  var citycontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    namecontroller.text = widget.map==null?"":widget.map!["name"];
    rollnocontroller.text = widget.map==null?"":widget.map!["roll_no"];
    citycontroller.text = widget.map==null?"":widget.map!["city"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Card(
          child: Column(
            children: [
              TextFormField(decoration: InputDecoration(hintText: "Enter Name"),controller: namecontroller,validator: (value) {
                if(value==null && value!.isEmpty){
                  return "Enter Valid Name";
                }
              },),
              TextFormField(decoration: InputDecoration(hintText: "Enter RollNo"),controller: rollnocontroller,validator: (value) {
                if(value==null && value!.isEmpty){
                  return "Enter Valid RollNo";
                }
              },),
              TextFormField(decoration: InputDecoration(hintText: "Enter City"),controller: citycontroller,validator: (value) {
                if(value==null && value!.isEmpty){
                  return "Enter Valid City";
                }
              },),
              TextButton(onPressed: () {
                if(formKey.currentState!.validate()){
                  if(widget.map==null){
                    InsertUser().then((value) => Navigator.of(context).pop(true));
                  }else{
                    EditUser(widget.map!['id']).then((value) => Navigator.of(context).pop(true));
                    print("Update");
                  }
                }
              }, child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> InsertUser() async {
    Map map = {};
    map["name"] = namecontroller.text;
    map["roll_no"] = rollnocontroller.text;
    map["city"] = citycontroller.text;
    var res1 = await http.post(Uri.parse('https://63ef2b5d4d5eb64db0c4414a.mockapi.io/student'),body: map);
    print(res1.body);
    return res1;
  }
  Future<dynamic> EditUser(id) async {
    Map map = {};
    map["name"] = namecontroller.text;
    map["roll_no"] = rollnocontroller.text;
    map["city"] = citycontroller.text;
    var res2 = await http.put(Uri.parse('https://63ef2b5d4d5eb64db0c4414a.mockapi.io/student/$id'),body: map);
    print(res2.body);
    return res2;
  }
}
