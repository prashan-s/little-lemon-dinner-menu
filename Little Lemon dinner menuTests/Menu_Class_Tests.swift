//
//  Menu_Class_Tests.swift
//  Little Lemon dinner menuTests
//
//  Created by Prashan Samarathunge on 2023-07-22.
//

import XCTest
@testable import Little_Lemon_dinner_menu

final class Menu_Class_Tests: XCTestCase {

    var sut:Menu!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.sut = self.makeSut()
    }
    
    func makeSut() -> Menu{
        let menu = Menu(menuItems: [
            .init(id: 1, name: "Test1", description: "TestDesc1", imageName: "TestImgName1"),
            .init(id: 2, name: "Test2", description: "TestDesc2", imageName: "TestImgName2"),
            .init(id: 3, name: "Test3", description: "TestDesc3", imageName: "TestImgName3"),
            .init(id: 4, name: "Test4", description: "TestDesc4", imageName: "TestImgName4"),
            
        ])
        
    
        
        
        return menu
    }
    
    func test_Menu_AddMenuItem_Success(){
        let item = MenuItem(id: 5, name: "Rice", description: "Delicious", imageName: "RiceImg")
        
        XCTAssertFalse( sut.menuItems.contains(item))
        try! sut.addMenuItem(item)
        XCTAssert( sut.menuItems.contains(item))
    }
    
    func test_Menu_AddMenuItem_Fails(){
        let item = MenuItem(id: 1, name: "Rice", description: "Delicious", imageName: "RiceImg")
        
        XCTAssert( sut.menuItems.contains(item))
        do{
            try sut.addMenuItem(item)
        }catch Menu.MenuErrors.ItemAlreadyExists{
            XCTAssert(true)
            return
        }catch{
            
        }
        XCTAssert(false)
    }
    
    func test_Menu_RemoveMenuItem_Success(){
        
        do{
            try sut.removeMenuItem(menuItemId: 1)
        }catch Menu.MenuErrors.ItemAlreadyExists{
            XCTAssert(false)
            return
        }catch{
            
        }
        XCTAssertFalse(sut.menuItems.contains(where: {$0.id == 1}))
    }
    
    
    func test_Menu_RemoveMenuItem_Fails(){
        
        do{
            try sut.removeMenuItem(menuItemId: 5)
        }catch Menu.MenuErrors.CannotFindThatItem{
            XCTAssert(true)
            return
        }catch{
            
        }
        XCTAssert(false)
    }
}
