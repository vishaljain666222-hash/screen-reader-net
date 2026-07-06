import '../models/models.dart';
import 'courses/word_course.dart';
import 'courses/excel_course.dart';
import 'courses/powerpoint_course.dart';
import 'courses/chrome_course.dart';

/// All course content lives in lib/data/courses/*.dart — one file per
/// course, each exporting a single `Course` constant. This file just
/// gathers them into one list for the rest of the app to use.
class ContentData {
  static final List<Course> courses = [
    wordCourse,
    excelCourse,
    powerPointCourse,
    chromeCourse,
  ];
}
