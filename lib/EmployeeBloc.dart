// Below are the ways to create a BLOC

// 1. imports

//2. List of employess

//3. Stream controllers

//4. Stream Sink getter

//5. Constructor - add data; listem to changes

//6. Core functions

//7. dispose.

//1.
import 'dart:async';
import 'Employee.dart';

//2.
class EmployeeBloc {
  // sink to add in pipe
  // stream to get the data
  // pipe = data flow

  List<Employee> _employeeList = [
    Employee(1, "Sachin", 10000.0),
    Employee(2, "Sumit", 12000.0),
    Employee(3, "Vishal", 14000.0),
    Employee(4, "Vikas", 16000.0),
    Employee(5, "Raj", 14700.0),
  ];

//3.
  final _employeeListSteamController = StreamController<List<Employee>>();

  // for inc and dec

  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

//4.
// getter
  Stream<List<Employee>> get employeeListStream =>
      _employeeListSteamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListSteamController.sink;

  StreamSink<Employee> get employeeSalaryIncrement =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get _employeeSalaryDecrement =>
      _employeeSalaryDecrementStreamController.sink;

//5. constructors
  EmployeeBloc() {
    _employeeListSteamController.add(_employeeList);
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

//6. core functions
  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double _incrementedSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary + _incrementedSalary;
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double _decrementedSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary - _decrementedSalary;
    employeeListSink.add(_employeeList);
  }

//7. dispose
  // closing all of them, order may very.
  void dispose() {
    _employeeSalaryIncrementStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeListSteamController.close();
  }
}
