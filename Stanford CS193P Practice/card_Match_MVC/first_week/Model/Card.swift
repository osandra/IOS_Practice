//
//  Card.swift
//  first_week
//
//  Created by heawon on 2021/02/01.
//

import Foundation

struct Card: Hashable { // Hashable 프로토콜 채택 -> Hashable은 Equatable 프로토콜을 상속받고 있음
    var isFacedUp = false
    var isMatched = false
    private var ID: Int = 0 //private

    static func == (lhs: Card, rhs: Card) -> Bool { //Equatable 프토토콜에 있는 메서드
        // 두 개의 카드를 비교해서 같으면 true 리턴 추후 두 개의 카드를 비교할 때 Card1 == Card2로 같은 지 확인 가능
         return lhs.ID == rhs.ID
     }
    func hash(into hasher: inout Hasher){
        hasher.combine(ID)
    }
    
    //선언할 때 ID 지정 안해도 되도록
    private static var IDSet: Int = 0
    private static func makeID() -> Int {
        IDSet += 1
        return IDSet
    }
    // 카드를 생성할 때 입력받을 건 없고, 해당 카드의 아이디를 자동으로 리턴.
    init(){
        //각 인스턴스의 ID는 IDSet임
        self.ID = Card.makeID()
    }
}

