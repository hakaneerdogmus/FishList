//
//  SignInViewModel.swift
//  FishList
//
//  Created by Hakan ERDOĞMUŞ on 26.02.2024.
//

import UIKit
import FirebaseAuth
import Firebase
import GoogleSignIn

class SignInViewModel {
    
    let model = SignInModel()
    private let view: SignInView?
    
    init(view: SignInView) {
        self.view = view
    }
    //ViewDidLoad
    func viewDidLoad() {
        view?.gradientColor(startColor: Theme.startColor, endColor: Theme.endColor)
        view?.configurePictureLabel()
        view?.configureWelcomeLabel()
        view?.configureEmailTextLabel()
        view?.configureEmailTextField()
        view?.configurePasswordTextLabel()
        view?.configurePasswordTextField()
        view?.configureForgotPasswordButton()
        view?.configureLoginButton()
        view?.configurationAccountTextLabel()
        view?.configureGoogleSignIn()
    }
    //Password hide show
    func showPasswordButtonTapped(passwordTextField: UITextField) {
        passwordTextField.isSecureTextEntry.toggle()
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" :"eye.fill"
        view?.showPasswordButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    //forgot password button tapped
    func forgotPasswordTapped() {
        print("Forgot password")
    }
    //login button tapped
    func loginButtonTapped() {
       // print("Login button tapped")
        guard let email = self.view?.emailTextField.text, !email.isEmpty,
              let password = self.view?.passwordTextField.text, !password.isEmpty else { return }
        
        FirebaseManager.shared.loginUser(withEmail: email , password: password) { [weak self] result in
            switch result {
            case.success(let user):
                print("Giriş Başarılı: \(user.uid)")
                self?.navigateToView(nextView: HomeView(), backButtonisHidden: true)
                self?.view?.emailTextField.text = ""
                self?.view?.passwordTextField.text = ""
            case .failure(let error):
                print("Giriş Hatası: \(error.localizedDescription)")
            }
        }
    }
    //SignUp Button Tapped
    func signUpButtonTapped() {
        print("SignUp Tapped")
        navigateToView(nextView: SignUpView(), backButtonisHidden: false)
    }
    //Navigate Sign Up View
    func navigateToView(nextView: UIViewController, backButtonisHidden: Bool) {
        let signUpView = nextView
        self.view?.navigationController?.pushViewController(signUpView, animated: true)
        self.view?.navigationController?.navigationBar.isHidden = backButtonisHidden
    }
    //google sign ın button tapped
    func googleSignInButtonTapped() {
        guard let view = self.view else { return }
        
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            print("Client ID Error")
            return
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: view) { [unowned self] result, error in
            guard error == nil else {return}
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {return}
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { authDataResult, error in
                if let error = error {
                    print("FireBase ile giriş başarısız. Hata: \(error.localizedDescription)")
                    return
                }
                
                print("Giriş Başarılı. Kullanıcı adı: \(authDataResult?.user.uid ?? "Boş") ")
                print("Giriş Başarılı. Kullanıcı adı: \(authDataResult?.user.displayName ?? "Boş") ")
                print("Giriş Başarılı. Kullanıcı adı: \(authDataResult?.user.email ?? "Boş") ")
                
                FirebaseManager.shared.saveUserToDatabase(name: authDataResult?.user.displayName ?? "Kullanıcı adı yok", email: authDataResult?.user.email ?? "Kullanıcı email yok", uid: authDataResult?.user.uid ?? "Auth Uid Yok") { [weak self] error in
                    guard let view = self?.view else { return }
                    
                    
                    if let error = error {
                        print("Kullanıcı kayıt hatası: \(error.localizedDescription)")
                    } else {
                        
                        self?.navigateToView(nextView: HomeView(), backButtonisHidden: true)
                    }
                }
                
            }
            // ...
        }
        
    }
}



