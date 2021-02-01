//
//  categoryTqoViewController.swift
//  sideMenuPractic
//
//  Created by heawon on 2021/01/30.
//

import UIKit

class categoryTqoViewController: UIViewController {
    @IBOutlet weak var customViewCell: ResuableCustomView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func customViewTapped(_ sender: ResuableCustomView) {
        self.showSlideMenu()
    }
}
