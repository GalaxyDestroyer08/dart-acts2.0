import 'dart:io';

// ================================
// 1. Student Class (Encapsulation)
// ================================
class Student {
  String _name;
  int _age;
  String _course;
  double _gwa;
  late String _status; // will be set in constructor

  // Constructor
  Student(this._name, this._age, this._course, this._gwa) {
    _status = _computeStatus();
  }

  // Getters
  String get name => _name;
  int get age => _age;
  String get course => _course;
  double get gwa => _gwa;
  String get status => _status;

  // Setters (with validation)
  set name(String newName) {
    if (newName.trim().isNotEmpty) _name = newName.trim();
  }

  set age(int newAge) {
    if (newAge > 0 && newAge < 150) _age = newAge;
  }

  set course(String newCourse) {
    if (newCourse.trim().isNotEmpty) _course = newCourse.trim();
  }

  set gwa(double newGwa) {
    if (newGwa >= 1.0 && newGwa <= 5.0) {
      _gwa = newGwa;
      _status = _computeStatus(); // auto‑update status
    }
  }

  // Internal method to compute status based on GWA
  String _computeStatus() {
    if (_gwa <= 1.75) return "Excellent";
    if (_gwa <= 2.75) return "Very Good";
    if (_gwa == 3.0) return "Passed";
    if (_gwa == 5.0) return "Probation";
    return "Invalid Input";
  }

  // Display student info (formatted)
  void display({bool withSeparator = true}) {
    print("  Name  : $_name");
    print("  Age   : $_age");
    print("  Course: $_course");
    print("  GWA   : $_gwa");
    print("  Status: $_status");
    if (withSeparator) print("---------------------");
  }

  // For updating each field interactively – returns true if any change was made
  bool updateFromInput() {
    bool changed = false;

    stdout.write("Enter new name (or press Enter to keep): ");
    String? input = stdin.readLineSync()?.trim();
    if (input != null && input.isNotEmpty) {
      name = input;
      changed = true;
    }

    stdout.write("Enter new age (or press Enter to keep): ");
    input = stdin.readLineSync()?.trim();
    if (input != null && input.isNotEmpty) {
      int? newAge = int.tryParse(input);
      if (newAge != null) {
        age = newAge;
        changed = true;
      } else {
        print("Invalid age, keeping old value.");
      }
    }

    stdout.write("Enter new course (or press Enter to keep): ");
    input = stdin.readLineSync()?.trim();
    if (input != null && input.isNotEmpty) {
      course = input;
      changed = true;
    }

    stdout.write("Enter new GWA (or press Enter to keep): ");
    input = stdin.readLineSync()?.trim();
    if (input != null && input.isNotEmpty) {
      double? newGwa = double.tryParse(input);
      if (newGwa != null) {
        gwa = newGwa; // setter auto‑updates status
        changed = true;
      } else {
        print("Invalid GWA, keeping old value.");
      }
    }
    return changed;
  }
}

// ================================
// 2. StudentManager Class
// ================================
class StudentManager {
  List<Student> _students = [];

  // --- Add a new student ---
  void addStudent() {
    stdout.write("Enter your name: ");
    String? name = stdin.readLineSync()?.trim() ?? '';

    stdout.write("Enter your age: ");
    int age = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

    stdout.write("Enter your course: ");
    String? course = stdin.readLineSync()?.trim() ?? '';

    stdout.write("Enter your GWA: ");
    double gwa = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;

    Student student = Student(name, age, course, gwa);

    print("====Student Information System====");
    student.display(withSeparator: false);
    print("==================================");

    _students.add(student);
    print("Added successfully!");
  }

  // --- View all students ---
  void viewStudents() {
    if (_students.isEmpty) {
      print("No students found.");
      return;
    }
    int i = 0;
    do {
      print("Student ${i + 1}:");
      _students[i].display();
      i++;
    } while (i < _students.length);
  }

