//
//  RegistrationController.swift
//  Twitter
//
//  Created by Long Bảo on 03/01/2023.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import FirebaseCoreInternal
import FirebaseStorage

class RegistrationController: UIViewController {
    
    //MARK: - Selectors:
    @objc func addPhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func handleShowLogin() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func handleShowSignUp() {
        guard let email = emailTextFiled.text else {return}
        guard let password = passwordTextFiled.text else {return}
        guard let userName = userNameTextFiled.text else {return}
        guard let fullName = fullNameTextFiled.text else {return}

        let authCredial = AuthCrentials(email: email, password: password, fullName: fullName, userName: userName, imageProfile: imageProfile)
        
        AuthService.shared.registerUser(authCretical: authCredial) { err in
            if let err = err {
                print("DEBUG: Error writing document: \(err)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
        

    }
    
    
    
    //MARK: - Properties
    
    //imagePicker: UIImagePickerController để mở cái thư viện ảnh lên
    private let imagePicker = UIImagePickerController()
    private var imageProfile = UIImage()
    let db = Firestore.firestore()
    
    //Image plus
    private lazy var plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)     //Phải xét .system thì tincolor mới có tác dụng
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        return button
    }()
    
    //email
    private lazy var emailTextFiled : UITextField = {
        let textFiled = Utilities().configureTextField(withPlaceholder: "Email")
        return textFiled
    }()
    
    private lazy var emailView : UIView = {

        let image = UIImage(named: "ic_mail_outline_white_2x-1")
    
        let view = Utilities().inputContainerView(textFiled: emailTextFiled, image: image!)
        
        return view
    }()
    

    
    //password
    private lazy var passwordTextFiled : UITextField = {
        let textFiled = Utilities().configureTextField(withPlaceholder: "Password")
        return textFiled
    }()
    
    private lazy var passwordView : UIView = {

        let image = UIImage(named: "ic_lock_outline_white_2x")
        //textFiled.isSecureTextEntry = true
        let view = Utilities().inputContainerView(textFiled: passwordTextFiled, image: image!)
        return view
    }()
    
    //FullName
    private lazy var fullNameTextFiled : UITextField = {
        let textFiled = Utilities().configureTextField(withPlaceholder: "Full Name")
        return textFiled
    }()
    
    private lazy var fullNameView : UIView = {
        let image = UIImage(named: "ic_person_outline_white_2x")
        //textFiled.isSecureTextEntry = true
        let view = Utilities().inputContainerView(textFiled: fullNameTextFiled, image: image!)
        return view
    }()
    
    
    //UserName
    private lazy var userNameTextFiled : UITextField = {
        let textFiled = Utilities().configureTextField(withPlaceholder: "User Name")
        return textFiled
    }()
        private lazy var userNameView : UIView = {

        let image = UIImage(named: "ic_person_outline_white_2x")
        //textFiled.isSecureTextEntry = true
        let view = Utilities().inputContainerView(textFiled: userNameTextFiled, image: image!)
        return view
    }()
    
    //sign up
    var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.tintColor = .twitterBlue
        button.backgroundColor = .white
        button.setTitle("Sign Up", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    
    //Already button
    var alreadyHaveAnAccountButton: UIButton = {
        let button = Utilities().attributedButton("Already have an account?", " Log In")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    //MARK: - Helpers
    
    func configureUI() {
        navigationItem.hidesBackButton = true
        view.backgroundColor = .twitterBlue
        imagePicker.delegate = self           //delegate ImagePicker
        imagePicker.allowsEditing = true      //delegate ImagePicker
        //imagePicker.sourceType = .photoLibrary
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        plusPhotoButton.setDimensions(width: 150, height: 150)
        
        let stackView = UIStackView(arrangedSubviews: [emailView,
                                                       passwordView,
                                                       fullNameView,
                                                       userNameView,
                                                       signUpButton])

        stackView.spacing = 18
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor ,paddingTop: 20, paddingLeft: 15, paddingRight: 15)
        
        
        view.addSubview(alreadyHaveAnAccountButton)
        alreadyHaveAnAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,  paddingLeft: 40 , paddingRight: 40)
    }
    
    

}


// MARRK: - Extension  -- Xem lại các thuộc tính UI
extension RegistrationController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileName = info[.editedImage] as? UIImage else {return}
        
        imageProfile = profileName
        plusPhotoButton.layer.cornerRadius = 150/2
        plusPhotoButton.layer.masksToBounds = true  //Bo tròn button à :))) maybe
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        
        self.plusPhotoButton.setImage(profileName.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true, completion: nil)
    }
}
