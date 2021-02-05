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
    
    var settingImage: UIImageView = {
        var image = UIImage(named: "setting")
        var imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(settingImage)
        
        //layout 설정
        NSLayoutConstraint.activate([
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
        settingImage.widthAnchor.constraint(equalToConstant: 20.0),
        settingImage.heightAnchor.constraint(equalToConstant: 20.0),
        settingImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60.0),
        settingImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20.0)
        ])
        
        //이미지가 탭 제스처에 반응하도록
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.touchSettingImage(tapGesture:)))
        settingImage.addGestureRecognizer(tapGesture)
        settingImage.isUserInteractionEnabled = true
    }
    
    @objc func touchSettingImage(tapGesture: UITapGestureRecognizer) {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
       

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
