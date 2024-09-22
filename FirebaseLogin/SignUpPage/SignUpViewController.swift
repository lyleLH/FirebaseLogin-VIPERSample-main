//
//  SignUpViewController.swift
//  FirebaseLogin
//
//  Created by Sezgin on 24.04.2022.
//

import UIKit

protocol SignUpViewProtocol: AnyObject {
    func userCreated()
    func userNotCreated()
}

class SignUpViewController: UIViewController, SignUpViewProtocol {
    
    var presenter: SignUpPresenterProtocol?
    
    private var userNameTextField: UITextField = {
        let textField = MakeProperty.makeTextField("username")
        textField.autocapitalizationType = .none
        textField.becomeFirstResponder()
        return textField
    }()
    
    private var passwordTextField: UITextField = {
        let textField = MakeProperty.makeTextField("password")
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        return textField
    }()
    
    private var passwordAgainTextField: UITextField = {
        let textField = MakeProperty.makeTextField("password again")
        textField.isSecureTextEntry = true
        textField.textContentType = .oneTimeCode
        return textField
    }()
    
    private var signInAppButton: UIButton = {
        let button = MakeProperty.makeLoginButton("Create User")
        button.addTarget(SignUpViewController.self, action: #selector(handleCreateUserButton), for: .touchUpInside)
        return button
    }()
    
    private var facebookLoginButton: UIButton = {
        let button = MakeProperty.makeIconButton()
        button.addTarget(SignUpViewController.self, action: #selector(handleOAuth2LoginButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
    
    @objc private func handleOAuth2LoginButton() {
        presenter?.notifyOauth2CreateUserButtonTapped()

    }
    
    @objc private func handleCreateUserButton() {
        if userNameTextField.text != "" && passwordTextField.text != "" && passwordAgainTextField.text != "" {
            if passwordTextField.text == passwordAgainTextField.text {
                guard let username = userNameTextField.text else { return }
                guard let password = passwordTextField.text else { return }
                presenter?.notifyCreateUserButtonTapped(username: username, password: password)
                
            } else {
                self.showCommonAlert(title: "Error!", message: "Passwords are not matched!")
            }
        } else {
            self.showCommonAlert(title: "Error!", message: "You should fill every single field!")
        }
    }
    
    func userCreated() {
        let alert = UIAlertController(title: "Success", message: "User is created successfully!", preferredStyle: .actionSheet)
        present(alert, animated: true) { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.dismiss(animated: true, completion: nil)
                self.presenter?.routeToMain()
            }
        }
    }
    
    func userNotCreated() {
        let alert = UIAlertController(title: "Error!", message: "Something went wrong! Try again.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { [weak self] _ in
            guard let self = self else { return }
            self.userNameTextField.text = nil
            self.passwordTextField.text = nil
            self.userNameTextField.becomeFirstResponder()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    private func configureUI() {
        view.backgroundColor = UIColor(red: 248/255, green: 248/255, blue: 1, alpha: 1)
        
        view.addSubview(userNameTextField)
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 100),
            userNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            userNameTextField.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(passwordAgainTextField)
        NSLayoutConstraint.activate([
            passwordAgainTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordAgainTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            passwordAgainTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordAgainTextField.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(signInAppButton)
        NSLayoutConstraint.activate([
            signInAppButton.topAnchor.constraint(equalTo: passwordAgainTextField.bottomAnchor, constant: 60),
            signInAppButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInAppButton.heightAnchor.constraint(equalToConstant: 50),
            signInAppButton.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(facebookLoginButton)
        NSLayoutConstraint.activate([
            facebookLoginButton.topAnchor.constraint(equalTo: signInAppButton.bottomAnchor, constant: 60),
            facebookLoginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            facebookLoginButton.heightAnchor.constraint(equalToConstant: 50),
            facebookLoginButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        facebookLoginButton.layer.cornerRadius = 25
        facebookLoginButton.layer.borderWidth = 1.0
        facebookLoginButton.layer.borderColor = UIColor(red: 248/255, green: 248/255, blue: 0.7, alpha: 1).cgColor
    }
}

extension UIViewController {
    func showCommonAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
