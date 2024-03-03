//
//  SignUpView.swift
//  FishList
//
//  Created by Hakan ERDOĞMUŞ on 27.02.2024.
//

import UIKit
import SnapKit

class SignUpView: UIViewController, UITextFieldDelegate {
    
    private var signUpViewModel: SignUpViewModel!
    
    private var signUpTextLabel: UILabel!
    private var alreadyHaveAnAccountLabel: UILabel!
    private var nameTextLabel: UILabel!
    var nameTextField: UITextField!
    private var emailTextLabel: UILabel!
    var emailTextField: UITextField!
    private var passwordTextLabel: UILabel!
    var passwordTextField: UITextField!
    var showPasswordButton: UIButton!
    private var signUpButton: UIButton!
    private var privacyLabel: UILabel!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        signUpViewModel = SignUpViewModel(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpViewModel.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    // UITapGestureRecognizer tarafından çağrılacak fonksiyon
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            switch textField {
            case nameTextField:
                emailTextField.becomeFirstResponder()
            case emailTextField:
                passwordTextField.becomeFirstResponder()
            case passwordTextField:
                passwordTextField.resignFirstResponder()
            default:
                break
            }
            return true
        }
    
    
    //Back graound Color
    func gradientColor(startColor: UIColor, endColor: UIColor) {
        let gradientLayer = Theme.gradientLayerColor(startColor: startColor, endColor: endColor)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    //SignUp Label
    func configurationSignUpLabel() {
        signUpTextLabel = UILabel(frame: .zero)
        signUpTextLabel.text = signUpViewModel.model.signUpText
        signUpTextLabel.textColor = .black
        signUpTextLabel.font = Theme.titleFontBold
        view.addSubview(signUpTextLabel)
        
        signUpTextLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalTo(Theme.leadingOffset)
        }
    }
    //Already Have An Account Label
    func configurationalreadyHaveAnAccountLabel() {
        alreadyHaveAnAccountLabel = UILabel(frame: .zero)
        alreadyHaveAnAccountLabel.text = signUpViewModel.model.alreadyHaveAnAccountText
        alreadyHaveAnAccountLabel.textColor = .black
        view.addSubview(alreadyHaveAnAccountLabel)
        
        let attributedText = NSMutableAttributedString(string: signUpViewModel.model.alreadyHaveAnAccountText)
        let buttonRange = (signUpViewModel.model.alreadyHaveAnAccountText as NSString).range(of: "Login")
        attributedText.addAttribute(.foregroundColor, value: UIColor.blue, range: buttonRange)
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: buttonRange)
        alreadyHaveAnAccountLabel.attributedText = attributedText
        alreadyHaveAnAccountLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(loginTextTapped))
        alreadyHaveAnAccountLabel.addGestureRecognizer(tapGesture)
        
        
        alreadyHaveAnAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpTextLabel.snp.bottom).offset(Theme.topOffset10)
            make.leading.equalTo(signUpTextLabel.snp.leading)
        }
    }
    //alreadyHaveAnAccountLabel Login Tapped
    @objc func loginTextTapped() {
        signUpViewModel.loginTextTapped()
    }
    //Name Label
    func configurationNameLabel() {
        nameTextLabel = UILabel(frame: .zero)
        nameTextLabel.text = signUpViewModel.model.nameText
        nameTextLabel.textColor = .black
        nameTextLabel.font = Theme.bodyFontBold
        view.addSubview(nameTextLabel)
        
        nameTextLabel.snp.makeConstraints { make in
            make.top.equalTo(alreadyHaveAnAccountLabel.snp.bottom).offset(Theme.topOffset25)
            make.leading.equalTo(alreadyHaveAnAccountLabel.snp.leading)
        }
    }
    //Name TextField
    func configurationNameTextField() {
        nameTextField = UITextField(frame: .zero)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.attributedPlaceholder = NSAttributedString(string: signUpViewModel.model.namePlaceHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        nameTextField.keyboardType = .emailAddress
        nameTextField.borderStyle = .none
        nameTextField.layer.borderWidth = Theme.layerBorderWidth
        nameTextField.layer.borderColor = UIColor.black.cgColor
        nameTextField.layer.cornerRadius = Theme.layerCornerRadius
        nameTextField.textColor = .black
        nameTextField.textAlignment = .left
        nameTextField.leftView = Theme.leftPaddingView(textFieldHeight: nameTextField.frame.height)
        nameTextField.leftViewMode = .always
        nameTextField.returnKeyType = .next
        nameTextField.delegate = self
        view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextLabel.snp.bottom)
            make.leading.equalToSuperview().offset(Theme.leadingOffset)
            make.trailing.equalToSuperview().offset(-Theme.leadingOffset)
            make.height.equalTo(Theme.textFieldSize)
        }
    }
    //Email Label
    func configurationEmailTextLabel() {
        emailTextLabel = UILabel(frame: .zero)
        emailTextLabel.text = signUpViewModel.model.emailPlaceHolderText
        emailTextLabel.textColor = .black
        emailTextLabel.font = Theme.bodyFontBold
        view.addSubview(emailTextLabel)
        
        emailTextLabel.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(Theme.topOffset25)
            make.leading.equalTo(alreadyHaveAnAccountLabel.snp.leading)
        }
    }
    //Email TextField
    func configurationEmailTextField() {
        emailTextField = UITextField(frame: .zero)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.attributedPlaceholder = NSAttributedString(string: signUpViewModel.model.emailPlaceHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        emailTextField.keyboardType = .emailAddress
        emailTextField.borderStyle = .none
        emailTextField.layer.borderWidth = Theme.layerBorderWidth
        emailTextField.layer.borderColor = UIColor.black.cgColor
        emailTextField.layer.cornerRadius = Theme.layerCornerRadius
        emailTextField.textColor = .black
        emailTextField.textAlignment = .left
        emailTextField.leftView = Theme.leftPaddingView(textFieldHeight: emailTextField.frame.height)
        emailTextField.autocapitalizationType = .none
        emailTextField.leftViewMode = .always
        emailTextField.returnKeyType = .next
        emailTextField.delegate = self
        view.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextLabel.snp.bottom)
            make.leading.equalToSuperview().offset(Theme.leadingOffset)
            make.trailing.equalToSuperview().offset(-Theme.leadingOffset)
            make.height.equalTo(Theme.textFieldSize)
        }
    }
    //Password Label
    func configurationPaswordTextLabel() {
        passwordTextLabel = UILabel(frame: .zero)
        passwordTextLabel.text = signUpViewModel.model.passwordText
        passwordTextLabel.textColor = .black
        passwordTextLabel.font = Theme.bodyFontBold
        view.addSubview(passwordTextLabel)
        
        passwordTextLabel.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(Theme.topOffset25)
            make.leading.equalTo(alreadyHaveAnAccountLabel.snp.leading)
        }
    }
    //Password TextField
    func configurationPasswordTextField() {
        passwordTextField = UITextField(frame: .zero)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.attributedPlaceholder = NSAttributedString(string: signUpViewModel.model.passwordPlaceHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textColor = .black
        passwordTextField.borderStyle = .none
        passwordTextField.layer.borderWidth = Theme.layerBorderWidth
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.cornerRadius = Theme.layerCornerRadius
        passwordTextField.textAlignment = .left
        passwordTextField.leftView = Theme.leftPaddingView(textFieldHeight: passwordTextField.frame.height)
        passwordTextField.leftViewMode = .always
        passwordTextField.returnKeyType = .done
        passwordTextField.delegate = self
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
    //Show Password Button Tapped
    @objc func showPasswordButtonTapped() {
        signUpViewModel.showPasswordButtonTapped(passwordTextField: passwordTextField)
    }
    //Sig Up Button
    func configureSignUpButton() {
        signUpButton = UIButton(type: .system)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.setTitle(signUpViewModel.model.signUpButtonTitleText, for: .normal)
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.backgroundColor  = .blue
        signUpButton.layer.cornerRadius = Theme.buttonCornerRadius
        signUpButton.titleLabel?.font = Theme.buttonTittleFont
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(Theme.topOffset50)
            make.leading.equalToSuperview().offset(Theme.leadingOffset)
            make.trailing.equalToSuperview().offset(-Theme.leadingOffset)
            make.height.equalTo(Theme.textFieldSize)
        }
    }
    //Login button tapped
    @objc func signUpButtonTapped() {
        signUpViewModel.signUpButtonTapped()
    }
    //Privacy Label
    func configurePrivacyLabel() {
        privacyLabel = UILabel(frame: .zero)
        privacyLabel.text = signUpViewModel.model.privacyPolicyText
        privacyLabel.textColor = .gray
        privacyLabel.numberOfLines = 0
        view.addSubview(privacyLabel)
        
        let attributedText = NSMutableAttributedString(string: signUpViewModel.model.privacyPolicyText)
        let buttonRange = (signUpViewModel.model.privacyPolicyText as NSString).range(of: "Privacy Policy")
        attributedText.addAttribute(.foregroundColor, value: UIColor.black, range: buttonRange)
        attributedText.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: buttonRange)
        privacyLabel.attributedText = attributedText
        privacyLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(privacyPolicyButtonTapped))
        privacyLabel.addGestureRecognizer(tapGesture)
        
        
        privacyLabel.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(Theme.topOffset25)
            make.leading.equalTo(signUpButton.snp.leading)
            make.trailing.equalTo(signUpButton.snp.trailing)
        }
    }
    //Privacy Polict Button Tapped
    @objc func privacyPolicyButtonTapped() {
        signUpViewModel.privacyPolicyButtonTapped()
    }
}
