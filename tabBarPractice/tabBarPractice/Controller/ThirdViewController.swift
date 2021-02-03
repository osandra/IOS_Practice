//
//  ThirdViewController.swift
//  tabBarPractice
//
//  Created by heawon on 2021/02/03.
//

import UIKit

class ThirdViewController: UIViewController {
    let titleLabel : UILabel = {
       let label = UILabel()
        label.text = "Profile Page"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        view.addSubview(titleLabel)
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let leftItem = UIBarButtonItem(title: "Profile",
                                           style: .done,
                                           target: nil,
                                           action: nil)
        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationController?.navigationBar.tintColor = UIColor.black
    }
}
