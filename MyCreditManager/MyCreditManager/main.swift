//
//  main.swift
//  MyCreditManager
//
//  Created by ChoiKwangWoo on 2023/04/28.
//

import Foundation
var students: [String: [String: Double]] = [:]

func enterKey(_ first: Bool, _ msg: String?) -> String {
    if first {
        print("원하는 기능을 입력해주세요.\n1. 학생추가 2. 학생삭제 3. 성적추가(변경) 4. 성적삭제 5. 평점보기 X. 종료")
    }
    
    if let msg = msg {
        print(msg)
    }
    
    return readLine()!
}

func validation(_ key: String) -> Bool {
    var copiedKey = key
    if ["1", "2", "3", "4", "5", "X", "x"].contains(key) {
        return true
    } else {
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        copiedKey = enterKey(true, nil)
        return validation(copiedKey)
    }
}

func getMsg(_ key: String) -> String {
    var msg = ""
    
    switch key {
    case "1": msg = "추가할 학생의 이름을 입력해주세요"
    case "2": msg = "삭제할 학생의 이름을 입력해주세요"
    case "3": msg = "성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 작성해주세요\n입력예) Mickey Swift A+\n만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다."
    case "4": msg = "성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey swift"
    case "5": msg = "평점을 알고싶은 학생의 이름을 입력해주세요"
    default: msg = "프로그램을 종료합니다..."
    }
    return msg
}

func operation(_ str: String) -> Bool {
    let copiedStr = str.lowercased()
    if enteredKey == "1" {
        if students[copiedStr] == nil {
            students[copiedStr] = [:]
            print("\(str) 학생을 추가했습니다.")
        } else {
            print("\(str)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        }
    } else if enteredKey == "2" {
        if students[str] == nil {
            print("\(str) 학생을 찾지 못했습니다.")
        } else {
            students[copiedStr] = nil
            print("\(str) 학생을 삭제하였습니다.")
        }
    } else if enteredKey == "3" {
        let score = copiedStr.split(separator: " ")
        if score.count != 3 {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else {
            let person = String(score[0]).lowercased()
            let subject = String(score[1]).lowercased()
            let subjectScore = getScore(String(score[2].uppercased()))
            if subjectScore > 0 {
                if (students[person] != nil) {
                    print("\(person) 학생의 \(subject) 과목이 \(score[2])로 추가 (변경) 되었습니다.")
                    if students[person]![subject] == nil {
                        students[person]![subject] = subjectScore
                    } else {
                        students[person] = [subject : subjectScore]
                    }
                } else {
                    print("입력이 잘못되었습니다. 다시 확인해주세요.")
                }
            } else {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }
        }
    } else if enteredKey == "4" {
        let score = copiedStr.split(separator: " ")
        if score.count != 2 {
            print("입력이 잘못되었습니다. 다시 확인해주세요.")
        } else {
            let person = String(score[0]).lowercased()
            let subject = String(score[1]).lowercased()
            
            if (students[person] != nil) {
                if students[person]![subject] != nil {
                    students[person]![subject] = nil
                } else {
                    print("입력이 잘못되었습니다. 다시 확인해주세요.")
                }
            } else {
                print("입력이 잘못되었습니다. 다시 확인해주세요.")
            }
        }
    } else if enteredKey == "5" {
        if students[copiedStr] != nil {
            let firstValues = students[copiedStr]!.values
            print("평점 : \(Double(firstValues.reduce(0, +)) / Double(students[copiedStr]!.count))")
        } else {
            print("\(copiedStr) 학생을 찾지 못했습니다.")
        }
    } else if enteredKey.lowercased() == "x" || str.lowercased() == "x" {
        return false
    }
    enteredKey = enterKey(true, nil)
    return operation(enterKey(false, getMsg(enteredKey)))
}

func getScore(_ score: String) -> Double {
    switch score {
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

var enteredKey = enterKey(true, nil)

if validation(enteredKey) {
    if !operation(enterKey(false, getMsg(enteredKey))) {
        print(students)
    }
}
