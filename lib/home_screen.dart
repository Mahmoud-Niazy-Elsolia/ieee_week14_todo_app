import 'package:flutter/material.dart';
import 'package:ieee_week14_todo/bottom_sheet_content.dart';
import 'package:ieee_week14_todo/sqflite_db.dart';
import 'package:ieee_week14_todo/task_item.dart';
import 'package:ieee_week14_todo/task_model.dart';
import 'package:jiffy/jiffy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SqfliteDb sqfliteDb = SqfliteDb();

  @override
  Widget build(BuildContext context) {
    var date = Jiffy.now().yMMMMEEEEdjm.split(', ');
    var day = date[0];
    var month = date[1].split(' ')[0];
    var dayNum = date[1].split(' ')[1];
    var year = date[2].split(' ')[0];

    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Tasker',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(
        children: [
          Container(
            // alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            color: Colors.blue,
            height: MediaQuery.of(context).size.height * 0.16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      dayNum,
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          month,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          year,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  day,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FutureBuilder(
            future: sqfliteDb.getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return TaskItem(
                          task: TaskModel(title: snapshot.data![index]['title']));
                    },
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10
                      ),
                      child: Container(
                        height: .1,
                        color: Colors.grey,
                      ),
                    ),
                    itemCount: snapshot.data!.length,
                  ),
                );
              } else if (snapshot.hasError) {
                return const Text('ERROR');
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: const BottomSheetContent(),
    );
  }
}
