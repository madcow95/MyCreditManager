//
//  main.swift
//  MyCreditManager
//
//  Created by ChoiKwangWoo on 2023/04/28.
//

import Foundation
var students: [String: [String: Any]] = [:]
var errMsg = ""

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
    if ["1", "2", "3", "4", "5", "X"].contains(key) {
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
    default: msg = "finish"
    }
    return msg
}

func preOperation(_ str: String) -> Bool {
    if str.isEmpty {
        return preOperation(enterKey(false, nil))
    } else {
        if str == "X" {
            return true
        }
        return operation(str)
    }
    
}

func operation(_ str: String) -> Bool {
    let copiedStr = str.lowercased()
    if enteredKey == "1" {
        if students[copiedStr] == nil {
            students[copiedStr] = ["" : 0.0]
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
            students[score[0]] = [score[1] : 4.5]
        }
    }
    print(students)
    enteredKey = enterKey(true, nil)
    return preOperation(enterKey(false, getMsg(enteredKey)))
}

var enteredKey = enterKey(true, nil)

if validation(enteredKey) {
    if preOperation(enterKey(false, getMsg(enteredKey))) {
        print("complete!!!")
    } else {
        print(students)
    }
}





