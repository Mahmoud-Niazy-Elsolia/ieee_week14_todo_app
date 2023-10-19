import 'package:flutter/material.dart';
import 'package:ieee_week14_todo/home_screen.dart';
import 'package:ieee_week14_todo/sqflite_db.dart';
import 'package:jiffy/jiffy.dart';
import 'components/form_field.dart';
import 'components/icon_button.dart';
import 'components/text_button.dart';

class BottomSheetContent extends StatefulWidget {
  const BottomSheetContent({super.key});

  @override
  State<BottomSheetContent> createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    var taskController = TextEditingController();
    var dateController = TextEditingController();
    SqfliteDb database = SqfliteDb();
    var formKey = GlobalKey<FormState>();

    Future<void> selectDate(BuildContext context) async {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2023, 10),
              lastDate: DateTime(2025))
          .then((value) {
        if (value != null) {
          dateController.text = Jiffy.parse(value.toString()).yMMMd;
        }
      });
    }

    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomFormField(
                        label: 'Task',
                        controller: taskController,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Task Date is empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomFormField(
                        label: 'No date',
                        controller: dateController,
                        validator: (value){
                          if(value!.isEmpty){
                            return 'Task title is empty';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomIconButton(
                            onPressed: () async {
                              await selectDate(context);
                            },
                            icon: Icons.calendar_month,
                            color: Colors.blue,
                          ),
                          Row(
                            children: [
                              CustomTextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                text: 'Cancel',
                                color: Colors.grey,
                              ),
                              CustomTextButton(
                                onPressed: () async {
                                 if(formKey.currentState!.validate()){
                                   await database.insertData(
                                       title: taskController.text,
                                       date: dateController.text);
                                   Navigator.of(context).pushAndRemoveUntil(
                                     MaterialPageRoute(
                                       builder: (context) => const HomeScreen(),
                                     ),
                                         (route) => false,
                                   );
                                 }
                                },
                                text: 'Save',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
