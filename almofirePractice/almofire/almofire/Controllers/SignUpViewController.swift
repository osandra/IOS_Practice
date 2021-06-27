//
//  SignUpViewController.swift
//  almofire
//
//  Created by heawon on 2021/04/03.
//

import UIKit

class SignUpViewController: UIViewController,UITextFieldDelegate {
    public var completion: (()->Void)?
    
    private let usernameField: CustomTextField = {
        let field = CustomTextField()
        field.placeholder = "이름을 입력해주세요."
        return field
    }()
    
    
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
    
    private let passwordConformField: CustomTextField = {
        let passwordField = CustomTextField()
        passwordField.isSecureTextEntry = true
        passwordField.placeholder = "비밀번호를 확인해주세요."
        return passwordField
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.backgroundColor = UIColor(red: 0.33, green: 0.32, blue: 0.93, alpha: 1.00)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "회원가입"
        addSubviews()
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usernameField.frame = CGRect(x: 50, y: view.safeAreaInsets.top+50, width: view.width-100, height: 50)
        emailField.frame = CGRect(x: 50, y: usernameField.bottom+20, width: view.width-100, height: 50)
        passwordField.frame = CGRect(x: 50, y: emailField.bottom+20, width: view.width-100, height: 50)
        passwordConformField.frame = CGRect(x: 55, y: passwordField.bottom+20, width: view.width-100, height: 50)
        signUpButton.frame = CGRect(x: 75, y: passwordConformField.bottom+50, width: view.width-150, height: 40)
    }
    //MARK: - Method
    private func addSubviews(){
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(signUpButton)
        view.addSubview(passwordConformField)
    
        signUpButton.addTarget(self, action: #selector(signUp), for: .touchUpInside)
    }
    
    @objc func signUp(){
        guard let username = usernameField.text,
              let email = emailField.text,
              let password = passwordField.text,
              let passwordConform = passwordConformField.text,
              username.count > 0,
              email.count > 0,
              password.count > 0,
              passwordConform.count > 0,
              passwordConform == password else {return}

        //서버 호출
        APICaller.shared.join(username: username, email: email, password: password) { [weak self] (result) in //만약 성공이면 UserDefaults에 이메일, 유저 이름 저장
            if result {
                UserDefaults.standard.setValue(email, forKey: "email")
                UserDefaults.standard.setValue(username, forKey: "username")
                self?.completion?() //go to PhotoSearchVC
            }
            else {
                print("sigunVC result fail")
                }
            }
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        }
        else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}
