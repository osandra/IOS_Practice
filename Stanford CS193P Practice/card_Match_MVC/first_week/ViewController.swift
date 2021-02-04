import UIKit
class ViewController: UIViewController {
    private lazy var game = CardBrain(numberOfPairsOfCards: cardBtns.count / 2)
    
    private(set) var startCount = 0 {
        didSet {
            flipCount.text = "Flip Counts: \(startCount)"
        }
    }
    @IBOutlet private weak var flipCount: UILabel!
    @IBOutlet private var cardBtns: [UIButton]!

    override func viewDidLoad() {
        flipCount.text = "Flip Counts: 0"
    }
    @IBAction private func cardClicked(_ sender: UIButton) {
        startCount += 1
        if let cardNumber = cardBtns.firstIndex(of: sender){
                game.chooseCard(at: cardNumber) //facedUp, isMatched Logiㅊ
                updateViewFromModel() //.isFacedUp여부에 따라 UI 변경
        } else {
            print("chosen card was not in card btn")
        }
    }

    //match card and button
    private func updateViewFromModel(){
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
    private var emojiChoices = ["🎃", "💩","🧠", "🌱", "🌏", "📀"]
    private var emoji = [Card: String]() //key valie: custom Type인 Card로 변경
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil {
            let randomNumber = Int.random(in: 0..<emojiChoices.count)
            emoji[card] = emojiChoices.remove(at: randomNumber)
        }
        return emoji[card] ?? "?"
    }
    @IBAction func restartBtnClicked(_ sender: UIButton) {
        game.restart()
        emoji = [Card:String]()
        startCount = 0
        emojiChoices = ["🎃", "💩","🧠", "🌱", "🌏","📀"]
        self.updateViewFromModel()
    }
}
