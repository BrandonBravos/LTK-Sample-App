//
//  CollectionFeedCell.swift
//  LTK - Sample App
//
//  Created by Brandon Bravos on 11/18/22.
//

import UIKit

protocol ProductViewDelegate{
    func didTapProductView(withImage image: UIImage, withCenter center: CGPoint, withFrame: CGRect)
}

class CollectionFeedCell: UICollectionViewCell{
    
    
    static var reuseIdentifier = "CollectionFeedCell"
    
    private let titleLabel = UILabel()
    
   public var delegate: ProductViewDelegate?

    private var totalHeight = 0.0
    
    var imageViews : [UIImageView] = []

    // a list of users that we would get from our model, view model or view controller depending on our architecture (MVC, MVVM, MVP)
    let photos = ["fashionista", "therealworldme", "livelaughplay", "ineedaniosjob", "lookthebestyou"]
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
            setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public func setTitle(withTitle title: String){
        titleLabel.text = title
    }
    
    
    
    @objc func didTapPhoto(_ sender: UITapGestureRecognizer){
        
        guard delegate != nil else{
            print("No delegate found on CollectionCVFeedCell")
            return
        }
        
        let globalPoint =  imageViews[sender.view!.tag].superview?.convert( imageViews[sender.view!.tag].frame.origin, to: nil)

        delegate?.didTapProductView(withImage: imageViews[sender.view!.tag].image!, withCenter: globalPoint!, withFrame: imageViews[sender.view!.tag].frame)

        
        
    }
    
    
    private func setUpView(){

         titleLabel.text = "New from creators you follow"
         titleLabel.font = UIFont.montserratFont(withMontserrat: .bold, withSize: 14)
         addSubview(titleLabel)
         titleLabel.translatesAutoresizingMaskIntoConstraints = false
         NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8)
         ])
         

         let colors: [UIColor] = [.red, .green, .blue, .purple, .orange, .red]

        // floating anchor for laying out our userViews
        var currentLeadingAnchor: NSLayoutXAxisAnchor?
        var columnOneTopAnchor: NSLayoutYAxisAnchor = titleLabel.bottomAnchor
        var columnTwoTopAnchor: NSLayoutYAxisAnchor = titleLabel.bottomAnchor


         var isNewRow:Int = 1
         
         var topConstant:CGFloat = 5
         
        let feedPhoto = Photo.allPhotos()
        
        let desiredWidth =  UIScreen.main.bounds.width / 2 - 10
        
        var index = 0
        for _ in photos {
            
            if currentLeadingAnchor == nil{
                currentLeadingAnchor = leadingAnchor
            }
            
            topConstant = isNewRow <= 2 ? 25 : 5
            
            let currentTopAnchor = isNewRow.isMultiple(of: 2) ? columnTwoTopAnchor : columnOneTopAnchor
            
            
            let photoView = UIImageView()
            imageViews.append(photoView)
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapPhoto(_:)))
            photoView.tag = index
            index += 1
            photoView.isUserInteractionEnabled = true
            photoView.addGestureRecognizer(tapGestureRecognizer)
            
            
            photoView.clipsToBounds = true
            photoView.layer.cornerRadius = 10
            photoView.image = feedPhoto[isNewRow - 1].image
            photoView.contentMode = .scaleAspectFit
            photoView.layer.cornerRadius = 10
            photoView.backgroundColor = colors[isNewRow % 5]
            
            photoView.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(didTapPhoto)))
            
            let photoHeight = photoView.image?.getHeightAspectRatio(withWidth: desiredWidth)

            addSubview(photoView)
            photoView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                photoView.topAnchor.constraint(equalTo: currentTopAnchor, constant: topConstant),
                photoView.leadingAnchor.constraint(equalTo: currentLeadingAnchor!, constant: 5),
                photoView.widthAnchor.constraint(equalToConstant: desiredWidth),
                photoView.heightAnchor.constraint(equalToConstant: photoHeight!),

            ])
            
            totalHeight += photoHeight! + 10.0
            
            isNewRow += 1
            
            if isNewRow.isMultiple(of: 2){
                currentLeadingAnchor = photoView.trailingAnchor
                columnOneTopAnchor = photoView.bottomAnchor

            } else {
                currentLeadingAnchor = leadingAnchor
                columnTwoTopAnchor = photoView.bottomAnchor
            }
        }
    }

}


