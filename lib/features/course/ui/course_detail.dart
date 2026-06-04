import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/network/api_endpoints.dart';
import 'package:flutter_application_1/features/appbar/ui/custom_appbar.dart';
import 'package:flutter_application_1/features/course/data/course_model.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseDetail extends StatefulWidget {
  final String courseUrl;
  const CourseDetail({required this.courseUrl, super.key});
  @override
  State<CourseDetail> createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail> {
  late Future<Course> _course;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _course = _fetchCourse();
  }

  Future<Course> _fetchCourse() async {
    final response = await getCourse({
      "url": widget.courseUrl,
      "resolveTeacher": 1,
      "resolveCategory": 1,
    });
    return Course.fromJson(response['data'][0]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'course detail'),
      body: FutureBuilder(
        future: _course,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          final course = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // ... rest of your detail UI
              ],
            ),
          );
        },
      ),
    );
  }
}
