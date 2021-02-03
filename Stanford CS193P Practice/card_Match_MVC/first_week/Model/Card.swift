//
//  Card.swift
//  first_week
//
//  Created by heawon on 2021/02/01.
//

import Foundation

struct Card {
    var isFacedUp = false
    var isMatched = false
    var ID: Int = 0

    //선언할 때 ID 지정 안해도 되도록
    static var IDSet: Int = 0
    static func makeID() -> Int {
        IDSet += 1
        return IDSet
    }
    // 카드를 생성할 때 입력받을 건 없고, 해당 카드의 아이디를 자동으로 리턴.
    init(){
        //각 인스턴스의 ID는 IDSet임
        self.ID = Card.makeID()
    }
}

