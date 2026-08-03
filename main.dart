import 'dart:io';

List<Map<String, dynamic>> students = [];

void main() {
  bool running = true;

  do {
    print("==================================");
    print("    STUDENT INFORMATION SYSTEM   ");
    print("==================================");
    print("0 : Search Student");
    print("1 : Add Student");
    print("2 : View Student List");
    print("3 : Update Student Info");
    print("4 : Delete Student Info");
    print("5 : Compute Class Average");
    print("6 : Display Student with Highest Grade");
    print("7 : Display Student with Lowest Grade");
    print("8 : Exit");
    print("==================================");

    stdout.write("Enter your choice: ");
    String? choice = stdin.readLineSync();
    print("Choice: $choice");

    switch (choice) {
      case "0":
        searchStudent();
        break;
      case "1":
        addStudent();
        break;
      case "2":
        viewStudents();
        break;
      case "3":
        updateStudent();
        break;
      case "4":
        deleteStudent();
        break;
      case "5":
        computeAverage();
        break;
      case "6":
        displayHighestGrade();
        break;
      case "7":
        displayLowestGrade();
        break;
      case "8":
        print("Exiting program...");
        running = false;
        break;
      default:
        print("Invalid Input!");
    }

    print("\n");
  } while (running);
}

String computeStatus(double gwa) {
  if (gwa <= 1.75) return "Excellent";
  else if (gwa <= 2.75) return "Very Good";
  else if (gwa == 3.0) return "Passed";
  else if (gwa == 5.0) return "Probation";
  else return "Invalid Input";
}

void addStudent() {
  stdout.write("Enter your name: ");
  String? name = stdin.readLineSync();

  stdout.write("Enter your age: ");
  int? age = int.tryParse(stdin.readLineSync()!) ?? 0;

  stdout.write("Enter your course: ");
  String? course = stdin.readLineSync();

  stdout.write("Enter your GWA: ");
  double? gwa = double.tryParse(stdin.readLineSync()!) ?? 0.0;

  String status = computeStatus(gwa);

  print("====Student Information System====");
  print("Name: $name");
  print("Age: $age");
  print("Course: $course");
  print("GWA: $gwa");
  print("Status: $status");
  print("==================================");

  students.add({
    "Name": name,
    "Age": age,
    "Course": course,
    "GWA": gwa,
    "Status": status
  });
  print("Added successfully!");
}

void viewStudents() {
  if (students.isEmpty) {
    print("No students found.");
    return;
  }

  int i = 0;
  do {
    final student = students[i];
    print("Student ${i + 1}:");
    print("  Name  : ${student['Name']}");
    print("  Age   : ${student['Age']}");
    print("  Course: ${student['Course']}");
    print("  GWA   : ${student['GWA']}");
    print("  Status: ${student['Status']}");
    print("---------------------");
    i++;
  } while (i < students.length);
}

void searchStudent() {
  if (students.isEmpty) {
    print("No students to search.");
    return;
  }

  stdout.write("Enter the name (or partial name) to search: ");
  String? searchTerm = stdin.readLineSync()?.trim();

  if (searchTerm == null || searchTerm.isEmpty) {
    print("Invalid search term.");
    return;
  }

  List<Map<String, dynamic>> results = [];
  String lowerSearch = searchTerm.toLowerCase();

  for (var student in students) {
    String storedName = student["Name"]?.toLowerCase() ?? "";
    if (storedName.contains(lowerSearch)) {
      results.add(student);
    }
  }

  if (results.isEmpty) {
    print("No students found matching '$searchTerm'.");
    return;
  }

  print("==================================");
  print("Search Results (${results.length} found):");
  print("==================================");

  int i = 0;
  do {
    var student = results[i];
    print("Student ${i + 1}:");
    print("  Name  : ${student['Name']}");
    print("  Age   : ${student['Age']}");
    print("  Course: ${student['Course']}");
    print("  GWA   : ${student['GWA']}");
    print("  Status: ${student['Status']}");
    print("---------------------");
    i++;
  } while (i < results.length);
}

