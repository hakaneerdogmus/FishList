//
//  FireBaseManager.swift
//  FishList
//
//  Created by Hakan ERDOĞMUŞ on 29.02.2024.
//

import Firebase

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    private let databaseRef: DatabaseReference
    
    private init() {
        databaseRef = Database.database().reference()
    }
    //RealTime DataBase saved
    func saveUserToDatabase(name: String, email: String, uid: String, completion: @escaping (Error?) -> Void) {
        // Kullanıcının daha önce kayıtlı olup olmadığını kontrol etmek için email'i kullanabilirsiniz
        databaseRef.child("users").queryOrdered(byChild: "email").queryEqual(toValue: email).observeSingleEvent(of: .value) { [self] snapshot in
            if snapshot.exists() {
                // Kullanıcı zaten kayıtlı
                print("Kullanıcı zaten kayıtlı.")
                completion(nil) // Hata olmadığını belirtmek için nil gönderiyoruz
            } else {
                // Kullanıcı henüz kayıtlı değil, verileri kaydet
                let user = ["name": name, "email": email, "authUid": uid]
                
                let userID = databaseRef.child("users").childByAutoId().key!
                
                databaseRef.child("users").child(userID).setValue(user) { (error, ref) in
                    completion(error)
                }
            }
        }
    }
    //Authentication save
    func signUpWithEmail(email: String, password: String, completion: @escaping (AuthDataResult?,Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            
            completion(authResult, error)
            
        }
    }
    //User Login
    func loginUser(withEmail email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                completion(.failure(error))
            } else if let user = authResult?.user {
                self.databaseRef.child("users").queryOrdered(byChild: "email").queryEqual(toValue: email).observeSingleEvent(of: .value) { snapshot in
                    if snapshot.exists() {
                        // Kullanıcı zaten kayıtlı
                        print("Kullanıcı zaten kayıtlı.")
                        completion(.success(user)) // Hata olmadığını belirtmek için nil gönderiyoruz
                    }
                    
                }
            }
            
        }
        //Read RealTimeDataBase
        func readUserData(completion: @escaping (Result<UserData, Error>) -> Void) {
            guard let userId = Auth.auth().currentUser?.uid else {
                completion(.failure(FirebaseError.userNotAuthenticated))
                return
            }
            print(userId)
            let ref = Database.database().reference().child("users")
            
            ref.observeSingleEvent(of: .value) { snapshot, error in
                
                if let error = error {
                    completion(.failure(error as! Error))
                    return
                }
                
                
                
                if let userData = snapshot.value as? [String: Any] {
                    let name = userData["name"] as? String ?? ""
                    let email = userData["email"] as? String ?? ""
                    let userData = UserData(name: name, email: email)
                    
                    completion(.success(userData))
                } else {
                    completion(.failure(FirebaseError.dataNotFound))
                }
            }
        }
    }
}

enum FirebaseError: Error {
    case userNotAuthenticated
    case dataNotFound
}
