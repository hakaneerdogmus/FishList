//
//  SignUpViewModel.swift
//  FishList
//
//  Created by Hakan ERDOĞMUŞ on 27.02.2024.
//

import Foundation

class SignUpViewModel {
    let model = SignUpModel()
    private let view: SignUpView!
    
    init(view: SignUpView!) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.view.backgroundColor = .red
    }
}
