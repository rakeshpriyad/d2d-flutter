class Employee {
  String id;
  String employeeName;
  String employeeSalary;
  String employeeAge;
  String profileImage;

  Employee(this.id, this.employeeName, this.employeeSalary, this.employeeAge,
      this.profileImage);

  static Employee empty() {
    return new Employee("", "", "", "", "");
  }

  factory Employee.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw FormatException("Null JSON.");
    }
    String id = "$json['id']";
    String employeeName= "$json['employee_name']";
    String employeeSalary= "$json['employee_salary']";
    String employeeAge= "$json['employee_age']";
    String profileImage= "$json['profile_image']";

    //return Employee(json['id'], json['employee_name'], json['employee_salary'],
    //    json['employee_age'], json['profile_image']);
    return Employee(id, employeeName, employeeSalary,
        employeeAge, profileImage);
  }

  Map<String, dynamic> toJson() {
    var map = {
      'name': employeeName,
      'salary': employeeSalary,
      'age': employeeAge
    };
    if (id.isNotEmpty) {
      map['id'] = id;
    }
    if (profileImage.isNotEmpty) {
      map['profileImage'] = profileImage;
    }
    return map;
  }

  get hasEmptyId {
    return id.isEmpty;
  }
}
