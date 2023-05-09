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
    func showStudentScoreAverage()
}

class CreditManager: AddStudent, RemoveStudent, AddOrChangeScore, RemoveScore, CheckScore {
    private var students: [String: [String: Double]] = [:]
    
    func addStudent() {
        print("추가할 학생의 이름을 입력해주세요")
        let studentName = readLine()!
        if students[studentName] != nil {
            print("\(studentName)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } else {
            print("\(studentName) 학생을 추가했습니다.")
            students[studentName] = [:]
        }
        controlCreditManager()
    }
    
    func removeStudent() {
        print("삭제할 학생의 이름을 입력해주세요")
        let studentName = readLine()!
        guard students[studentName] != nil else {
            print("\(studentName) 학생을 찾지 못했습니다.")
            controlCreditManager()
            return
        }
        print("\(studentName) 학생을 삭제하였습니다.")
        students[studentName] = nil
        controlCreditManager()
    }
    
    // 좀 더 가독성있게 만들 수 있을거 같은데... 일단 보류
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
                guard students[student] != nil else {
                    print("\(student) 학생을 찾지 못했습니다. 다시 확인해주세요.")
                    controlCreditManager()
                    return
                }
                print("\(student) 학생의 \(subject) 과목이 \(subjectGrade)로 추가 (변경) 되었습니다.")
                // students dictionary에 등록된 subject가 없으면 추가
                if students[student]![subject] == nil {
                    students[student]![subject] = subjectScore
                } else {
                    students[student] = [subject : subjectScore]
                }
            } else {
                print("등급입력이 잘못되었습니다. 다시 확인해주세요.")
            }
        }
        controlCreditManager()
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
            
            guard students[student] != nil else {
                print("\(student) 학생을 찾지 못했습니다. 다시 확인해주세요.")
                controlCreditManager()
                return
            }
            
            if students[student]![subject] != nil {
                print("\(student) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
                students[student]![subject] = nil
            } else {
                print("\(student) 학생의 과목중 \(subject)를 찾지 못했습니다. 다시 확인해주세요.")
            }
        }
        controlCreditManager()
    }
    
    func showStudentScoreAverage() {
        print("평점을 알고싶은 학생의 이름을 입력해주세요")
        let studentName = readLine()!
        
        guard students[studentName] != nil else {
            print("\(studentName) 학생을 찾지 못했습니다.")
            controlCreditManager()
            return
        }
        
        let scoreValues = students[studentName]!.values
        print("평점 : \(Double(scoreValues.reduce(0, +)) / Double(students[studentName]!.count))")
        controlCreditManager()
    }
    
    func controlCreditManager() {
        print("원하는 기능을 입력해주세요.\n1. 학생추가 2. 학생삭제 3. 성적추가(변경) 4. 성적삭제 5. 평점보기 X. 종료")
        let enteredKey = readLine()!
        switch enteredKey.lowercased() {
        case "1": addStudent()
        case "2": removeStudent()
        case "3": addOrChangeScore()
        case "4": removeScore()
        case "5": showStudentScoreAverage()
        case "x": return
        default :
            print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
            controlCreditManager()
        }
    }
    
    enum ScoreEnum: Double {
        case AA = 4.5
        case A = 4.0
        case BB = 3.5
        case B = 3.0
        case CC = 2.5
        case C = 2.0
        case DD = 1.5
        case D = 1.0
        case F = 0.0
    }
    
    func getScoreFromGrade(_ grade: String) -> Double {
        switch grade {
        case "A+": return ScoreEnum.AA.rawValue
        case "A": return ScoreEnum.A.rawValue
        case "B+": return ScoreEnum.BB.rawValue
        case "B": return ScoreEnum.B.rawValue
        case "C+": return ScoreEnum.CC.rawValue
        case "C": return ScoreEnum.C.rawValue
        case "D+": return ScoreEnum.DD.rawValue
        case "D": return ScoreEnum.D.rawValue
        case "F": return ScoreEnum.F.rawValue
        default: return -1
        }
    }
    
    func showStudentsScore() {
        print(students)
    }
}

let creditManager = CreditManager()
creditManager.controlCreditManager()
print(creditManager.showStudentsScore())
