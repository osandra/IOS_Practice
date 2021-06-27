//
//  LoginViewController.swift
//  almofire
//
//  Created by heawon on 2021/03/31.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate {
    //MARK: - Property
    private let emailField: CustomTextField = {
        let emailField = CustomTextField()
        emailField.placeholder = "이메일을 입력해주세요."
        return emailField
    }()
    
    private let passwordField: CustomTextField = {
        let passwordField = CustomTextField()
        passwordField.isSecureTextEntry = true
        passwordField.placeholder = "비밀번호를 입력해주세요."
        return passwordField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = UIColor(red: 0.33, green: 0.32, blue: 0.93, alpha: 1.00)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        button.setTitle("회원가입", for: .normal)
        return button
    }()
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "로그인"
        addSubviews()
        emailField.delegate = self
        passwordField.delegate = self
        navigationController?.navigationBar.tintColor = .label
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        emailField.frame = CGRect(x: 50, y: view.safeAreaInsets.top+50, width: view.width-100, height: 50)
        passwordField.frame = CGRect(x: 50, y: emailField.bottom+20, width: view.width-100, height: 50)
        loginButton.frame = CGRect(x: 75, y: passwordField.bottom+50, width: view.width-150, height: 40)
        createAccountButton.frame = CGRect(x: 75, y: loginButton.bottom+70, width: view.width-150, height: 40)
    }
    
    //MARK: - Method
    private func addSubviews(){
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        loginButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)

    }
    
    @objc func goToSignUp(){
        let vc = SignUpViewController()
        vc.completion = { [weak self] in
            self?.moveToPhotoVC()
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func alertBackgroundTapped(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func moveToPhotoVC(){
        let photoSearchVC = PhotoSeachViewController()
        let navVC = UINavigationController(rootViewController:photoSearchVC)
        navVC.modalTransitionStyle = .crossDissolve
        navVC.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }
    
    @objc func signIn(){
        guard let email = emailField.text,
              let password = passwordField.text,
              email.count > 0,
              password.count > 0 else {return}
        APICaller.shared.signUserIn(email: email, password: password) { [weak self] (result) in
            if (result){
                //succes
                self?.moveToPhotoVC()
                UserDefaults.standard.setValue(email, forKey: "email")
            }
            else {
                //fail
                let alert = UIAlertController(title: "로그인에 실패했습니다.", message: nil, preferredStyle: .alert)
                self?.present(alert, animated: true){
                    alert.view.superview?.isUserInteractionEnabled = true
                    alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self?.alertBackgroundTapped)))
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
