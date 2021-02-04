import Foundation

class CardBrain {
    var cards = [Card]()
    var numberOfPairsOfCards: Int = 0
    var oneAndOnlyFacedUpCardIndex: Int? {
        get {
            //cards에 있는 카드 중에 isfaceup인 카드의 index들이 담긴 배열 반환
            let facedUpCardIndices = cards.indices.filter { cards[$0].isFacedUp }
            return facedUpCardIndices.oneAndOnly //해당 배열에 주소가 하나면 해당 인덱스 반환 아니면 nil반환
        }
        set {
            //인덱스를 받아서, 해당 인덱스와 동일한 index가진 카드만 up하고 나머지는 덮기(즉 open된 카드가 0,2장인 상태에서 해당 프로퍼티 값 변경)
            for index in cards.indices {
                cards[index].isFacedUp = (newValue == index)
            }
        }
    }
    
    //카드를 선택하면
    func chooseCard(at index: Int){
        //카드가 매치된 상태가 아닌 경우에만 진행 -> 매치된 상태면 뷰에서 해당 카드를 안 보이게 처리해서
        if !cards[index].isMatched {
            if let matchIndex = oneAndOnlyFacedUpCardIndex, matchIndex != index {
                // Card구조체에서 [static func == (lhs: Card, rhs: Card) -> Bool] 함수를 통해 두 카드 동일한 지 확인
                    if cards[matchIndex] == cards[index] {
                        //두 개의 카드가 매치되면
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                    }
                cards[index].isFacedUp = true
            }
            else {
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

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil //개수가 하나면 collection의 첫 번째 요소 반환, 아니면 nil 반환
    }
}

