//
//  ViewController.swift
//  tabBarPractice
//
//  Created by heawon on 2021/02/03.
//

import UIKit

class TapBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let homeVC = UINavigationController.init(rootViewController: HomeViewController())
        let secondVC = UINavigationController.init(rootViewController: SecondTableViewController())
        let thirdVC = UINavigationController.init(rootViewController: ThirdViewController())
 
        self.viewControllers = [homeVC, secondVC, thirdVC]
        self.selectedViewController = homeVC
       
       //  tab Bar items
        let firstItem = UITabBarItem(title: "home", image: UIImage(systemName:"house.circle"), selectedImage: UIImage(systemName:("house.circle.fill")))
        let secondItem = UITabBarItem(title: "contents", image: UIImage(systemName: "text.book.closed"), selectedImage: UIImage(systemName: "text.book.closed.fill"))
        let thirdItem = UITabBarItem(title: "profile", image: UIImage(systemName:"person.crop.circle"), selectedImage: UIImage(systemName:"person.crop.circle.fill"))

        homeVC.tabBarItem = firstItem
        secondVC.tabBarItem = secondItem
        thirdVC.tabBarItem = thirdItem
    }
}







//    let titleLabel : UILabel = {
//       let label = UILabel()
//        label.text = "First Main Page"
//        label.textAlignment = .center
//        label.textColor = .black
//        label.font = UIFont.systemFont(ofSize: 20)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    //  view.backgroundColor = .white
    //  view.addSubview(titleLabel)
//        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
      //ViewController
