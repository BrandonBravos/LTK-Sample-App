//
//  FavoritesViewController.swift
//  LTK - Sample App
//
//  Created by Brandon Bravos on 11/17/22.
//

import UIKit

class ProductViewViewController: UIViewController{
    
  

    private let collectionViewHeaderHeight: CGFloat = 55
    
    private var transitionAlpha: CGFloat = 0
    
    private var animationViews: [UIView] = []
    
    private var imagePostFrame: CGRect?
    
    lazy var collectionView: UICollectionView = {
        let layout = PostViewLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    
    private var postImage = UIImage(named: "2")
    
    var transitionImage: UIImageView!
    
    private let catagories: [DisplayCatagories] = [.image, .shopThePic, .moreFromUser]
    
    private let photos = Photo.allPhotos()

    private let colors: [UIColor] = [.systemMint, .systemPink, .green, .orange, .purple]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    
        }
    
    
    @objc func headerBackButtonTapped(){
        print("BB p")
        self.modalTransitionStyle = .crossDissolve
        self.dismiss(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
        
        print(self.imagePostFrame!)
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.transitionImage.layer.cornerRadius = 0
            self.transitionImage.frame = CGRect(x: 6, y: 158, width: UIScreen.main.bounds.width - 12, height: self.postImage!.getHeightAspectRatio(withWidth:  UIScreen.main.bounds.width) - 12)

        }, completion: { _ in

            self.view.layoutIfNeeded() // add this
            self.animateTransitionIn()
        })

    }
    
    func animateTransitionIn(){
        self.transitionAlpha = 1
               UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {

                   for view in self.animationViews{
                       view.alpha = self.transitionAlpha
                       self.view.alpha = self.transitionAlpha
                       self.view.backgroundColor = .white
                   }
       
               }, completion: { _ in
                   self.view.layoutIfNeeded()
                   self.transitionImage.alpha = 0
                   

               })
    }
    

    
    public func beginShowTransition(withImage image: UIImage, withCenter center: CGPoint, withFrame frame: CGRect){
        transitionImage = UIImageView(image: image)
        postImage = image
        transitionImage.clipsToBounds = true
        transitionImage.layer.cornerRadius = 10
        transitionImage.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        transitionImage.center = CGPoint(x: center.x + frame.width/2, y: center.y + frame.height/2)
        view.addSubview(transitionImage)

    }
    
}

// MARK: Delegates
extension ProductViewViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return catagories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch DisplayCatagories.getType(withSection: section){
        case .image:
            return 1
        case .shopThePic:
            return 3
        case .moreFromUser:
            return 5
        }
    }
    

    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        switch DisplayCatagories.getType(withSection: indexPath.section){
        case .image:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
                        cell.configure(withImage: postImage!)
           
            imagePostFrame = cell.imageView.frame
            return cell
            
        case .shopThePic:
            switch indexPath.row{
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductViewSectionHeaderCV.reuseIdentifier, for: indexPath) as! ProductViewSectionHeaderCV
                cell.configure(withTitle: "SHOP THE PIC")
                return cell
            case 1:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlankCollectionViewCell.reuseIdentifier, for: indexPath) as! BlankCollectionViewCell
                return cell
            case 2:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductViewSectionHeaderCV.reuseIdentifier, for: indexPath) as! ProductViewSectionHeaderCV
                cell.configure(withTitle: "MORE FROM THIS USER")
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlankCollectionViewCell.reuseIdentifier, for: indexPath) as! BlankCollectionViewCell
                
                cell.backgroundColor = colors[indexPath.row]
                return cell
            }
    
            
        case .moreFromUser:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
            cell.configure(withImage: photos[indexPath.row].image)
            return cell
        }
        
        
     
    }
    
    
    
}


extension ProductViewViewController: PostViewLayoutDelegate{
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        let width = UIScreen.main.bounds.width
        let desiredWidth = (UIScreen.main.bounds.width / 2) - 10
        
        if indexPath.section == 0{
            return  postImage!.getHeightAspectRatio(withWidth: width)
        }
        
        if indexPath.section == 1{
            let row = indexPath.row
            switch row{
            case 0: return 50
            case 1: return 150
            default: return 100
            }
  
        }
        
        
        
        return  photos[indexPath.row].image.getHeightAspectRatio(withWidth: desiredWidth)
    }
    
    
}


// MARK: Layout
extension ProductViewViewController{
    
    private func setUpView(){
        view.backgroundColor = .clear
        let headearBarHeight: CGFloat = 45
        let headerView = HeaderSearchLabelView(withBackButton: true)
        headerView.backButton.addTarget(self, action: #selector(headerBackButtonTapped), for: .touchDown)
        headerView.backgroundColor = .white
        headerView.searchView.layer.cornerRadius = headearBarHeight / 2
        headerView.isUserInteractionEnabled = true
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headearBarHeight)
        ])
        
        let userTitle = UserFollowHeaderView()
        userTitle.alpha = transitionAlpha
        view.addSubview(userTitle)
        userTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userTitle.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 2),
            userTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userTitle.heightAnchor.constraint(equalToConstant: 55)
        ])
        
        
        let image = UIImage(named: "2")
        let imageWidth = UIScreen.main.bounds.width
        let imageHeight = image!.getHeightAspectRatio(withWidth: imageWidth)

        let postImageView = UIImageView()
        postImageView.alpha = transitionAlpha
        postImageView.image = image
        postImageView.backgroundColor = .blue
        postImageView.contentMode = .scaleAspectFit
        postImageView.clipsToBounds = true
        view.addSubview(postImageView)
        postImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            postImageView.topAnchor.constraint(equalTo: userTitle.bottomAnchor),
            postImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            postImageView.widthAnchor.constraint(equalToConstant: imageWidth),
            postImageView.heightAnchor.constraint(equalToConstant: imageHeight)
        ])
        
        
        if let layout = collectionView.collectionViewLayout as? PostViewLayout {
          layout.delegate = self
        }
        
        collectionView.alpha = transitionAlpha
        collectionView.backgroundColor = .white
        collectionView.register(ProductViewSectionHeaderCV.self, forCellWithReuseIdentifier: ProductViewSectionHeaderCV.reuseIdentifier)
        collectionView.register(BlankCollectionViewCell.self, forCellWithReuseIdentifier: BlankCollectionViewCell.reuseIdentifier)
        collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: userTitle.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
        
        
        animationViews.append(collectionView)
        animationViews.append(userTitle)
        

    }
    
}


// MARK: Cells
class ImageCollectionViewCell: UICollectionViewCell{
    
    let imageView = UIImageView()

    static let reuseIdentifier = "ImageCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
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
    
    func configure(withImage image: UIImage){
        imageView.image = image
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


class ProductViewSectionHeaderCV: UICollectionViewCell{
    
    static let reuseIdentifier = "ProductViewSectionHeaderCV"

    let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.montserratFont(withMontserrat: .light, withSize: 13)
        return label
    }()
    
    
    func configure(withTitle text: String){
        label.text = text
        addSubview(label)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
        

    }
    
    
}


enum DisplayCatagories{
     case image, shopThePic, moreFromUser
    
    /// the icon associated with our enum
    var section: Int {
        switch self {
        case .image:
            return 0
        case .shopThePic:
            return 1
        case .moreFromUser:
            return 2
        }
    }
     
   static func getType(withSection: Int) -> DisplayCatagories{
        switch withSection{
        case 0:
            return .image
        case 1:
            return .shopThePic
        case 2:
            return .moreFromUser
        default:
            return .image
        }
    
    }
    
}
