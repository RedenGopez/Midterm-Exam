// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GradeContract {
address public owner;

//  Grade stat
enum GradeStatus { Pass, Fail }

// Student info | | grades
struct Stud {
string name;
uint prelimGrade;
uint midtermGrade;
uint finalGrade;
GradeStatus status;
}

// Student var
Stud private student;

event GradeComputed(string studentName, GradeStatus status);

constructor() {
// Initialize contract with deployer as owner
owner = msg.sender;
}

// Modifier to restrict function access to contract owner
modifier onlyOwner() {
require(msg.sender == owner, "Caller is not the owner");
_;
}

modifier validGrade(uint grade) {
require(grade <= 100 && grade >= 0, "Grade must be between 0 and 100");
_;
}

function setName(string calldata _name) public onlyOwner {
student.name = _name;
}

// Prelim Grade
function setPrelimGrade(uint _grade) public onlyOwner validGrade(_grade) {
student.prelimGrade = _grade;
}

// Midterm Grade
function setMidtermGrade(uint _grade) public onlyOwner validGrade(_grade) {
student.midtermGrade = _grade;
}

// Final Grade
function setFinalGrade(uint _grade) public onlyOwner validGrade(_grade) {
student.finalGrade = _grade;
}

// Calculated total grade
function calculateGrade() public onlyOwner {
uint overallGrade = (student.prelimGrade + student.midtermGrade + student.finalGrade) / 3;

// update
// if (overallGrade >= 10) {
if (overallGrade >= 50) {
student.status = GradeStatus.Pass;
} else {
student.status = GradeStatus.Fail;
}

emit GradeComputed(student.name, student.status);
}

//function finalGrade() public onlyOwner {
//    require(finalGrade > 0  );
//}
// Data
function getStudentData() public view returns (string memory name, uint prelimGrade, uint midtermGrade, uint finalGrade, GradeStatus status) {
return (student.name, student.prelimGrade, student.midtermGrade, student.finalGrade, student.status);
}
}