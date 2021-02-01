import UIKit
class ViewController: UIViewController {
    // game을 처음 쓸 떄 이니셜라이징 하는 데, CardBrain에 들어가는 값에 프로퍼티 및 변수가 들어가면 해당 변수도 이니셜라이징 되어야 함(첫 사용시)
    // 즉 game을 초기화하는 중에 cardBtns도 초기화하는 것 -> Property인 game은 cardBtns가 초기화하는 와중에 초기화될 수 없다.(순서 불확실, 부작용 방지 위해)
    // 에러 발생 코드: var game = CardBrain(numberOfPairsOfCards: cardBtns.count / 2)

    // 따라서 lazy를 사용 -> lazy로 선언한 속성은 처음 사용할 때 초기화되므로 다른 프로퍼티를 사용할 수 있다.
    lazy var game = CardBrain(numberOfPairsOfCards: cardBtns.count / 2)
    
    var startCount = 0 {
        didSet {
            flipCount.text = "Flip Counts: \(startCount)"
        }
    }
    @IBOutlet weak var flipCount: UILabel!
    @IBOutlet var cardBtns: [UIButton]!

    override func viewDidLoad() {
        flipCount.text = "Flip Counts: 0"
    }
    @IBAction func cardClicked(_ sender: UIButton) {
        startCount += 1
        if let cardNumber = cardBtns.firstIndex(of: sender){
                game.chooseCard(at: cardNumber) //facedUp, isMatched Logix
                updateViewFromModel() //.isFacedUp여부에 따라 UI 변경
        } else {
            print("chosen card was not in card btn")
        }
    }

    //match card and button
    func updateViewFromModel(){
        for index in 0..<cardBtns.count {
            let button = cardBtns[index]
            let card = game.cards[index]
            if card.isFacedUp {
                //이모지 보여주기
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: .normal)
                //다시 isFacedUp false일 때 매치된 상테도 덮인 거면 안 보이게 하기
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) :UIColor(red: 0.55, green: 0.48, blue: 0.90, alpha: 1.00)
            }
        }
    }
    var emojiChoices = ["🎃", "💩","🧠", "🌱", "🌏", "📀"]
    var emoji = [Int:String]() //initialize
    func emoji(for card: Card) -> String {
        // 해당 카드에 이모지를 넣기
        // 현재 해당 카드 id로 배정된 스트링이 없다면 랜덤으로 넣어주기
        if emoji[card.ID] == nil {
            let randomNumber = Int.random(in: 0..<emojiChoices.count)
            emoji[card.ID] = emojiChoices.remove(at: randomNumber)
            //이모지를 배정한 뒤에 이모지 선택리스트에서 제외하기
        }
        return emoji[card.ID] ?? "?"
    }
    @IBAction func restartBtnClicked(_ sender: UIButton) {
        game.restart()
        emoji = [Int:String]()
        startCount = 0
        emojiChoices = ["🎃", "💩","🧠", "🌱", "🌏","📀"]
        self.updateViewFromModel()
    }
}
