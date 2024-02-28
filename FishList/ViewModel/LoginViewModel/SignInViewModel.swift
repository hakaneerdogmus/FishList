//
//  SignInViewModel.swift
//  FishList
//
//  Created by Hakan ERDOĞMUŞ on 26.02.2024.
//

import UIKit

class SignInViewModel {
    
    let model = SignInModel()
    private let view: SignInView!
    
    init(view: SignInView) {
        self.view = view
    }
    //ViewDidLoad
    func viewDidLoad() {
        view.gradientColor(startColor: Theme.startColor, endColor: Theme.endColor)
        view.configurePictureLabel()
        view.configureWelcomeLabel()
        view.configureEmailTextLabel()
        view.configureEmailTextField()
        view.configurePasswordTextLabel()
        view.configurePasswordTextField()
        view.configureForgotPasswordButton()
        view.configureLoginButton()
        view.configurationAccountTextLabel()
    }
    //Password hide show
    func showPasswordButtonTapped(passwordTextField: UITextField) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" :"eye.fill"
        view.showPasswordButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    //forgot password button tapped
    func forgotPasswordTapped() {
        print("Forgot password")
    }
    //login button tapped
    func loginButtonTapped() {
        print("Login button tapped")
    }
    //SignUp Button Tapped
    func signUpButtonTapped() {
        print("SignUp Tapped")
    }
    //NavigateToNextPage
    func navigateToPage(viewController: UIViewController) {
        guard let navigationController = view.navigationController else {
            print("NavigationController Error")
            return
        }
        
        let nextViewController = viewController
        navigationController.pushViewController(nextViewController, animated: true)
    }
}



