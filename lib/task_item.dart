import 'package:flutter/material.dart';
import 'package:ieee_week14_todo/task_model.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;

  const TaskItem({
    super.key,
    required this.task,
  });

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Transform.scale(
            scale: 2.2,
            child: Checkbox(
              side: const BorderSide(
                width: .8,
                color: Colors.grey,
              ),
              value: widget.task.isSelected,
              onChanged: (value) {
                widget.task.isSelected = !widget.task.isSelected;
                setState(() {});
              },

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              widget.task.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
