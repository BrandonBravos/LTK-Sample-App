//
//  CreatorsTableViewCell.swift
//  LTK - Sample App
//
//  Created by Brandon Bravos on 11/17/22.
//

import UIKit

class CreatorsCVCell: UICollectionViewCell{
    
    static var reuseIdentifier = "ScrollViewInCollectioinViewCell"
    
    
    // a list of users that we would get from our model, view model or view controller depending on our architecture (MVC, MVVM, MVP)
    var users: [User] = []
    
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
            setUpView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

        // here we artifically create a collection view.
         func setUpView(){
    
             let titleLabel = UILabel()
             titleLabel.text = "Creators you follow"
             titleLabel.font = UIFont.montserratFont(withMontserrat: .bold, withSize: 14)
             addSubview(titleLabel)
             titleLabel.translatesAutoresizingMaskIntoConstraints = false
             NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: topAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
             ])
             
             NetworkManager.shared.getProfileData{ result in
                 switch result{
                 case .success(let users):
                     self.users = users
                     print("got users")
                default:
                     print("Problem fetchng profiles")
                 }
             }
             
             
            let scrollView = UIScrollView()
             scrollView.contentSize = CGSize(width: users.count * 120, height: 100)
             scrollView.showsHorizontalScrollIndicator = false
            self.addSubview(scrollView)
            scrollView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
                scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
                scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
                scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ])
    
    
    
            // floating anchor for laying out our userViews
            var leadingAnchor: NSLayoutXAxisAnchor?
    
             

            for user in users {
    
                if leadingAnchor == nil {
                    leadingAnchor = scrollView.leadingAnchor
                }
    
                let userView = userView(withUserName: user.name, withImageURL: user.profileImage)
                scrollView.addSubview(userView)
                userView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    userView.leadingAnchor.constraint(equalTo: leadingAnchor!, constant: 5),
                    userView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
                    userView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
                    userView.widthAnchor.constraint(equalToConstant: 100)
                ])
    
                leadingAnchor = userView.trailingAnchor
    
            }
    
    
    
        }
    
    
    
    private func userView(withUserName username: String,  withImageURL: String) -> UIView{
            let userView = UIView()
    
            let userImageSize: CGFloat = 75.0
            let userImageView = UIImageView()
            userImageView.image =  NetworkManager.shared.getImageFromFile(withName: withImageURL)
            userImageView.tintColor = .black
            userImageView.layer.cornerRadius = userImageSize / 2
            userImageView.clipsToBounds = true
            userImageView.backgroundColor = .systemCyan
            userView.addSubview(userImageView)
            userImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                userImageView.topAnchor.constraint(equalTo: userView.topAnchor, constant: 10),
                userImageView.centerXAnchor.constraint(equalTo: userView.centerXAnchor),
                userImageView.widthAnchor.constraint(equalToConstant: userImageSize),
                userImageView.heightAnchor.constraint(equalToConstant: userImageSize)
            ])
    
    
            let usernameLabel = UILabel()
            usernameLabel.text = username
            usernameLabel.textAlignment = .center
            usernameLabel.font = UIFont.montserratFont(withMontserrat: .regular, withSize: 10)
            usernameLabel.sizeToFit()
            userView.addSubview(usernameLabel)
            usernameLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                usernameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 2),
                usernameLabel.leadingAnchor.constraint(equalTo: userView.leadingAnchor),
                usernameLabel.trailingAnchor.constraint(equalTo: userView.trailingAnchor)
    
            ])
    
    
    
    
            return userView
    
    
    
        }
    
}
