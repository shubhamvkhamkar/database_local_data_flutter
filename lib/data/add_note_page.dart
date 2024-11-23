

import 'package:flutter/material.dart';

import 'local/db_helper.dart';
import 'package:flutter/material.dart';


class AddNotePage extends StatelessWidget{

  bool isUpdate;
  String title;
  String desc;
  int sno;
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController DescEditingController = TextEditingController();
  DbHelper? dbRef = DbHelper.getInstance;

  AddNotePage({this.isUpdate = false, this.sno= 0, this.title= "", this.desc= ""});
  @override
  Widget build(BuildContext context) {

    if(isUpdate){
      titleEditingController.text = title;
      DescEditingController.text = desc;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(isUpdate ? 'Update Note' : 'Add Note ',),
      ),
      body: Container(

        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          children: [
            /*Text(
              isUpdate ? 'Update Note' : 'Add Note ',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),*/
            SizedBox(
              height: 21,
            ),
            TextField(
                controller: titleEditingController,
                decoration: InputDecoration(
                    hintText: ('Enetr Title here'),
                    label: Text('Add Title*'),
                    prefixIcon: Icon(
                      Icons.title_sharp,
                      color: Colors.blue,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21)))),
            SizedBox(
              height: 11,
            ),
            TextField(
                controller: DescEditingController,
                maxLines: 4,
                decoration: InputDecoration(
                    hintText: ('Add Description'),
                    label: Text('Description*'),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21)))),
            SizedBox(
              height: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11),
                                side: BorderSide(width: 1, color: Colors.black))),
                        onPressed: () async {
                          var title = titleEditingController.text;
                          var Desc = DescEditingController.text;
                          if (title.isNotEmpty && Desc.isNotEmpty) {
                            bool check = isUpdate
                                ? await dbRef!.updateNote(
                                title: title, desc: Desc, sno: sno)
                                : await dbRef!
                                .addNote(mTitle: title, mDesc: Desc);
                            if (check) {
                              Navigator.pop(context);
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                Text('Please fill all mandatory fiiled')));
                          }
                          titleEditingController.clear();
                          DescEditingController.clear();

                        },
                        child: Text(isUpdate ? 'Update Note' : 'Add Note'))),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11),
                                side: BorderSide(width: 1, color: Colors.black))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('cancel'))),
              ],
            )
          ],
        ),
      )
    );
  }

}