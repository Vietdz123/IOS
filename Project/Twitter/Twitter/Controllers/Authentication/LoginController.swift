//
//  LoginController.swift
//  Twitter
//
//  Created by Long Bảo on 03/01/2023.
//

import UIKit
import FirebaseAuth
import FirebaseCore

class LoginController: UIViewController {
    
    //MARK: - Selectors:
    @objc func handleLoginButton() {
        guard let email = emailTextFiled.text else {return}
        guard let password = passwordTextFiled.text else {return}
        
        AuthService.shared.login(email: email, password: password) { authResult, err in
            if let err = err {
                print("DEBUG: \(err.localizedDescription)")
            } else {
                let mainTabBarController = MainTabBarController()
                mainTabBarController.modalPresentationStyle = .fullScreen
                DispatchQueue.main.async {
                    self.present(mainTabBarController, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc func handleShowSignUp() {
        let registratrionVC = RegistrationController()
        self.navigationController?.pushViewController(registratrionVC, animated: true)
    }
    
    
    
    // MARK: Properties

    //Logo
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "TwitterLogo")
        //imageView.clipsToBounds = true                    //Cái này để làm gì
        return imageView
    }()
    
    //Email
    private lazy var emailTextFiled : UITextField = {
        let textFiled = Utilities().configureTextField(withPlaceholder: "Email")
        return textFiled
    }()
    
    private lazy var emailView : UIView = {
        let image = UIImage(named: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(textFiled: emailTextFiled, image: image!)
        return view
    }()
    
    //Password
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
    
    
    //LoginButton
    var loginButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.tintColor = .twitterBlue
        button.backgroundColor = .white
        button.setTitle("Log In", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 5
        button.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()
    
    
    //DontHaveAccount
    var dontHaveAnAccountButton: UIButton = {
        let button = Utilities().attributedButton("Don't have an account?", " Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()
    

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    


    func configureUI() {
        view.backgroundColor = .twitterBlue
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0)
        logoImageView.setDimensions(width: 150, height: 150)
        
        let stackView = UIStackView(arrangedSubviews: [emailView, passwordView, loginButton])

        stackView.spacing = 18
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor ,paddingTop: 20, paddingLeft: 15, paddingRight: 15)
        
        view.addSubview(dontHaveAnAccountButton)
        dontHaveAnAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,  paddingLeft: 40 , paddingRight: 40)
    }

}
