//
//  SignUpViewModel.swift
//  FishList
//
//  Created by Hakan ERDOĞMUŞ on 27.02.2024.
//

import UIKit

class SignUpViewModel {
    let model = SignUpModel()
    private let view: SignUpView?
    
    init(view: SignUpView!) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.gradientColor(startColor: Theme.startColor, endColor: Theme.endColor)
        view?.configurationSignUpLabel()
        view?.configurationalreadyHaveAnAccountLabel()
        view?.configurationNameLabel()
        view?.configurationNameTextField()
        view?.configurationEmailTextLabel()
        view?.configurationEmailTextField()
        view?.configurationPaswordTextLabel()
        view?.configurationPasswordTextField()
        view?.configureSignUpButton()
        view?.configurePrivacyLabel()
    }
    //Already Have An Account Login Label
    func loginTextTapped() {
        print("alreadyHaveAnAccountLabel Login Tapped")
    }
    //Password hide show
    func showPasswordButtonTapped(passwordTextField: UITextField) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" :"eye.fill"
        view?.showPasswordButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    // Sign Up Button Tapped
    func signUpButtonTapped() {
        print("Sign Up Button Tapped")
    }
    //Privacy Policy Button Tapped
    func privacyPolicyButtonTapped() {
        print("Privacy Policy")
    }
}
