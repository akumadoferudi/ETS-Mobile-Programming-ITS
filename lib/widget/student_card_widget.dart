import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ets/model/student.dart';

class StudentCardWidget extends StatelessWidget {
  const StudentCardWidget({
    Key? key,
    required this.student,
    required this.index,
  }) : super(key: key);

  final Student student;
  final int index;

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMd().format(student.createdTime);
    final minHeight = getMinHeight(index);

    return Card(
      color: Colors.amber.shade300,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                time,
                style: TextStyle(color: Colors.grey.shade700),
              ),
              const SizedBox(height: 4),
              // student photo
              Center(child: Image(image: AssetImage('assets/images/${student.photo}'))),
              const SizedBox(height: 6),
              // student name
              Text(
                student.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
            ]
        ),
      ),
    );
  }


  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
  }
}
