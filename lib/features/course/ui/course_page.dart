import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/features/appbar/ui/custom_appbar.dart';
import 'package:flutter_application_1/features/course/data/course_model.dart';
import 'package:flutter_application_1/features/course/ui/course_card.dart';
import 'package:flutter_application_1/features/course/ui/course_detail.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _CoursePageState();
  }
}

class _CoursePageState extends State<CoursePage> {
  late Future<List<Course>> _courses;
  @override
  void initState() {
    super.initState();
    _courses = _fetchCourses();
  }

  Future<List<Course>> _fetchCourses() async {
    final response = await getCourse({
      "resolveTeacher": 1,
      "resolveCategory": 1,
    });
    final list = response['data'] as List;
    return list.map((e) => Course.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Courses"),
      body: FutureBuilder<List<Course>>(
        future: _courses,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final courses = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.85,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) => CourseCard(
              course: courses[index],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CourseDetail(courseUrl: courses[index].url),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