void updateStudent() {
  if (students.isEmpty) {
    print("No students to update.");
    return;
  }

  stdout.write("Enter the name of the student to update: ");
  String? searchName = stdin.readLineSync()?.trim();

  if (searchName == null || searchName.isEmpty) {
    print("Invalid name.");
    return;
  }

  int index = -1;
  for (int i = 0; i < students.length; i++) {
    String storedName = students[i]["Name"]?.toLowerCase() ?? "";
    if (storedName == searchName.toLowerCase()) {
      index = i;
      break;
    }
  }

  if (index == -1) {
    print("Student not found.");
    return;
  }

  Map<String, dynamic> student = students[index];

  print("Current info:");
  print("  Name  : ${student['Name']}");
  print("  Age   : ${student['Age']}");
  print("  Course: ${student['Course']}");
  print("  GWA   : ${student['GWA']}");
  print("  Status: ${student['Status']}");
  print("----------------------------");

  stdout.write("Enter new name (or press Enter to keep): ");
  String? newName = stdin.readLineSync()?.trim();
  if (newName != null && newName.isNotEmpty) {
    student['Name'] = newName;
  }

  stdout.write("Enter new age (or press Enter to keep): ");
  String? ageInput = stdin.readLineSync()?.trim();
  if (ageInput != null && ageInput.isNotEmpty) {
    int? newAge = int.tryParse(ageInput);
    if (newAge != null) {
      student['Age'] = newAge;
    } else {
      print("Invalid age, keeping old value.");
    }
  }

  stdout.write("Enter new course (or press Enter to keep): ");
  String? newCourse = stdin.readLineSync()?.trim();
  if (newCourse != null && newCourse.isNotEmpty) {
    student['Course'] = newCourse;
  }

  stdout.write("Enter new GWA (or press Enter to keep): ");
  String? gwaInput = stdin.readLineSync()?.trim();
  if (gwaInput != null && gwaInput.isNotEmpty) {
    double? newGwa = double.tryParse(gwaInput);
    if (newGwa != null) {
      student['GWA'] = newGwa;
      student['Status'] = computeStatus(newGwa);
    } else {
      print("Invalid GWA, keeping old value.");
    }
  }

  print("Student info updated successfully!");
}

void deleteStudent() {
  if (students.isEmpty) {
    print("No students to delete.");
    return;
  }

  stdout.write("Enter the name of the student to delete: ");
  String? searchName = stdin.readLineSync()?.trim();

  if (searchName == null || searchName.isEmpty) {
    print("Invalid name.");
    return;
  }

  int index = -1;
  for (int i = 0; i < students.length; i++) {
    String storedName = students[i]["Name"]?.toLowerCase() ?? "";
    if (storedName == searchName.toLowerCase()) {
      index = i;
      break;
    }
  }

  if (index == -1) {
    print("Student not found.");
    return;
  }

  var student = students[index];
  print("Student found:");
  print("  Name  : ${student['Name']}");
  print("  Age   : ${student['Age']}");
  print("  Course: ${student['Course']}");
  print("  GWA   : ${student['GWA']}");
  print("  Status: ${student['Status']}");
  print("----------------------------");

  stdout.write("Are you sure you want to delete this student? (y/n): ");
  String? confirm = stdin.readLineSync()?.toLowerCase();

  if (confirm == 'y' || confirm == 'yes') {
    students.removeAt(index);
    print("Student deleted successfully!");
  } else {
    print("Deletion cancelled.");
  }
}

void computeAverage() {
  if (students.isEmpty) {
    print("No students to compute average.");
    return;
  }

  double sum = 0;
  for (var student in students) {
    sum += student['GWA'] ?? 0.0;
  }
  double average = sum / students.length;
  print("==================================");
  print("Class Average GWA: ${average.toStringAsFixed(2)}");
  print("==================================");
}

void displayHighestGrade() {
  if (students.isEmpty) {
    print("No students to display.");
    return;
  }

  double minGwa = students[0]['GWA'] ?? 0.0;
  for (var student in students) {
    double gwa = student['GWA'] ?? 0.0;
    if (gwa < minGwa) minGwa = gwa;
  }

  List<Map<String, dynamic>> bestStudents = [];
  for (var student in students) {
    if (student['GWA'] == minGwa) {
      bestStudents.add(student);
    }
  }

  print("==================================");
  print("Student(s) with Highest Grade (Best GWA: $minGwa):");
  print("==================================");

  int i = 0;
  do {
    var student = bestStudents[i];
    print("  Name  : ${student['Name']}");
    print("  Age   : ${student['Age']}");
    print("  Course: ${student['Course']}");
    print("  GWA   : ${student['GWA']}");
    print("  Status: ${student['Status']}");
    print("---------------------");
    i++;
  } while (i < bestStudents.length);
}

void displayLowestGrade() {
  if (students.isEmpty) {
    print("No students to display.");
    return;
  }

  double maxGwa = students[0]['GWA'] ?? 0.0;
  for (var student in students) {
    double gwa = student['GWA'] ?? 0.0;
    if (gwa > maxGwa) maxGwa = gwa;
  }

  List<Map<String, dynamic>> worstStudents = [];
  for (var student in students) {
    if (student['GWA'] == maxGwa) {
      worstStudents.add(student);
    }
  }

  print("==================================");
  print("Student(s) with Lowest Grade (Lowest GWA: $maxGwa):");
  print("==================================");

  int i = 0;
  do {
    var student = worstStudents[i];
    print("  Name  : ${student['Name']}");
    print("  Age   : ${student['Age']}");
    print("  Course: ${student['Course']}");
    print("  GWA   : ${student['GWA']}");
    print("  Status: ${student['Status']}");
    print("---------------------");
    i++;
  } while (i < worstStudents.length);
}