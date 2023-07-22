//
//  Menu.swift
//  Little Lemon dinner menu
//
//  Created by Prashan Samarathunge on 2023-07-22.
//

import Foundation

class Menu{
    //MARK: TypeAlias
    
    
    //MARK: - Enum
    enum MenuErrors:Error{
        case ItemAlreadyExists
        case CannotFindThatItem
    }
    
    
    //MARK: - Classes
    
    
    
    //MARK: - Structs
    
    
    
    //MARK: - Constants
    
    
    
    //MARK: - Variables
    private(set) var menuItems:[MenuItem] = []
    
}

extension Menu{
    
    public func addMenuItem(_ menuItem: MenuItem) throws{
        if menuItems.contains(menuItem){
            throw MenuErrors.ItemAlreadyExists
        }else{
            menuItems.append(menuItem)
        }
    }
    
    public func removeMenuItem(menuItemId:Int) throws{
        if let index = menuItems.firstIndex(where: { $0.id == menuItemId}) {
            
        }else{
            throw MenuErrors.CannotFindThatItem
        }
    }
}

