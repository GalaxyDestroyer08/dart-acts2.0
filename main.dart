import 'dart:io';

List<Map<String,dynamic>> Students = [];

void main(){
    bool run = true;
    while(run){
    print("==================================");
    print("    STUDENT INFORMATION SYSTEM     ");
    print("==================================");
    print("1. Add Student");
    print("2. View Student");
    print("3. Update Student Info");
    print("4. Delete Student Info");
    print("5. Exit");
    print("==================================");
    stdout.write("Choose from 1-5:\n");

    int choices = int.parse(stdin.readLineSync()!);
    
        switch(choices){
            case 1: addStudent();
            break;

            case 2:viewStudents();
            break;

            case 3:updateStudent();
            break;

            case 4:deleteStudent();
            break;

            case 5:
            print("Exiting the program...");
            return;

            
        }

    }
        
}

void addStudent(){
    stdout.write("Enter you Name: ");
    String name = stdin.readLineSync()!;
    stdout.write("Enter your Course: ");
    String course = stdin.readLineSync()!;
    stdout.write("Enter your Year Level: ");
    String yearLevel = stdin.readLineSync()!;

    Students.add({
        "id": id,
        "name": name,
        "course": course,
        "yearLevel": yearLevel
    });
    print("Student Added Successfully!");
    
    

}

void viewStudents(){
    print("======View Student======\n");

    if (Students.isEmpty){
        print("No student record found!");
    }

    for (int i = 0; i < Students.length; i++){
        var student = Students[i];
        print("Name: ${student["name"]}");
        print("Course: ${student["course"]}");
        print("Year Level: ${student["yearLevel"]}\n");
        print("========================\n");
    }

}

void updateStudent(){
    print("Update Student");

}

void deleteStudent(){
    print("Delete Student");

}

