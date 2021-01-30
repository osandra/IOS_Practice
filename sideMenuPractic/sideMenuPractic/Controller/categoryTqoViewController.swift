//
//  categoryTqoViewController.swift
//  sideMenuPractic
//
//  Created by heawon on 2021/01/30.
//

import UIKit

class categoryTqoViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize: CGRect = UIScreen.main.bounds
        let myView = UIView(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 90))
        myView.backgroundColor = UIColor(red: 0.54, green: 0.48, blue: 0.87, alpha: 1.00)
        self.view.addSubview(myView)
        
        let frameOne = CGRect(x: 10, y: 40, width: 50, height: 50)
        let button = UIButton()
        button.frame = frameOne
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        myView.addSubview(button)

        let slideIcon = UIImage(named: "white_menu")
        let myImageView: UIImageView = UIImageView()
        myImageView.contentMode = UIView.ContentMode.scaleAspectFit
        myImageView.frame = frameOne
        myImageView.image = slideIcon
        myView.addSubview(myImageView)

        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 108, y: 40, width: 200, height: 50)
        myLabel.text = "Everyday Moments"
        myLabel.textAlignment = .center
        myLabel.textColor = UIColor.white
  
        myLabel.font = UIFont.init(name: "Futura", size: 17)
       // myLabel.font = UIFont.boldSystemFont(ofSize: 17)
        myView.addSubview(myLabel)
    
    }
    @objc func buttonAction(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideMenuViewController: SideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        let menu = CustomSideMenuNavigation(rootViewController: sideMenuViewController)
        present(menu, animated: true, completion: nil)     }
}
