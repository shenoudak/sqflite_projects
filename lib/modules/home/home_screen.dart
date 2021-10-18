import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytest_app/layout/archived_task/archived_screen.dart';
import 'package:mytest_app/layout/task/task_screen.dart';
import 'package:mytest_app/layout/task_done/done_screen.dart';
import 'package:mytest_app/shared/components/shared_components.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget
{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int curIndex=0;
  IconData fabIcon=Icons.edit;
  bool buttomSheetIsShowwn=false;
  var database;
  var scaffoldKey=GlobalKey<ScaffoldState>();
  var formKey=GlobalKey<FormState>();
  var titleTaskController=TextEditingController();
  var timeTaskController=TextEditingController();
  var dateTaskController=TextEditingController();
  //Future<dynamic>action=null;;

  List listScreen=
  [
    NewTaskScreen(),
    DoneTaskScreen(),
    ArchivedTaskScreen(),
  ];
  List titleScreen=
  [
    'New Task Screen',
    'Done Task Screen',
    'Archived Task Screen',
  ];
  @override
  void initState(){
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('${titleScreen[curIndex]}'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(fabIcon),
        onPressed: (){
          if(buttomSheetIsShowwn==false)
          {
            setState(() {
              fabIcon=Icons.add;
            });
            buttomSheetIsShowwn=true;
            scaffoldKey.currentState!.showBottomSheet((context){
              return Container(
                color: Colors.grey[200],
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        defaultTextFormFaield(
                          label: 'Enter Your Task Title',
                          controller: titleTaskController,
                          perfix_icon: Icons.person_add_alt_1_outlined,
                          returnIsValidator: 'Enter Task Title ,Please',
                        ),
                        defaultTextFormFaield(
                          isTap: (){
                            showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now()).then((value)
                            {
                              timeTaskController.text=value!.format(context);
                            });
                          },
                          label: 'Enter Task Time',
                          controller: timeTaskController,
                          perfix_icon: Icons.watch,
                          returnIsValidator: 'Enter Task Time ,Please',

                        ),
                        defaultTextFormFaield(
                          isTap:()
                          {
                                showDatePicker(
                                context: context,
                                initialDate:DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(2030)).then((value){
                                  dateTaskController.text=DateFormat.yMMMd().format(value!);
                                });
                          },
                          label: 'Enter Task Date',
                          controller: dateTaskController,
                          perfix_icon: Icons.calculate_outlined,
                          returnIsValidator: 'Enter Task Date ,Please',
                        ),
                      ],
                    ),
                  ),
                ),
              );

            }).closed.then((value) {
              setState(() {
                fabIcon = Icons.edit;
              });
              buttomSheetIsShowwn = false;
            });
          }
          else{
            if(formKey.currentState!.validate()) {
              insertIntoDatabase(
                  title: titleTaskController.text,
                  time: timeTaskController.text,
                  date: dateTaskController.text).then((value) {
                Navigator.pop(context);
                setState(() {
                  fabIcon = Icons.edit;
                });
                buttomSheetIsShowwn = false;
              });
            }
          }

          //insertIntoDatabase();
        },

      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            curIndex=index;
          });
        },
        elevation: 0.0,
        currentIndex: curIndex,
        fixedColor: Colors.orangeAccent,
        items:const [
          BottomNavigationBarItem(
              icon: Icon(Icons.task_alt_outlined),
            label:'Task',
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.done),
              label: 'Done Task',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined),
            label: 'Archived',
          ),

        ],
      ),
      body:listScreen[curIndex],

    );
  }
  void createDatabase()async
  {
      database= await openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database,version){
        print('database created');
        database.execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,time TEXT,date TEXT,status TEXT)'
                ).then((value)
              {
                print('Table Created Succesfully');
              }).catchError((error)
              {
          print('ERROR WHEN CREATED TABLE ${error.toString()}');
              });

      },
      onOpen:(database){
        print('Database Openned');
      } ,
    );
  }
  Future insertIntoDatabase({ @required String? title,@required String? time,@required String? date})async
  {
       return await database.transaction((txn)async {
      int rawNumber= await txn.rawInsert(
          'INSERT INTO tasks(title,time,date,status)VALUES("${title}" ,"${time}" ,"${date}", "new")'
      );
      print('$rawNumber inserted');
       return null;
    });
  }
  void getDataFromDatabase()
  {

  }

}
