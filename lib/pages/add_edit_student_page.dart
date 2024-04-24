import 'package:flutter/material.dart';
import 'package:ets/db/database_instance.dart';
import 'package:ets/model/student.dart';
import 'package:ets/widget/student_form_widget.dart';


class AddEditStudentPage extends StatefulWidget {
  final Student? student;

  const AddEditStudentPage({
    super.key,
    this.student,
  });

  @override
  State<AddEditStudentPage> createState() => _AddEditStudentPageState();
}

class _AddEditStudentPageState extends State<AddEditStudentPage> {
  final _formKey = GlobalKey<FormState>();
  late String photo;
  late String name;
  late String major;
  late int generation;
  @override
  void initState() {
    super.initState();

    photo = widget.student?.photo ?? 'No Photo';
    name = widget.student?.name ?? 'No Name';
    major = widget.student?.major ?? 'No Major';
    generation = widget.student?.generation ?? 2020;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [buildButton()],
      ),
      body: Form(
        key: _formKey,
        child: StudentFormWidget(
          isImportant: isImportant,
          number: number,
          title: title,
          description: description,
          onChangedImportant: (isImportant) =>
              setState(() => this.isImportant = isImportant),
          onChangedNumber: (number) => setState(() => this.number = number),
          onChangedTitle: (title) => setState(() => this.title = title),
          onChangedDescription: (description) =>
              setState(() => this.description = description),
        ),
      ),
    );
  }
}
