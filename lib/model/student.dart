final String tableStudents = 'students';

class StudentFields {
  static final String id = '_id';
  static final String photo = 'photo';
  static final String name = 'name';
  static final String major = 'major';
  static final String generation = 'generation';
  static final String time = 'time';

  static final List<String> values = [
    //   add all fields
    id, photo, name, major, generation, time,
  ];
}

class Student {
  final int? id;
  final String photo;
  final String name;
  final String major;
  final int generation;
  final DateTime createdTime;

  Student({
    this.id,
    required this.photo,
    required this.name,
    required this.major,
    required this.generation,
    required this.createdTime,
  });

  Student copy({
    int? id,
    String? photo,
    String? name,
    String? major,
    int? generation,
    DateTime? createdTime,
  }) => Student(
    id: id ?? this.id,
    photo: photo ?? this.photo,
    name: name ?? this.name,
    major: major ?? this.major,
    generation: generation ?? this.generation,
    createdTime: createdTime ?? this.createdTime,
  );

  static Student fromJson(Map<String, Object?> json) => Student(
    id: json[StudentFields.id] as int?,
    photo: json[StudentFields.photo] as String,
    name: json[StudentFields.name] as String,
    major: json[StudentFields.major] as String,
    generation: json[StudentFields.generation] as int,
    createdTime: DateTime.parse(json[StudentFields.time] as String),
  );

  Map<String, Object?> toJson() { // used when inserting data to the database
    return <String, Object?> {
      StudentFields.id : id,
      StudentFields.photo : photo,
      StudentFields.name : name,
      StudentFields.major : major,
      StudentFields.generation : generation,
      StudentFields.time : createdTime.toIso8601String(),
    };
  }
}