  // --- Search students by name (partial match) ---
  void searchStudent() {
    if (_students.isEmpty) {
      print("No students to search.");
      return;
    }

    stdout.write("Enter the name (or partial name) to search: ");
    String? searchTerm = stdin.readLineSync()?.trim();
    if (searchTerm == null || searchTerm.isEmpty) {
      print("Invalid search term.");
      return;
    }

    List<Student> results = [];
    String lowerSearch = searchTerm.toLowerCase();
    for (var student in _students) {
      if (student.name.toLowerCase().contains(lowerSearch)) {
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
      print("Student ${i + 1}:");
      results[i].display();
      i++;
    } while (i < results.length);
  }

  // --- Update a student (by exact name match) ---
  void updateStudent() {
    if (_students.isEmpty) {
      print("No students to update.");
      return;
    }

    stdout.write("Enter the name of the student to update: ");
    String? searchName = stdin.readLineSync()?.trim();
    if (searchName == null || searchName.isEmpty) {
      print("Invalid name.");
      return;
    }

    // Find index (case‑insensitive)
    int index = -1;
    for (int i = 0; i < _students.length; i++) {
      if (_students[i].name.toLowerCase() == searchName.toLowerCase()) {
        index = i;
        break;
      }
    }

    if (index == -1) {
      print("Student not found.");
      return;
    }

    Student student = _students[index];
    print("Current info:");
    student.display();

    bool updated = student.updateFromInput();
    if (updated) {
      print("Student info updated successfully!");
    } else {
      print("No changes made.");
    }
  }

  // --- Delete a student ---
  void deleteStudent() {
    if (_students.isEmpty) {
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
    for (int i = 0; i < _students.length; i++) {
      if (_students[i].name.toLowerCase() == searchName.toLowerCase()) {
        index = i;
        break;
      }
    }

    if (index == -1) {
      print("Student not found.");
      return;
    }

    Student student = _students[index];
    print("Student found:");
    student.display();

    stdout.write("Are you sure you want to delete this student? (y/n): ");
    String? confirm = stdin.readLineSync()?.toLowerCase();
    if (confirm == 'y' || confirm == 'yes') {
      _students.removeAt(index);
      print("Student deleted successfully!");
    } else {
      print("Deletion cancelled.");
    }
  }

  // --- Compute class average GWA ---
  void computeAverage() {
    if (_students.isEmpty) {
      print("No students to compute average.");
      return;
    }
    double sum = 0;
    for (var student in _students) {
      sum += student.gwa;
    }
    double average = sum / _students.length;
    print("==================================");
    print("Class Average GWA: ${average.toStringAsFixed(2)}");
    print("==================================");
  }

  // --- Display student(s) with highest grade (lowest GWA) ---
  void displayHighestGrade() {
    if (_students.isEmpty) {
      print("No students to display.");
      return;
    }
    double minGwa = _students[0].gwa;
    for (var student in _students) {
      if (student.gwa < minGwa) minGwa = student.gwa;
    }

    List<Student> best = [];
    for (var student in _students) {
      if (student.gwa == minGwa) best.add(student);
    }

    print("==================================");
    print("Student(s) with Highest Grade (Best GWA: $minGwa):");
    print("==================================");
    for (var student in best) {
      student.display();
    }
  }

  // --- Display student(s) with lowest grade (highest GWA) ---
  void displayLowestGrade() {
    if (_students.isEmpty) {
      print("No students to display.");
      return;
    }
    double maxGwa = _students[0].gwa;
    for (var student in _students) {
      if (student.gwa > maxGwa) maxGwa = student.gwa;
    }

    List<Student> worst = [];
    for (var student in _students) {
      if (student.gwa == maxGwa) worst.add(student);
    }

    print("==================================");
    print("Student(s) with Lowest Grade (Highest GWA: $maxGwa):");
    print("==================================");
    for (var student in worst) {
      student.display();
    }
  }

  // --- Main menu loop ---
  void run() {
    bool running = true;
    do {
      print("==================================");
      print("    STUDENT INFORMATION SYSTEM   ");
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
}

// ================================
// 3. Main Entry Point
// ================================
void main() {
  StudentManager manager = StudentManager();
  manager.run();
}
