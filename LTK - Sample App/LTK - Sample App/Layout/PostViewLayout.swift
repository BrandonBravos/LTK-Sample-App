//
//
//  Created by Brandon Bravos on 11/21/22.
//

import UIKit

protocol PostViewLayoutDelegate: AnyObject {
  func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat
}

class PostViewLayout: UICollectionViewLayout {
  // 1
  weak var delegate: PostViewLayoutDelegate?

  // 2
  private let numberOfColumns = 2
  private let cellPadding: CGFloat = 6

  // 3
  private var cache: [UICollectionViewLayoutAttributes] = []

  // 4
   private var contentHeight: CGFloat = 0

    
   private var floatingYHeight: CGFloat = 0
    
  private var contentWidth: CGFloat {
    guard let collectionView = collectionView else {
      return 0
    }
    let insets = collectionView.contentInset
    return collectionView.bounds.width - (insets.left + insets.right)
  }

  // 5
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func prepare() {
     guard let collectionView = collectionView
      else {
        return
    }
      // 0: first section: Image + Post description + tags
      
      for item in 0..<collectionView.numberOfItems(inSection: 0) {
        let indexPath = IndexPath(item: item, section: 0)

      
          let photoHeight = delegate?.collectionView(
            collectionView,
            heightForPhotoAtIndexPath: indexPath) ?? 180
          
          let height = photoHeight
          
          let frame = CGRect(x: 0.0,
                             y: 0.0,
                         width: UIScreen.main.bounds.width,
                         height: height)
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
          floatingYHeight = insetFrame.maxY
     
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = insetFrame
      cache.append(attributes)
          
      }
      
      // 1: second section: Shop The Post

      for item in 0..<collectionView.numberOfItems(inSection: 1) {
        let indexPath = IndexPath(item: item, section: 1)

      
          let photoHeight = delegate?.collectionView(
            collectionView,
            heightForPhotoAtIndexPath: indexPath) ?? 180
          
          let height = photoHeight
          
          let frame = CGRect(x: 0.0,
                             y: floatingYHeight,
                         width: UIScreen.main.bounds.width,
                         height: height)
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
          floatingYHeight = insetFrame.maxY

     
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = insetFrame
      cache.append(attributes)
          
      }
   
    
    // 2
    let columnWidth = contentWidth / CGFloat(numberOfColumns)
    var xOffset: [CGFloat] = []
    for column in 0..<numberOfColumns {
      xOffset.append(CGFloat(column) * columnWidth)
    }
    var column = 0
    var yOffset: [CGFloat] = .init(repeating: floatingYHeight, count: numberOfColumns)
      
    // 3
    for item in 0..<collectionView.numberOfItems(inSection: 2) {
      let indexPath = IndexPath(item: item, section: 2)
        
      // 4
      let photoHeight = delegate?.collectionView(
        collectionView,
        heightForPhotoAtIndexPath: indexPath) ?? 180
      let height = cellPadding * 2 + photoHeight
      let frame = CGRect(x: xOffset[column],
                         y: yOffset[column],
                         width: columnWidth,
                         height: height)
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
        
      // 5
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      attributes.frame = insetFrame
      cache.append(attributes)
        
      // 6
      contentHeight = max(contentHeight, frame.maxY)
      yOffset[column] = yOffset[column] + height
        
      column = column < (numberOfColumns - 1) ? (column + 1) : 0
    }
    
      
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []
    
    // Loop through the cache and look for items in the rect
    for attributes in cache {
      if attributes.frame.intersects(rect) {
        visibleLayoutAttributes.append(attributes)
      }
    }
    return visibleLayoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[indexPath.item]
  }
    
}
