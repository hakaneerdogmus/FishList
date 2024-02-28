//
//  ViewController.swift
//  FishList
//
//  Created by Hakan ERDOĞMUŞ on 26.02.2024.
//

import UIKit
import SnapKit

class SignInView: UIViewController {
    
    private var signInViewModel: SignInViewModel!
    
    private var imageView: UIImageView!
    private var welcomeTextLabel: UILabel!
    private var emailTextLabel: UILabel!
    private var emailTextField: UITextField!
    private var passwordTextLabel: UILabel!
    private var passwordTextField: UITextField!
    var showPasswordButton: UIButton!
    private var forgotPasswordButton: UIButton!
    private var loginButton: UIButton!
    private var accountTextLabel: UILabel!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        signInViewModel = SignInViewModel(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        signInViewModel.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // Mask oluştur
        let maskLayer = Theme.maskLayer(imageView: imageView)

        // Layer'a maskeyi uygula
        imageView.layer.mask = maskLayer
    }
    
    
    //Back graound Color
    func gradientColor(startColor: UIColor, endColor: UIColor) {
        let gradientLayer = Theme.gradientLayerColor(startColor: startColor, endColor: endColor)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    //Picture View
    func configurePictureLabel() {
        imageView = UIImageView(image: UIImage(named: signInViewModel.model.pictureText))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        //imageView.layer.cornerRadius = CGFloat(Theme.imageViewCorerRadius)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.top.right.left.equalToSuperview()
            make.height.equalTo(view.snp.height).multipliedBy(Theme.imageViewHeightMultipliedBy)
        }
    }
    //SignIn Title
    func configureWelcomeLabel() {
        welcomeTextLabel = UILabel(frame: .zero)
        welcomeTextLabel.translatesAutoresizingMaskIntoConstraints = false
        welcomeTextLabel.text = signInViewModel.model.welcomeText
        welcomeTextLabel.textColor = .black
        welcomeTextLabel.font = Theme.welcomeTextFontBold
        view.addSubview(welcomeTextLabel)
        
        welcomeTextLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(Theme.topWelcomeTextOffset)
            make.leading.equalToSuperview().offset(Theme.leadingOffset)
        }
    }
    //Email Text Label
    func configureEmailTextLabel() {
        emailTextLabel = UILabel(frame: .zero)
        emailTextLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextLabel.text = signInViewModel.model.emailText
        emailTextLabel.textColor = .black
        view.addSubview(emailTextLabel)
        
        emailTextLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeTextLabel.snp.bottom).offset(Theme.emailTopOffset)
            make.leading.equalToSuperview().offset(Theme.leadingOffset)
        }
    }
    //Email Text Field
    func configureEmailTextField() {
        emailTextField = UITextField(frame: .zero)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.attributedPlaceholder = NSAttributedString(string: signInViewModel.model.emailPlaceholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        emailTextField.keyboardType = .emailAddress
        emailTextField.borderStyle = .none
        emailTextField.layer.borderWidth = Theme.layerBorderWidth
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.cornerRadius = Theme.layerCornerRadius
        emailTextField.textColor = .black
        emailTextField.textAlignment = .left
        emailTextField.leftView = Theme.leftPaddingView(textFieldHeight: emailTextField.frame.height)
        emailTextField.leftViewMode = .always
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextLabel.snp.bottom)
            make.leading.equalToSuperview().offset(Theme.leadingOffset)
            make.trailing.equalToSuperview().offset(-Theme.leadingOffset)
            make.height.equalTo(Theme.textFieldSize)
        }
    }
    //Password Text Label
    func configurePasswordTextLabel() {
        passwordTextLabel = UILabel(frame: .zero)
        passwordTextLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextLabel.text = signInViewModel.model.passwordText
        passwordTextLabel.textColor = .black
        view.addSubview(passwordTextLabel)
        
        passwordTextLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Theme.emailTopOffset)
            make.leading.equalToSuperview().offset(Theme.leadingOffset)
        }
    }
    //Password Text Field
    func configurePasswordTextField() {
        passwordTextField = UITextField(frame: .zero)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.attributedPlaceholder = NSAttributedString(string: signInViewModel.model.passwordPlaceholderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .black
        passwordTextField.borderStyle = .none
        passwordTextField.layer.borderWidth = Theme.layerBorderWidth
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.cornerRadius = Theme.layerCornerRadius
        passwordTextField.textAlignment = .left
        passwordTextField.leftView = Theme.leftPaddingView(textFieldHeight: passwordTextField.frame.height)
        passwordTextField.leftViewMode = .always
        view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextLabel.snp.bottom)
            make.leading.equalToSuperview().offset(Theme.leadingOffset)
            make.trailing.equalToSuperview().offset(-Theme.leadingOffset)
            make.height.equalTo(Theme.textFieldSize)
        }
        
        showPasswordButton = UIButton(type: .system)
        showPasswordButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        showPasswordButton.tintColor = .gray
        showPasswordButton.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
        view.addSubview(showPasswordButton)
        
        showPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(passwordTextField)
            make.trailing.equalToSuperview().offset(Theme.passWordButtonOffset)
        }
    }
    //Password hide show tapped
    @objc func showPasswordButtonTapped() {
        signInViewModel.showPasswordButtonTapped(passwordTextField: passwordTextField)
    }
    //Forgot Password Button
    func configureForgotPasswordButton() {
        forgotPasswordButton = UIButton(type: .system)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.setTitle(signInViewModel.model.forgotPassword, for: .normal)
        forgotPasswordButton.setTitleColor(UIColor.blue, for: .normal)
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        view.addSubview(forgotPasswordButton)
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Theme.topOffset10)
            make.right.equalTo(passwordTextField.snp.right)
        }
    }
    //Forgot password button tapped
    @objc func forgotPasswordTapped() {
        signInViewModel.forgotPasswordTapped()
    }
    //Login Button
    func configureLoginButton() {
        loginButton = UIButton(type: .system)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle(signInViewModel.model.loginButtonTitleText, for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.backgroundColor  = .blue
        loginButton.layer.cornerRadius = Theme.buttonCornerRadius
        loginButton.titleLabel?.font = Theme.buttonTittleFont
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(Theme.topOffset25)
            make.leading.equalToSuperview().offset(Theme.leadingOffset)
            make.trailing.equalToSuperview().offset(-Theme.leadingOffset)
            make.height.equalTo(Theme.textFieldSize)
        }
    }
    //Login button tapped
    @objc func loginButtonTapped() {
        signInViewModel.loginButtonTapped()
    }
    //Account Text Label
    func configurationAccountTextLabel() {
        accountTextLabel = UILabel(frame: .zero)
        accountTextLabel.translatesAutoresizingMaskIntoConstraints = false
        accountTextLabel.text = signInViewModel.model.dontHaveAnAccount
        accountTextLabel.textColor = .black
        
        let signUpButton = UIButton(type: .system)
        signUpButton.setTitle(signInViewModel.model.signUpButtonText, for: .normal)
        signUpButton.titleLabel?.textColor = .blue
        signUpButton.titleLabel?.attributedText = NSAttributedString(string: signInViewModel.model.signUpButtonText, attributes: [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue])
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [accountTextLabel, signUpButton])
            stackView.axis = .horizontal
            stackView.alignment = .center
        stackView.spacing = Theme.spacing // İki eleman arasındaki boşluk
            view.addSubview(stackView)
            
            stackView.snp.makeConstraints { make in
                make.top.equalTo(loginButton.snp.bottom).offset(Theme.topOffset10)
                make.centerX.equalToSuperview()
            }
    }
    //SignUp Button Tapped
    @objc func signUpTapped() {
        signInViewModel.signUpButtonTapped()
        signInViewModel.navigateToPage(viewController: SignUpView())
    }
}

