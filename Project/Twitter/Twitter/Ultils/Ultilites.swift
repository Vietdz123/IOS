//
//  Ultilites.swift
//  Twitter
//
//  Created by Long Bảo on 03/01/2023.
//

import Foundation
import UIKit

class Utilities {
    func inputContainerView(textFiled: UITextField, image: UIImage) -> UIView {
        let paddingLeft = CGFloat(15)
        let view = UIView()
        let iv = UIImageView()
        let divider = UIView()
        
        iv.image = image
        divider.backgroundColor = .white
        view.addSubview(iv)
        view.addSubview(textFiled)
        view.addSubview(divider)
        
        iv.anchor(left: view.leftAnchor, bottom: view.bottomAnchor,  paddingLeft: paddingLeft, paddingBottom: 6, width: 24 ,height: 24)
        textFiled.anchor(left: iv.rightAnchor, bottom: view.bottomAnchor, right: view.rightAnchor  ,paddingLeft:  paddingLeft, paddingBottom: 6, paddingRight: 10, width: 24 ,height: 24)
        divider.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor  ,paddingLeft:  paddingLeft, paddingBottom: -2, paddingRight: 10 ,height: 1)
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        return view
    }
    
    
    func configureTextField(withPlaceholder placehoder: String) -> UITextField {
        let textFiled = UITextField()
        textFiled.textColor = .white
        textFiled.font = UIFont.systemFont(ofSize: 16)
        textFiled.attributedPlaceholder = NSAttributedString(string: placehoder, attributes: [.foregroundColor: UIColor.white])
        return textFiled
    }
    
    func attributedButton(_ firstPart: String, _ secondPart: String) -> UIButton {
        let button = UIButton(type: .system)
        //button.backgroundColor = .none
        
        /* Ghép 2 chuỗi string có thuộc tính khác nhau, như kia là cũng chữ trắng, nhưng khác size */
        let attributedTitle = NSMutableAttributedString(string: firstPart, attributes: [NSMutableAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white])
        
        attributedTitle.append(NSAttributedString(string: secondPart, attributes: [NSMutableAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18), .foregroundColor: UIColor.white]))
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        return button
    }
}
