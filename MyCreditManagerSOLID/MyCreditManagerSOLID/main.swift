//
//  main.swift
//  MyCreditManagerSOLID
//
//  Created by ChoiKwangWoo on 2023/05/03.
//

import Foundation


protocol AddStudent {
    func addStudent()
}

protocol RemoveStudent {
    func removeStudent()
}

protocol AddOrChangeScore {
    func addOrChangeScore()
}

protocol RemoveScore {
    func removeScore()
}

protocol CheckScore {
    func checkScore()
}

class CreditManager: AddStudent, RemoveStudent, AddOrChangeScore, RemoveScore, CheckScore {
    
    var students: [String: [String: Double]] = [:]
    
    func addStudent() {
        print("추가할 학생의 이름을 입력해주세요")
        let studentName = readLine()!
        if students[studentName] != nil {
            print("\(studentName)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } else {
            print("\(studentName) 학생을 추가했습니다.")
            students[studentName] = [:]
        }
        initializeManager()
    }
    
    func removeStudent() {
        print("삭제할 학생의 이름을 입력해주세요")
        let studentName = readLine()!
        if students[studentName] != nil {
            print("\(studentName) 학생을 삭제하였습니다.")
            students[studentName] = nil
        } else {
            print("\(studentName) 학생을 찾지 못했습니다.")
        }
        initializeManager()
    }
    
    func addOrChangeScore() {
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 작성해주세요\n입력예) Mickey Swift A+\n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.")
        let enteredScoreInfo = readLine()!
        let scoreInfoDetail = enteredScoreInfo.split(separator: " ")
        let scoreInfoCount = scoreInfoDetail.count
        if scoreInfoCount != 3 {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else {
            let student = String(scoreInfoDetail[0]).lowercased()
            let subject = String(scoreInfoDetail[1]).lowercased()
            let subjectGrade = String(scoreInfoDetail[2]).uppercased()
            let subjectScore = getScoreFromGrade(subjectGrade)
            
            if subjectScore > -1 {
                if students[student] != nil {
                    print("\(student) 학생의 \(subject) 과목이 \(subjectGrade)로 추가 (변경) 되었습니다.")
                    if students[student]![subject] == nil {
                        students[student]![subject] = subjectScore
                    } else {
                        students[student] = [subject : subjectScore]
                    }
                } else {
                    print("\(student) 학생을 찾지 못했습니다. 다시 확인해주세요.")
                }
            } else {
                print("등급입력이 잘못되었습니다. 다시 확인해주세요.")
            }
        }
        initializeManager()
    }
    
    func removeScore() {
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey swift")
        let enteredScoreInfo = readLine()!
        let scoreInfoDetail = enteredScoreInfo.split(separator: " ")
        let scoreInfoCount = scoreInfoDetail.count
        
        if scoreInfoCount != 2 {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else {
            let student = String(scoreInfoDetail[0]).lowercased()
            let subject = String(scoreInfoDetail[1]).lowercased()
            
            if (students[student] != nil) {
                if students[student]![subject] != nil {
                    print("\(student) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
                    students[student]![subject] = nil
                } else {
                    print("\(student) 학생의 과목중 \(subject)를 찾지 못했습니다. 다시 확인해주세요.")
                }
            } else {
                print("\(student) 학생을 찾지 못했습니다. 다시 확인해주세요.")
            }
        }
        initializeManager()
    }
    
    func checkScore() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        let studentName = readLine()!
        
        if students[studentName] != nil {
            let scoreValues = students[studentName]!.values
            print("평점 : \(Double(scoreValues.reduce(0, +)) / Double(students[studentName]!.count))")
        } else {
            print("\(studentName) 학생을 찾지 못했습니다.")
        }
        initializeManager()
    }
    
    func initializeManager() {
        print("원하는 기능을 입력해주세요.\n1. 학생추가 2. 학생삭제 3. 성적추가(변경) 4. 성적삭제 5. 평점보기 X. 종료")
        let enteredKey = readLine()!
        if enteredKey == "1" {
            addStudent()
        } else if enteredKey == "2" {
            removeStudent()
        } else if enteredKey == "3" {
            addOrChangeScore()
        } else if enteredKey == "4" {
            removeScore()
        } else if enteredKey == "5" {
            checkScore()
        } else if enteredKey.lowercased() == "x" {
            return
        } else {
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
            initializeManager()
        }
    }
    
    func getScoreFromGrade(_ grade: String) -> Double {
        switch grade {
        case "A+": return 4.5
        case "A": return 4.0
        case "B+": return 3.5
        case "B": return 3.0
        case "C+": return 2.5
        case "C": return 2.0
        case "D+": return 1.5
        case "D": return 1.0
        case "F": return 0.0
        default: return -1
        }
    }
}

let creditManager = CreditManager()
creditManager.initializeManager()
print(creditManager.students)
