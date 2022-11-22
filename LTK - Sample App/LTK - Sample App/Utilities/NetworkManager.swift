//
//  NetworkManager.swift
//  LTK - Sample App
//
//  Created by Brandon Bravos on 11/18/22.
//

import UIKit

struct User{
    let name: String
    let profileImage: String
    
}

struct Trends{
    let trendName: String
    let photosURLS:[String]
}

final class NetworkManager: NSObject{
    
    static let shared = NetworkManager()
    

    func getProfileData(completed: @escaping (Result<[User], Error>) -> Void){
        let users:[User] = [
            User(name: "fashionista", profileImage: "profile0"),
            User(name: "therealworldme", profileImage: "profile1"),
            User(name: "livelaughplay", profileImage: "profile2"),
            User(name: "edgeyfits", profileImage: "profile3"),
            User(name: "lookthebestyou", profileImage: "profile4"),

        ]

        completed(.success(users))

    }
    
    func getTrendData() -> [Trends]{
        let urls = ["trend0","trend1","trend2"]

        let trends = [
            Trends(trendName: "Fashion", photosURLS: urls),
            Trends(trendName: "Hair and Beauty", photosURLS: urls),
            Trends(trendName: "Home and Decor", photosURLS: urls),
            Trends(trendName: "Family", photosURLS: urls)
        ]
      
        return trends
        
    }
    
    func getFeedData() -> [UIImage]{
        let images = [
            getImageFromFile(withName: "feed0"),
            getImageFromFile(withName: "feed1"),
            getImageFromFile(withName: "feed2"),
            getImageFromFile(withName: "feed3"),
            getImageFromFile(withName: "feed4"),
        ]
        
        return images
    }
    func getImageFromFile(withName name:String) -> UIImage{
       
        if let image = UIImage(named: name) {
               return image
            }
        
        print("something went wrong: \(name)")
        return UIImage(named: "heart_icon")!
    }
}
