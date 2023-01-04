//
//  AuthService.swift
//  Twitter
//
//  Created by Long Bảo on 04/01/2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

struct AuthCrentials {
    var email: String
    var password: String
    var fullName: String
    var userName: String
    var imageProfile: UIImage
}

class AuthService {
    static let shared = AuthService()
    private let db = Firestore.firestore()
    
    func login(email: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    func registerUser(authCretical: AuthCrentials, completion: @escaping (Error?) -> Void) {
        let email = authCretical.email
        let password = authCretical.password
        let fullName = authCretical.fullName
        let userName = authCretical.userName
        let imageProfile = authCretical.imageProfile
        
        guard let imageData = imageProfile.jpegData(compressionQuality: 0.3) else {return}   //nén ảnh
        let fileNameImage = NSUUID().uuidString                                              // Tạo id có dạng string random.
        
            
        let imageRefer = Storage.storage().reference().child(fileNameImage)
        
        imageRefer.putData(imageData, metadata: nil) { (meta, err) in
            imageRefer.downloadURL { url, err in
                if let e = err {
                    print("DEBUG: err \(e.localizedDescription)")
                } else {
                    guard let profileImageURL = url?.absoluteString else {return}           //convert url sang string
                    
                    Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                        if let err = error {
                            print("DEBUG: \(err.localizedDescription)")
                        } else {
                            let id = authResult?.user.uid
                            print("DEBUG: \(id ?? "123")")
                            let data = ["email": email,
                                        "password": password,
                                        "userName": userName,
                                        "fullName": fullName,
                                        "profileImageURL" : profileImageURL]
                            
                            self.db.collection("users").document().setData(data, completion: completion)
                        }
                    }
                }
            }
        }
    }
}
