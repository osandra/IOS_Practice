import UIKit
import Foundation
class CustomCollectionCell: UICollectionViewCell {
    static let identifier = "CustomCollectionCell"

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //해당 CustomCollectionCell이 로드되면 배경색 및 radius 설정
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        self.backgroundColor = UIColor(red: 1.00, green: 0.87, blue: 0.35, alpha: 1.00)
    }
}
