//
//  UIViewControllerExtension.swift
//  sideMenuPractic
//
//  Created by heawon on 2021/01/30.
//

import UIKit
extension UIViewController {
    func showSlideMenu(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideMenuViewController: SideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        let menu = CustomSideMenuNavigation(rootViewController: sideMenuViewController)
        present(menu, animated: true, completion: nil)
    }
}
