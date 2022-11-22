//
//  ViewController.swift
//  LTK - Sample App
//
//  Created by Brandon Bravos on 11/17/22.
//

import UIKit




class HomeViewController: UIViewController{
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    

    var heightForCell = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    


}


// MARK: Delegates
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = UIScreen.main.bounds.width

        switch indexPath.row {
        case 0:
            return CGSize(width: width, height: 150)
        case 1:
            return CGSize(width: width, height: width / 1.3)
        case 2:
            return CGSize(width: width, height: 4 * (width / 2))
        case 3:
            return CGSize(width: width, height: 4 * (width / 2))
        default:
            return CGSize(width: width, height: 150)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        print("you tapped the cell")
//        coordinatinor?.eventOccured(with: .productViewController)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if indexPath.row ==  0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreatorsCVCell.reuseIdentifier, for: indexPath) as! CreatorsCVCell
            
            return cell
        }
        if indexPath.row ==  1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.reuseIdentifier, for: indexPath) as! TrendingCollectionViewCell
            
            return cell
        }
        if indexPath.row ==  2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionFeedCell.reuseIdentifier, for: indexPath) as! CollectionFeedCell
            cell.setTitle(withTitle: "New from creators you follow")
            cell.delegate = self
            return cell
        }
        if indexPath.row ==  3{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionFeedCell.reuseIdentifier, for: indexPath) as! CollectionFeedCell
            cell.setTitle(withTitle: "For You: Posts we think you'll like")
  
            return cell
        }else {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BlankCollectionViewCell.reuseIdentifier, for: indexPath) as! BlankCollectionViewCell
        
        return cell
        }
    }
    
    
}


extension HomeViewController: ProductViewDelegate{
    func didTapProductView(withImage image: UIImage, withCenter center: CGPoint, withFrame: CGRect) {
        print("attempting to push \(withFrame)")
        
    
        let vc = ProductViewViewController()
        vc.modalPresentationStyle = .overCurrentContext
        navigationController?.present(vc, animated: false)
        vc.beginShowTransition(withImage: image, withCenter: center, withFrame: withFrame)
    }

}

// MARK: Layout
extension HomeViewController {
    
    private func setUpView(){
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        
        
        let headearBarHeight: CGFloat = 45
        let headerView = HeaderSearchLabelView()
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
        
        
        collectionView.register(CreatorsCVCell.self, forCellWithReuseIdentifier: CreatorsCVCell.reuseIdentifier)
        collectionView.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCollectionViewCell.reuseIdentifier)
        collectionView.register(CollectionFeedCell.self, forCellWithReuseIdentifier: CollectionFeedCell.reuseIdentifier)
        collectionView.register(BlankCollectionViewCell.self, forCellWithReuseIdentifier: BlankCollectionViewCell.reuseIdentifier)
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 25),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)

        ])
        
        
    }
    
    
}




class BlankCollectionViewCell: UICollectionViewCell{
    static let reuseIdentifier = "BlankCollectionViewCell"
}


