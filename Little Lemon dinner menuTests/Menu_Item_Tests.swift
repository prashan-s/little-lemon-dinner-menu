//
//  Little_Lemon_dinner_menuTests.swift
//  Little Lemon dinner menuTests
//
//  Created by Prashan Samarathunge on 2023-07-22.
//

import XCTest
@testable import Little_Lemon_dinner_menu

final class Menu_Item_Tests: XCTestCase {
    
    
    var sut:MenuItem!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.sut = self.makeSut()
    }
    
    func makeSut() -> MenuItem{
        let item = MenuItem(id: 1,
                            name: "Test",
                            description: "TestDes",
                            imageName: "TestImg")
        
        return item
    }
    
    func test_menuItem_Init(){
       
        guard let item = sut else {return}
        
        XCTAssert(item.id == 1)
        XCTAssert(item.name == "Test")
        XCTAssert(item.description == "TestDes")
        XCTAssert(item.imageName == "TestImg")
        
    }
    
    func test_menuItem_changeLikeToggle_True(){
        
        guard var item = sut else {return}
        
        XCTAssert(item.liked == false)
        
        item.likeUnLike()
        
        XCTAssert(item.liked == true)
    }
    
    func test_menuItem_changeLikeToggle_False(){
        
        guard var item = sut else {return}
        item.liked = true
        
        item.likeUnLike()
        
        XCTAssert(item.liked == false)
    }
    
    
  
}
