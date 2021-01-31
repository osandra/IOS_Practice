//
//  ReusableCustomView.swift
//  sideMenuPractic
//
//  Created by heawon on 2021/01/31.
//
import UIKit

class ResuableCustomView: UIControl {
    let nibName = "ReusableCustomView"
    
    @IBOutlet weak var containerView: UIStackView!
    //해당 버튼을 클릭하면 sendActions을 통해 touchUpInside 이벤트와 관련된 모든 작업을 전송받음. 즉 추후 ResuableCustomView를 상속받은 다른 뷰컨트롤러에서 ResuableCustomView에 touchUpInside 이벤트 발생 시 실행할 코드(설정된 액션)를 작성하면(ex showSlideMenu) 버튼이 해당 이벤트를 전송받겠다. 즉 실행하겠다는 것임.
    @IBAction func menuBtnClicked(_ sender: UIButton) {
        self.sendActions(for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            commonInit()
        }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
