//
//  SideMenuViewController.swift
//  sideMenuPractic
//
//  Created by heawon on 2021/01/30.
//

import UIKit

class SideMenuViewController: UIViewController {
    //SideMenuViewController가 CustomSideMenuNavigation의 루트뷰컨트롤러라서 nav바가 생성됨. nav바 부분 안 보이게 하기 위해 .isNavigationBarHidden = true 로 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
    }
}
