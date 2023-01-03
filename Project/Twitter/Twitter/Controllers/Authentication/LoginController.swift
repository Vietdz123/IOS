//
//  LoginController.swift
//  Twitter
//
//  Created by Long Bảo on 03/01/2023.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Selectors:
    @objc func handleLoginButton() {
        print("handle login")
    }
    
    @objc func handleShowSignUp() {
        print("abc")
        let registratrionVC = RegistrationController()
        self.navigationController?.pushViewController(registratrionVC, animated: true)
    }
    
    
    
    // MARK: Properties

    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "TwitterLogo")
        //imageView.clipsToBounds = true                    //Cái này để làm gì
        return imageView
    }()
    
    private let emailView : UIView = {
        let textFiled = Utilities().configureTextField(withPlaceholder: "Email")
        let image = UIImage(named: "ic_mail_outline_white_2x-1")
    
        let view = Utilities().inputContainerView(textFiled: textFiled, image: image!)
        
        return view
    }()
    
    private let passwordView : UIView = {
        let textFiled = Utilities().configureTextField(withPlaceholder: "Password")
        let image = UIImage(named: "ic_lock_outline_white_2x")
        //textFiled.isSecureTextEntry = true
        let view = Utilities().inputContainerView(textFiled: textFiled, image: image!)
        return view
    }()
    
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
