//
//  MenuItem.swift
//  Little Lemon dinner menu
//
//  Created by Prashan Samarathunge on 2023-07-22.
//

import Foundation


struct MenuItem{
    
    //MARK: TypeAlias
    
    
    //MARK: - Enum
    enum Stars{
        case NoStars
        case Stars(Int)
        
        var description:String{
            switch self{
            case .NoStars:
                return "Not Rated Yet"
            case .Stars(let stars):
                return "Rated with \(stars)"
            }
        }
    }
    
    
    //MARK: - Classes
    
    
    
    //MARK: - Structs
    
    
    
    //MARK: - Constants
    
    
    
    //MARK: - Variables
    var id:Int
    var name:String
    var description:String
    var imageName:String
    var stars:Stars = .NoStars
    var liked:Bool = false
   
    
    
}

extension MenuItem:Equatable{
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MenuItem{
    
    public mutating func likeUnLike(){
        self.liked = !self.liked
    }
    
    public mutating func changeStars(_ stars:Stars){
        self.stars = stars
    }
    
}
