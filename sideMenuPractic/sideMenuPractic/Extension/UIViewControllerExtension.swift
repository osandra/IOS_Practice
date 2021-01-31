//
//  UIViewControllerExtension.swift
//  sideMenuPractic
//
//  Created by heawon on 2021/01/30.
//

import UIKit
//여러 뷰 컨트롤러에서 해당 함수 기능을 사용하므로, 익스텐션에 해당 기능 추가
extension UIViewController {
    func showSlideMenu(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sideMenuViewController: SideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        let menu = CustomSideMenuNavigation(rootViewController: sideMenuViewController)
        present(menu, animated: true, completion: nil)
    }
}
