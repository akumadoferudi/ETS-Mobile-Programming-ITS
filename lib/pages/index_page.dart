import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ets/model/student.dart';
import 'package:ets/db/database_instance.dart';
import 'package:ets/Widget/student_card_widget.dart';
import 'package:ets/Widget/student_form_widget.dart';
import 'package:ets/pages/detail_student_page.dart';
import 'package:ets/pages/add_edit_student_page.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {

  late List<Student> students;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    refreshStudents();
  }

  @override
  void dispose() {
    DatabaseInstance.instance.close();

    super.dispose();
  }

  Future refreshStudents() async {
    setState(() => isLoading = true);

    students = await DatabaseInstance.instance.getAllStudents();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Bio List'),
      ),
      body: Padding(
        padding: EdgeInsets.all(2.0),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : students.isEmpty
              ? Text(
              'No Student'
          ) : buildStudent(),
        ),
      ),
    );
  }

  Widget buildStudent() => StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 2,
      crossAxisSpacing: 2,
      children: List.generate(
        students.length,
            (index) {
          final student = students[index];

          return StaggeredGridTile.fit(
            crossAxisCellCount: 1,
            child: GestureDetector(
              onTap: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailStudentPage(studentId: student.id!),
                ));

                refreshStudents();
              },
              child: StudentCardWidget(student: student, index: index),
            ),
          );
        },
      ));
}
