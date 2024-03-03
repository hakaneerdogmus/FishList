//
//  HomeView.swift
//  FishList
//
//  Created by Hakan ERDOĞMUŞ on 1.03.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

class HomeView: UIViewController {
    
    var signOutButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
        
        signOutButton = UIButton(frame: .zero)
        signOutButton.setTitle("SignOut", for: .normal)
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
        view.addSubview(signOutButton)
        
        signOutButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    @objc func signOutButtonTapped() {
        print("Sign Out")
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
