//
//  SignUpViewModel.swift
//  FishList
//
//  Created by Hakan ERDOĞMUŞ on 27.02.2024.
//

import UIKit
import SafariServices

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
        self.view?.navigationController?.popViewController(animated: true)
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
        guard let name = self.view?.nameTextField.text, !name.isEmpty,
              let email = self.view?.emailTextField.text, !email.isEmpty,
              let password = self.view?.passwordTextField.text, !password.isEmpty else { return }
        
        FirebaseManager.shared.signUpWithEmail(email: email, password: password) { [weak self] authResult ,error in
           // guard let view = self?.view else { return }
            
            if let error = error {
                print("Kullanıcı kaydedilirken bir hata oluştu: \(error.localizedDescription)")
            } else {
                guard let authUid = authResult?.user.uid else  {
                    print("authUid Error")
                    return
                }
                FirebaseManager.shared.saveUserToDatabase(name: name, email: email, uid: authUid) { [weak self] error in
                    guard let view = self?.view else { return }
                    
                    
                    if let error = error {
                        print("Kullanıcı kayıt hatası: \(error.localizedDescription)")
                    } else {
                        print("Kullanıcı kayıt başarılı")
                        view.nameTextField.text = ""
                        view.emailTextField.text = ""
                        view.passwordTextField.text = ""
                        view.navigationController?.popViewController(animated: true)
                    }
                }
            }
        }
        

    }
    //Privacy Policy Button Tapped
    func privacyPolicyButtonTapped() {
        print("Privacy Policy")
        
        if let url = URL(string: "https://wheeldesicionspinwheel.godaddysites.com/privacy-policy") {
            let safatiViewController = SFSafariViewController(url: url)
            self.view?.present(safatiViewController, animated: true)
        }
    }
}
