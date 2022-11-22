//
//  TrendingCollectionViewCell.swift
//  LTK - Sample App
//
//  Created by Brandon Bravos on 11/18/22.
//

import UIKit


class TrendingCollectionViewCell: UICollectionViewCell{
    
    static var reuseIdentifier = "TendingCollectionViewCell"
 
    // a list of users that we would get from our model, view model or view controller depending on our architecture (MVC, MVVM, MVP)
    let trends = ["Fashion", "Hair and Beauty", "Home and Decor", "Family"]
    
    var trendsNetwork: [Trends] = []
    
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
             titleLabel.text = "Shop what's trending"
             titleLabel.font = UIFont.montserratFont(withMontserrat: .bold, withSize: 14)
             titleLabel.sizeToFit()
           //  titleLabel.
             addSubview(titleLabel)
             titleLabel.translatesAutoresizingMaskIntoConstraints = false
             NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
                titleLabel.heightAnchor.constraint(equalToConstant: 20)
             ])
             
             trendsNetwork = NetworkManager.shared.getTrendData()
             
            let scrollView = UIScrollView()
             scrollView.contentSize = CGSize(width: CGFloat(trendsNetwork.count) * UIScreen.main.bounds.width / 1.2, height: 100)
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
    
             let colors: [UIColor] = [.systemBlue, .systemPurple, .systemBlue, .systemTeal, .systemRed, .systemOrange]

             var isNewRow:Int = 1
             
            for trend in trendsNetwork {
    
                if leadingAnchor == nil {
                    leadingAnchor = scrollView.leadingAnchor
                }
    
                let trendView = trendView(withTrendName: trend)
                trendView.backgroundColor = colors[isNewRow % 5].withAlphaComponent(0.3)

                scrollView.addSubview(trendView)
                trendView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    trendView.leadingAnchor.constraint(equalTo: leadingAnchor!, constant: 5),
                    trendView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
                    trendView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
                    trendView.widthAnchor.constraint(equalTo: heightAnchor)
                ])
    
                leadingAnchor = trendView.trailingAnchor
                isNewRow += 1
            }
             
             
             bringSubviewToFront(titleLabel)
    
    
        }
    
    
        private func trendView(withTrendName trend: Trends) -> UIView{
            let trendView = UIView()
            
       
            let trendLabel = UILabel()
            trendLabel.backgroundColor = .clear
            trendLabel.text =  trend.trendName
            trendLabel.textAlignment = .left
            trendLabel.font = UIFont.montserratFont(withMontserrat: .regular, withSize: 15)
            trendLabel.sizeToFit()
            trendView.addSubview(trendLabel)
            trendLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                trendLabel.topAnchor.constraint(equalTo: trendView.topAnchor, constant: 10),
                trendLabel.leadingAnchor.constraint(equalTo: trendView.leadingAnchor, constant: 10),
                trendLabel.trailingAnchor.constraint(equalTo: trendView.trailingAnchor),
                trendLabel.heightAnchor.constraint(equalToConstant: 20)
            ])
    
            
            
            let firstImageView = UIImageView()
            firstImageView.image = NetworkManager.shared.getImageFromFile(withName: trend.photosURLS[0])
            firstImageView.backgroundColor = .systemPink
            firstImageView.contentMode = .scaleAspectFill
            firstImageView.clipsToBounds = true
            firstImageView.layer.cornerRadius = 10
            trendView.addSubview(firstImageView)
            firstImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                firstImageView.topAnchor.constraint(equalTo: trendLabel.bottomAnchor, constant: 5),
                firstImageView.bottomAnchor.constraint(equalTo: trendView.bottomAnchor, constant: -10),
                firstImageView.leadingAnchor.constraint(equalTo: trendLabel.leadingAnchor),
                firstImageView.widthAnchor.constraint(equalTo: trendView.heightAnchor, multiplier: 0.65)
            ])
            
            let secondImageView = UIImageView()
            secondImageView.image = NetworkManager.shared.getImageFromFile(withName: trend.photosURLS[1])
            secondImageView.contentMode = .scaleAspectFill
            secondImageView.backgroundColor = .systemPink
            secondImageView.clipsToBounds = true
            secondImageView.layer.cornerRadius = 10
            trendView.addSubview(secondImageView)
            secondImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                secondImageView.topAnchor.constraint(equalTo: trendLabel.bottomAnchor, constant: 5),
                secondImageView.bottomAnchor.constraint(equalTo: firstImageView.centerYAnchor, constant: -5),
                secondImageView.leadingAnchor.constraint(equalTo: firstImageView.trailingAnchor, constant: 5),
                secondImageView.trailingAnchor.constraint(equalTo: trendView.trailingAnchor, constant: -10)
            ])
            
            let thirdImageView = UIImageView()
            thirdImageView.image = NetworkManager.shared.getImageFromFile(withName: trend.photosURLS[2])
            thirdImageView.contentMode = .scaleAspectFill
            thirdImageView.backgroundColor = .systemPink
            thirdImageView.clipsToBounds = true
            thirdImageView.layer.cornerRadius = 10
            trendView.addSubview(thirdImageView)
            thirdImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                thirdImageView.topAnchor.constraint(equalTo: secondImageView.bottomAnchor, constant: 5),
                thirdImageView.bottomAnchor.constraint(equalTo: firstImageView.bottomAnchor),
                thirdImageView.leadingAnchor.constraint(equalTo: firstImageView.trailingAnchor, constant: 5),
                thirdImageView.trailingAnchor.constraint(equalTo: trendView.trailingAnchor, constant: -10)
            ])
    
    
    
            return trendView
    
    
    
        }
    
}


