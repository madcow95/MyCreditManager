//
//  main.swift
//  MyCreditManagerSOLID
//
//  Created by ChoiKwangWoo on 2023/05/03.
//

import Foundation

class CreditManager {
    
    var mode: String = ""
    
    func initializeManager() {
        print("원하는 기능을 입력해주세요.\n1. 학생추가 2. 학생삭제 3. 성적추가(변경) 4. 성적삭제 5. 평점보기 X. 종료")
        self.keyValidation(enter: readLine()!)
    }
    
    func keyValidation(enter key: String) {
        if !["1", "2", "3", "4", "5", "x"].contains(key.lowercased()) {
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
            self.initializeManager()
        } else {
            self.mode = key
        }
    }
}

let creditManager = CreditManager()
creditManager.initializeManager()

class StudentManager {
    var students: [Student]
    let studentHandler: StudentHandler
    
    init(students: [Student], studentHandler: StudentHandler) {
        self.students = students
        self.studentHandler = studentHandler
    }
    
    func manageStudent() -> [Student] {
        studentHandler.startCreditManager()
        return students
    }
}

class StudentHandler: StudentManager {
    
    func startCreditManager() {
        let currentMode = creditManager.mode
        if currentMode == "1" {
            print("추가할 학생의 이름을 입력해주세요")
            let addTargetStudent = self.addStudent(readLine()!)
            if addTargetStudent != nil {
                self.students.append(addTargetStudent!)
            }
        }
    }
    
    func studentExistCheck(_ studentName: String) -> Bool {
        var isExist = false
        for student in self.students {
            if student.name == studentName {
                isExist = true
                break
            }
        }
        return isExist
    }
    
    func addStudent(_ studentName: String) -> Student? {
        if self.studentExistCheck(studentName) {
            print("\(studentName)은/는 이미 존재하는 학생입니다. 추가하지 않습니다.")
            creditManager.initializeManager()
            return nil
        } else {
            let newStudent = Student(name: studentName, subject: [], score: [])
            print("\(studentName) 학생을 추가했습니다.")
            return newStudent
        }
    }
}

class Student {
    let name: String
    var subject: [String]
    var score: [Double]
    
    init(name: String, subject: [String], score: [Double]) {
        self.name = name
        self.subject = subject
        self.score = score
    }
}

//확 다시만들어?
//let studentManager = StudentManager(students: [])
//studentManager.studentHandler?.startCreditManager()
//print(studentManager.students.count)

