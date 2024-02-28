//
//  SignUpView.swift
//  FishList
//
//  Created by Hakan ERDOĞMUŞ on 27.02.2024.
//

import UIKit

class SignUpView: UIViewController {

    private var signUpViewModel: SignUpViewModel!
    
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
    }
    
}
