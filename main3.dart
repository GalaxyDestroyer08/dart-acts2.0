import 'dart:io';

List<Map<String, dynamic>> students = [];
int _nextId = 1; // always gives a new, unique ID

void main() {
  bool running = true;

  while (running) {
    print("\n==================================");
    print("    STUDENT INFORMATION SYSTEM     ");
    print("==================================");
    print("1. Add Student");
    print("2. View All Students");
    print("3. Update Student Info");
    print("4. Delete Student Info");
    print("5. Exit");
    print("==================================");
    stdout.write("Choose 1-5: ");

    String? input = stdin.readLineSync();
    int choice = int.parse(input ?? "-1"); // simple, crashes on non‑number

    switch (choice) {
      case 1:
        addStudent();
        break;
      case 2:
        viewStudents();
        break;
      case 3:
        updateStudent();
        break;
      case 4:
        deleteStudent();
        break;
      case 5:
        print("Exiting program...");
        running = false;
        break;
      default:
        print("Invalid choice. Try again.");
    }
  }
}

// ---- Add ----
void addStudent() {
  stdout.write("Enter Name: ");
  String name = stdin.readLineSync() ?? "";
  stdout.write("Enter Course: ");
  String course = stdin.readLineSync() ?? "";
  stdout.write("Enter Year Level: ");
  String year = stdin.readLineSync() ?? "";

  if (name.isEmpty || course.isEmpty || year.isEmpty) {
    print("All fields are required.\n");
    return;
  }

  students.add({
    "id": _nextId++,
    "name": name,
    "course": course,
    "yearLevel": year,
  });
  print("Student added successfully!\n");
}

// ---- View All ----
void viewStudents() {
  if (students.isEmpty) {
    print("No student records.\n");
    return;
  }

  print("\n--- All Students ---");
  for (var s in students) {
    print("ID: ${s["id"]} | Name: ${s["name"]} | Course: ${s["course"]} | Year: ${s["yearLevel"]}");
  }
  print("");
}

// ---- Search helper: returns a Map with student and index, or null ----
Map<String, dynamic>? _findStudentByPartialName() {
  stdout.write("Enter partial name to search: ");
  String query = (stdin.readLineSync() ?? "").toLowerCase().trim();
  if (query.isEmpty) {
    print("Search term cannot be empty.\n");
    return null;
  }

  // Find all matches (store indices)
  List<int> matches = [];
  for (int i = 0; i < students.length; i++) {
    if (students[i]["name"].toLowerCase().contains(query)) {
      matches.add(i);
    }
  }

  if (matches.isEmpty) {
    print("No student found with that name.\n");
    return null;
  }

  // Show matches
  print("\nMatching students:");
  for (int idx in matches) {
    var s = students[idx];
    print("ID: ${s["id"]} | Name: ${s["name"]} | Course: ${s["course"]} | Year: ${s["yearLevel"]}");
  }

  // Ask for ID
  stdout.write("\nEnter the ID of the student to proceed: ");
  String? idInput = stdin.readLineSync();
  int? id = int.tryParse(idInput ?? "");
  if (id == null) {
    print("Invalid ID.\n");
    return null;
  }

  // Find the exact student by ID among matches
  for (int idx in matches) {
    if (students[idx]["id"] == id) {
      return {"student": students[idx], "index": idx};
    }
  }

  print("ID not found in the list above.\n");
  return null;
}

// ---- Update ----
void updateStudent() {
  if (students.isEmpty) {
    print("No students to update.\n");
    return;
  }

  var result = _findStudentByPartialName();
  if (result == null) return;

  var student = result["student"] as Map<String, dynamic>;
  int index = result["index"] as int;

  print("\nUpdating student: ${student["name"]}");
  stdout.write("New Name (${student["name"]}): ");
  String newName = stdin.readLineSync() ?? "";
  stdout.write("New Course (${student["course"]}): ");
  String newCourse = stdin.readLineSync() ?? "";
  stdout.write("New Year Level (${student["yearLevel"]}): ");
  String newYear = stdin.readLineSync() ?? "";

  // Update only if user provided new value, otherwise keep old
  if (newName.isNotEmpty) student["name"] = newName;
  if (newCourse.isNotEmpty) student["course"] = newCourse;
  if (newYear.isNotEmpty) student["yearLevel"] = newYear;

  print("Student updated successfully!\n");
}

// ---- Delete ----
void deleteStudent() {
  if (students.isEmpty) {
    print("No students to delete.\n");
    return;
  }

  var result = _findStudentByPartialName();
  if (result == null) return;

  int index = result["index"] as int;
  students.removeAt(index);
  print("Student deleted successfully!\n");
}
