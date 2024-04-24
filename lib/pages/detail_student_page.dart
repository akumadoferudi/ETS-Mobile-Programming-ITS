import 'package:flutter/material.dart';
import 'package:ets/db/database_instance.dart';
import 'package:ets/model/student.dart';
import 'package:ets/pages/add_edit_student_page.dart';
import 'package:intl/intl.dart';

class DetailStudentPage extends StatefulWidget {
  final int studentId;

  const DetailStudentPage({
    super.key,
    required this.studentId
  });

  @override
  State<DetailStudentPage> createState() => _DetailStudentPageState();
}

class _DetailStudentPageState extends State<DetailStudentPage> {
  late Student student;
  bool isLoading = false;


  @override
  void initState() {
    super.initState();

    refreshStudents();
  }

  Future refreshStudents() async {
    setState(() => isLoading = true);

    student = await DatabaseInstance.instance.readNote(widget.studentId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [editButton(), deleteButton()],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(12),
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            Image(image: AssetImage('assets/images/${student.photo}')),
            Text(
              student.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat.yMMMd().format(student.createdTime),
              style: const TextStyle(color: Colors.white38),
            ),
            const SizedBox(height: 8),
            Text(
              student.major,
              style:
              const TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              '${student.generation}',
              style:
              const TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  Widget editButton() => IconButton(
      icon: const Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditStudentPage(student: student),
        ));

        refreshStudents();
      });

  Widget deleteButton() => IconButton(
    icon: const Icon(Icons.delete),
    onPressed: () async {
      await DatabaseInstance.instance.delete(widget.studentId);

      Navigator.of(context).pop();
    },
  );
}
