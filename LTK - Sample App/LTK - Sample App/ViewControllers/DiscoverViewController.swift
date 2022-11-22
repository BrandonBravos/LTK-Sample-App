//
//  DiscoverViewController.swift
//  LTK - Sample App
//
//  Created by Brandon Bravos on 11/17/22.
//

import UIKit

class DiscoverViewController: UIViewController{

    lazy var collectionView: UICollectionView = {
        let layout = DiscoverLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    var photos = Photo.allPhotos()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        if let layout = collectionView.collectionViewLayout as? DiscoverLayout {
          layout.delegate = self
        }
        
        
        collectionView.register(ImageCVCell.self, forCellWithReuseIdentifier: ImageCVCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    


}


// MARK: Delegates
extension DiscoverViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
 

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tapped")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCVCell.reuseIdentifier, for: indexPath) as! ImageCVCell
        cell.imageView.image = photos[indexPath.row].image
        return cell
    }
    
    
}


extension DiscoverViewController: DiscoverLayoutDelegate {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
      let desiredWidth = (UIScreen.main.bounds.width / 2) - 10
      
      
      return photos[indexPath.row].image.getHeightAspectRatio(withWidth: desiredWidth)
  }
    
}

class ImageCVCell:UICollectionViewCell{
    
    var imageView = UIImageView()
    
    static let reuseIdentifier = "ImageCVCCell"
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),

        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
