import Foundation

class CardBrain {
    var cards = [Card]()
    var numberOfPairsOfCards: Int = 0
    
    //한 장의 카드가 현재 faceUp(이모지가 보이는 면) 상태인 지 확인
    //이모지가 보이는 카드가 한 장인 상태에서 카드를 선택하면 두 카드의 ID가 동일한 지 확인 -> 동일하면 .isMatched 상태 변경
    //이모지가 보이는 카드가 한 장이 아닐 경우(ex 0장, 2장) -> .isFacedUp인 카드를 다 뒤집고, 현재 선택한 카드의 .isFacedUp 을 true로 변경 및 oneAndOnlyFacedUpCardIndex에 해당 카드의 인덱스 값 넣어주
    var oneAndOnlyFacedUpCardIndex: Int?
    
    //카드를 선택하면
    func chooseCard(at index: Int){
        //카드가 매치된 상태가 아닌 경우에만 진행 -> 매치된 상태면 뷰에서 해당 카드를 안 보이게 처리해서
        if !cards[index].isMatched {
            //matchindex 와 선택한 인덱스 카드가 같지 않아야(즉 같은 카드를 두 번 클릭하지 않아야) - 매치여부 확인 진행
            if let matchIndex = oneAndOnlyFacedUpCardIndex, matchIndex != index {
                    if cards[matchIndex].ID == cards[index].ID {
                        //두 개의 카드가 매치되면
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                    }
                    //매치가 되는 안 되든 선택한 카드 faceUP(사용자에게 보여줘야 하므로)
                    cards[index].isFacedUp = true
                    //이제 faceUp카드가 한 장인 상태에서 faceUP인 카드가 두장이므로 nil 로 변경
                    oneAndOnlyFacedUpCardIndex = nil
            }
            // faceUp카드가 0장 or 2장일 때
            else {
                //카드 배열 안에 있는 모든 카드의  .isFacedUp 값 false 로 만들기
                for getIndex in cards.indices {
                    cards[getIndex].isFacedUp = false
                }
                //선택한 카드 .isFaceUp해주기
                cards[index].isFacedUp = true
                //선택한 카드로 인해 한 장이 isFacedUp된 상태니까 해당 카드의 index를 저장
                oneAndOnlyFacedUpCardIndex = index
            }
        }
    }
    init(numberOfPairsOfCards: Int){
        // 한 쌍씩 생성 -> 한 카드를 만들고, 해당 카드를 배열에 두 번 추가
        // 추후 동일한 ID를 통해 같은 카드가 매칭되었는지 확인할 것이므로
        // 동일한 ID(key값) 에 이모지 값(value)을 저장하는 emoji 딕셔너리를 뷰에서 생성할 것임
        for _ in 0..<numberOfPairsOfCards {
            let card = Card() //카드 하나 생성
            cards += [card,card]
        }
        //shuffle the cards
        cards.shuffle()
    }
    // 게임 리셋하는 버튼 클릭 시
    func restart(){
        for index in cards.indices {
            cards[index].isFacedUp = false
            cards[index].isMatched = false
        }
    }
}
