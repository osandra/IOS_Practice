//
//  sideMenu.swift
//  sideMenuPractic
//
//  Created by heawon on 2021/01/30.
//

import Foundation

import UIKit
import SideMenu

//customize sidemenu style
class CustomSideMenuNavigation: SideMenuNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.leftSide = true
        self.menuWidth = 250
        self.presentationStyle = SideMenuPresentationStyle.menuSlideIn
    }
}
