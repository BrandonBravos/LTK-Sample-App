//
//  Extensions.swift
//  LTK - Sample App
//
//  Created by Brandon Bravos on 11/17/22.
//

import UIKit


extension UIFont{
    enum MontserratType: String{
        case light = "Montserrat-Light"
        case medium = "Montserrat-Medium"
        case regular = "Montserrat-Regular"
        case bold = "Montserrat-SemiBold"
    }
    
    static func montserratFont(withMontserrat fontType: MontserratType, withSize size: CGFloat)-> UIFont {
        return UIFont(name: fontType.rawValue, size: size)!
    }
}

extension String {
    var capitalizedSentence: String {
        // 1
        let firstLetter = self.prefix(1).capitalized
        // 2
        let remainingLetters = self.dropFirst().lowercased()
        // 3
        return firstLetter + remainingLetters
    }

}

extension UIImage{
    
    func getHeightAspectRatio(withWidth:CGFloat ) -> CGFloat{
        let imageHeight = self.size.height
        let imageWidth = self.size.width
        let ratio = imageHeight / imageWidth

        let desiredWidth = withWidth
        let newHeight = desiredWidth * ratio
        
        return newHeight
        
    }
    
}

extension UIViewController{
    
}

