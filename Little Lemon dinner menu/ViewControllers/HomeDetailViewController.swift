//
//  HomeDetailViewController.swift
//  Little Lemon dinner menu
//
//  Created by Prashan Samarathunge on 2023-07-22.
//

import UIKit

class HomeDetailViewController: UIViewController {

    //MARK: TypeAlias
    
    
    //MARK: - Enum
    
    
    
    //MARK: - Classes
    
    
    
    //MARK: - Structs
    
    
    
    //MARK: - Constants
    
    
    
    //MARK: - Variables
    var menuItem:MenuItem!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRatings: UILabel!
    @IBOutlet weak var lblLiked: UILabel!
    
    //MARK: - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    
    
    
    //MARK: - VC Life Cycle

    override func viewDidLoad() {
        self.imageView.image = .init(named: menuItem.imageName)
        
        self.lblName.text = menuItem.name
        self.lblDescription.text = menuItem.description
        self.lblPrice.text = "$ " + String(menuItem.price)
        self.lblRatings.text = menuItem.stars.description
        self.lblLiked.text = menuItem.liked ? "Liked" : "Not Liked"
    }
    
  
    
}
