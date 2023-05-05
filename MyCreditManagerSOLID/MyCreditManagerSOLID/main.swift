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

class CreditMode: AddStudent, RemoveStudent, AddOrChangeScore, RemoveScore, CheckScore {
    func addStudent() {
        print("add Student")
    }
    
    func removeStudent() {
        print("remove Student")
    }
    
    func removeScore() {
        print("remove Score")
    }
    
    func addOrChangeScore() {
        print("add or change score")
    }
    
    func checkScore() {
        print("check score")
    }
    
    
}

class CreditManager {
    
    let mode: String
    
    init(mode: String) {
        self.mode = mode
    }
    
    func initializeManager() {
        print("원하는 기능을 입력해주세요.\n1. 학생추가 2. 학생삭제 3. 성적추가(변경) 4. 성적삭제 5. 평점보기 X. 종료")
    }
}

//let enteredKey = readLine()!
//if !["1", "2", "3", "4", "5", "x", "X"].contains(enteredKey) {
//    print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
//}

let creditManager = CreditManager(mode: "")
creditManager.initializeManager()
let creditMode = CreditMode()
creditMode.addOrChangeScore()
