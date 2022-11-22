//
//  UserFollowHeaderView.swift
//  LTK - Sample App
//
//  Created by Brandon Bravos on 11/21/22.
//

import UIKit

class UserFollowHeaderView: UIView {
    
    let userImage = UIImage(named: "2")
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        setUpView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setUpView(){
  
    let profileImageView = UIImageView(image: userImage)
       profileImageView.backgroundColor = .systemMint
       profileImageView.clipsToBounds = true
       profileImageView.layer.cornerRadius = 35.0 / 2
       addSubview(profileImageView)
       profileImageView.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
        profileImageView.widthAnchor.constraint(equalToConstant: 35),
        profileImageView.heightAnchor.constraint(equalToConstant: 35),

       ])
       
       let userLabel = UILabel()
       userLabel.text = "thetrendytrender"
       userLabel.sizeToFit()
       userLabel.font = UIFont.montserratFont(withMontserrat: .bold, withSize: 15)
       addSubview(userLabel)
       userLabel.translatesAutoresizingMaskIntoConstraints = false
       NSLayoutConstraint.activate([
        userLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        userLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
        
       
       ])
    }
    
    

    
    
}
