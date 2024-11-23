import 'package:database_local/data/add_note_page.dart';
import 'package:database_local/data/db_provider.dart';
import 'package:database_local/data/local/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //List<Map<String, dynamic>> allNotes = [];
  //DbHelper? dbRef;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<DbProvider>().getIntitialNotes();
   /* dbRef = DbHelper.getInstance;
    getNotes();*/
  }

  /*void getNotes() async {
    allNotes = await dbRef!.getAllNote();
    setState(() {});
  }*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Consumer(
        builder: (ctx, provider, __){
          List<Map<String, dynamic>> allNotes = provider.ge
          return allNotes.isNotEmpty
              ? ListView.builder(
            itemCount: allNotes.length,
            itemBuilder: (_, index) {
              return ListTile(
                tileColor: Colors.yellow,
                leading: Text(
                    allNotes[index][DbHelper.COLUMN_NOTE_SNO].toString()),
                title: Text(allNotes[index][DbHelper.COLUMN_NOTE_TITEL]),
                subtitle: Text(allNotes[index][DbHelper.COLUMN_NOTE_DESC]),
                trailing: SizedBox(
                  width: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                          onTap: () {

                            Navigator.push(context, MaterialPageRoute(builder:(context) =>  AddNotePage(
                              isUpdate: true,
                              title: allNotes[index]
                              [DbHelper.COLUMN_NOTE_TITEL] ,

                              desc: allNotes[index]
                              [DbHelper.COLUMN_NOTE_DESC],
                              sno: allNotes[index]
                              [DbHelper.COLUMN_NOTE_SNO],
                            )
                            ));

                            /*showModalBottomSheet(
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (context) {
                                    titleEditingController.text =
                                        allNotes[index]
                                            [DbHelper.COLUMN_NOTE_TITEL];
                                    DescEditingController.text = allNotes[index]
                                        [DbHelper.COLUMN_NOTE_DESC];
                                    return getBottomSheetWidget(
                                        isUpdate: true,
                                        sno: allNotes[index]
                                            [DbHelper.COLUMN_NOTE_SNO]);
                                  });*/
                          },
                          child: Icon(
                            Icons.edit,
                            color: Colors.green,
                          )),
                      InkWell(
                        onTap: () async {
                          bool check =  await dbRef!.deleteNote(sno: allNotes[index][DbHelper.COLUMN_NOTE_SNO]);
                          if(check){
                            getNotes();
                          }
                        },
                        child: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          )
              : Center(
            child: Text('No Notes yet!!'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(),));
          /*showModalBottomSheet(
            isScrollControlled: true,
              context: context,
              builder: (context) {
                titleEditingController.clear();
                DescEditingController.clear();
                return getBottomSheetWidget();
              });*/
          /*bool check = await dbRef!.addNote(mTitle: "Personal Note", mDesc: "Hello every loved one ");
             getNotes();*/
        },
        child: Icon(Icons.add),
      ),
    );
  }

/*  Widget getBottomSheetWidget({bool isUpdate = false, int sno = 0}) {
    return *//*Container(

      padding: EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        children: [
          Text(
            isUpdate ? 'Update Note' : 'Add Note ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
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
                            getNotes();
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Please fill all mandatory fiiled')));
                        }
                        titleEditingController.clear();
                        DescEditingController.clear();
                        Navigator.pop(context);
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
    );*//*
  }*/
}
